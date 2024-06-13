// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet/bloc/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wallet_event.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  final TxRepository txRepository;
  final AddressRepository addressRepository;
  final SeedRepository seedRepository;
  final BBLogger logger;
  Timer? _loadWalletsTimer;

  WalletBloc({
    required this.walletRepository,
    required this.seedRepository,
    required this.txRepository,
    required this.addressRepository,
    required this.logger,
    required wallet,
  }) : super(WalletState.initial()) {
    on<LoadWallet>(_onLoadWallet);
    on<SyncWallet>(_onSyncWallet);
    on<PersistWallet>(_onPersistWallet);

    _loadWalletsTimer = Timer.periodic(
        const Duration(minutes: WALLET_SYNC_INTERVAL_MINS), (timer) {
      add(SyncWallet());
    });

    logger.log('WalletBloc :: Init');

    add(LoadWallet(wallet: wallet));
  }

  @override
  Future<void> close() {
    _loadWalletsTimer?.cancel();
    return super.close();
  }

  void _onLoadWallet(LoadWallet event, Emitter<WalletState> emit) async {
    emit(state.copyWith(wallet: event.wallet));
  }

  void _onSyncWallet(SyncWallet event, Emitter<WalletState> emit) async {
    try {
      logger.log('WalletBloc :: SyncWallet');
      emit(state.copyWith(status: LoadStatus.loading));
      await Future.delayed(const Duration(seconds: 1));

      final (seed, _) =
          await seedRepository.loadSeed(state.wallet!.seedFingerprint);
      final loadedWallet =
          await walletRepository.loadNativeSdk(state.wallet!, seed!);

      emit(state.copyWith(wallet: loadedWallet));

      final syncedWallet = await Wallet.syncWallet(loadedWallet);

      print('Sync :: processTxs :: w.id');
      final (txs, err) = await txRepository.syncTxs(syncedWallet);
      if (err != null) {
        addError(err);
      }
      await txRepository.persistTxs(syncedWallet, txs!);

      print('Sync :: processAddress :: w.id');
      // TODO: Pass old address
      final (depositAddresses, depositErr) = await addressRepository
          .syncAddresses(txs, [], AddressKind.deposit, syncedWallet);
      if (depositErr != null) {
        addError(depositErr);
      }
      await addressRepository.persistAddresses(syncedWallet, depositAddresses!);

      // TODO: Pass old address
      final (changeAddresses, changeErr) = await addressRepository
          .syncAddresses(txs, [], AddressKind.change, syncedWallet);
      if (changeErr != null) {
        addError(changeErr);
      }
      await addressRepository.persistAddresses(syncedWallet, changeAddresses!);

      await walletRepository.persistWallet(syncedWallet);

      emit(state.copyWith(status: LoadStatus.success, wallet: syncedWallet));
      print('OnSyncAllWallets: DONE');
    } catch (error, stackTrace) {
      addError(error, stackTrace);
    }
  }

  void _onPersistWallet(PersistWallet event, Emitter<WalletState> emit) async {
    logger.log('WalletBloc :: PersistWallet');
    emit(state.copyWith(status: LoadStatus.loading));
    // await Future.delayed(const Duration(milliseconds: 10000));
    await walletRepository.persistWallet(event.wallet);
    emit(state.copyWith(status: LoadStatus.success));
  }

  // @override
  // void onError(Object error, StackTrace stackTrace) {
  //   if (error is WalletLoadException) {
  //     emit(state.copyWith(
  //         status: LoadStatus.failure, error: error.error as Error));
  //     logger.error(error.error.toString(), stackTrace);
  //     // _showErrorDialog(context, error.error as Error);
  //     super.onError(error.error, stackTrace);
  //   } else if (error is JsonParseException) {
  //     emit(state.copyWith(
  //         status: LoadStatus.failure, error: error.error as Error));
  //     logger.error('ParseException (${error.modal}): ${error.error.toString()}',
  //         stackTrace);
  //     // _showErrorDialog(context, error.error as Error);
  //     super.onError(error.error, stackTrace);
  //   } else if (error is BdkElectrumException) {
  //     emit(state.copyWith(
  //         status: LoadStatus
  //             .failure)); // TODO: How to set error, when I get Exception or change the state to hold Exception
  //     logger.error(
  //         'BdkElectrumException ${error.serverUrl ?? ''}: ${error.error.toString()}',
  //         stackTrace);
  //     // _showErrorDialog(context, error.error as Error);
  //     super.onError(error.error, stackTrace);
  //   } else {
  //     logger.error(error.toString(), stackTrace);
  //     super.onError(error, stackTrace);
  //   }
  // }

  // void _showErrorDialog(BuildContext context, Error error) {
  // showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //     title: const Text("Error"),
  //     content: Text(error.toString()),
  //     actions: <Widget>[
  //       ElevatedButton(
  //         child: const Text("OK"),
  //         onPressed: () => Navigator.of(context).pop(),
  //       ),
  //     ],
  //   ),
  // );
}
