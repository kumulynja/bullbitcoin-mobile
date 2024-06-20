// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/constants.dart';
import 'package:bb_arch/_pkg/error.dart';
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
  Timer? _loadWalletsTimer;

  WalletBloc({
    required this.walletRepository,
    required this.seedRepository,
    required this.txRepository,
    required this.addressRepository,
    required wallet,
  }) : super(WalletState.initial()) {
    on<LoadWallet>(_onLoadWallet);
    on<SyncWallet>(_onSyncWallet);
    on<PersistWallet>(_onPersistWallet);
    on<BuildTx>(_onBuildTx);
    on<WalletBlocClearError>(
        (WalletBlocClearError event, Emitter<WalletState> emit) {
      emit(state.copyWith(error: null));
    });

    _loadWalletsTimer = Timer.periodic(
        const Duration(minutes: WALLET_SYNC_INTERVAL_MINS), (timer) {
      add(SyncWallet());
    });

    BBLogger().logBloc('WalletBloc ${wallet.id} :: Init');

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
      Stopwatch stopwatch = Stopwatch()..start();
      BBLogger().logBloc('WalletBloc ${state.wallet?.id} :: SyncWallet');
      emit(state.copyWith(status: LoadStatus.loading));
      // await Future.delayed(const Duration(seconds: 1));

      final seed = await seedRepository.loadSeed(state.wallet!.seedFingerprint);
      final loadedWallet =
          await walletRepository.loadNativeSdk(state.wallet!, seed);
      print('[Time] Sync : To load seed : ${stopwatch.elapsedMilliseconds} ms');
      stopwatch.reset();

      emit(state.copyWith(wallet: loadedWallet));

      final syncedWallet = await Wallet.syncWallet(loadedWallet);
      print('[Time] Sync : wallet sync : ${stopwatch.elapsedMilliseconds} ms');
      stopwatch.reset();

      BBLogger().logBloc(
          'WalletBloc ${state.wallet?.id} :: SyncWallet : process Txs');
      final storedTxs = await txRepository.listAllTxs(syncedWallet);
      final txs = await txRepository.syncTxs(syncedWallet, storedTxs);
      await txRepository.persistTxs(syncedWallet, txs);
      print('[Time] Sync : processTxs : ${stopwatch.elapsedMilliseconds} ms');
      stopwatch.reset();

      BBLogger().logBloc(
          'WalletBloc ${state.wallet?.id} :: SyncWallet : process Addresses');
      // TODO: Pass old address
      final depositAddresses = await addressRepository.syncAddresses(
          txs, [], AddressKind.deposit, syncedWallet);
      await addressRepository.persistAddresses(syncedWallet, depositAddresses);
      print(
          '[Time] Sync : process Deposit address : ${stopwatch.elapsedMilliseconds} ms');
      stopwatch.reset();

      // TODO: Pass old address
      final changeAddresses = await addressRepository.syncAddresses(
          txs, [], AddressKind.change, syncedWallet);
      await addressRepository.persistAddresses(syncedWallet, changeAddresses);
      print(
          '[Time] Sync : process change address : ${stopwatch.elapsedMilliseconds} ms');
      stopwatch.reset();
      stopwatch.stop();

      await walletRepository.persistWallet(syncedWallet);

      emit(state.copyWith(status: LoadStatus.success, wallet: syncedWallet));
      BBLogger().logBloc('WalletBloc ${state.wallet?.id} :: SyncWallet : DONE');
    } on BBException catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure, error: error));
      addError(error, stackTrace);
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onPersistWallet(PersistWallet event, Emitter<WalletState> emit) async {
    BBLogger().logBloc('WalletBloc ${state.wallet?.id} :: PersistWallet');
    emit(state.copyWith(status: LoadStatus.loading));
    // await Future.delayed(const Duration(milliseconds: 10000));
    await walletRepository.persistWallet(event.wallet);
    emit(state.copyWith(status: LoadStatus.success));
  }

  void _onBuildTx(BuildTx event, Emitter<WalletState> emit) async {
    try {
      BBLogger().logBloc('WalletBloc ${state.wallet?.id} :: BuildTx');
      emit(state.copyWith(status: LoadStatus.loading));
      // await state.wallet!.buildTx(event.address, event.amount);
      final seed = await seedRepository.loadSeed(event.wallet.seedFingerprint);
      await walletRepository.buildTx(
          event.wallet, event.address, event.amount, seed);
      emit(state.copyWith(status: LoadStatus.success));
    } on BBException catch (e, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure, error: e));
      // TODO: If it's any of BDK Exception just show it to user, don't log. Sure? Re-think Sure? Re-think
      addError(e, stackTrace);
    } catch (e, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(e, stackTrace);
    }
  }
}
