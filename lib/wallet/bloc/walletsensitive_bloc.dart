// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'walletsensitive_event.dart';

class WalletSensitiveBloc
    extends Bloc<WalletSensitiveEvent, WalletSensitiveState> {
  final WalletRepository walletRepository;
  final SeedRepository seedRepository;

  WalletSensitiveBloc(
      {required this.walletRepository, required this.seedRepository})
      : super(WalletSensitiveState.initial()) {
    on<CreateNewSeed>(_onCreateNewSeed);
    on<DeriveWalletFromStoredSeed>(_onDeriveWalletFromStoredSeed);
    on<PersistSeedForWalletId>(_onPersistSeedForWalletId);
  }

  void _onCreateNewSeed(
      CreateNewSeed event, Emitter<WalletSensitiveState> emit) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final seed = await seedRepository.newSeed(
          event.walletType ?? WalletType.Bitcoin,
          event.networkType ?? NetworkType.Testnet);
      emit(state.copyWith(seed: seed, status: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onPersistSeedForWalletId(
      PersistSeedForWalletId event, Emitter<WalletSensitiveState> emit) async {
    await seedRepository.persistSeedforWalletId(event.seed, event.walletId);
  }

  void _onDeriveWalletFromStoredSeed(DeriveWalletFromStoredSeed event,
      Emitter<WalletSensitiveState> emit) async {
    BBLogger()
        .logBloc('WalletSensitiveBloc :: DeriveWallets (${event.walletName})');

    emit(state.copyWith(
        status: LoadStatus.loading,
        derivedWallets: [],
        walletName: event.walletName));

    List<Wallet> nameUpdatedWallets = [];
    final (wallets, errDerive) = await walletRepository.deriveWalletsFromSeed(
        event.seed, event.walletType, event.networkType);

    BBLogger().logBloc(
        'WalletSensitiveBloc :: DeriveWallets (${event.walletName}) : derived wallets');

    if (wallets != null) {
      for (int i = 0; i < wallets.length; i++) {
        Wallet w = wallets[i];
        if (w is BitcoinWallet) {
          final oldWallet = wallets[i] as BitcoinWallet;
          nameUpdatedWallets.add(oldWallet.copyWith(name: event.walletName));
        } else if (w is LiquidWallet) {
          final oldWallet = wallets[i] as LiquidWallet;
          nameUpdatedWallets.add(oldWallet.copyWith(name: event.walletName));
        }
      }
    }

    BBLogger().logBloc(
        'WalletSensitiveBloc :: DeriveWallets (${event.walletName}) : name updated');

    if (errDerive != null) {
      emit(state.copyWith(status: LoadStatus.failure, error: errDerive));
      return;
    }

    // sync logic goes here
    emit(state.copyWith(
        derivedWallets: nameUpdatedWallets,
        syncDerivedWalletStatus:
            nameUpdatedWallets.map((e) => LoadStatus.loading).toList()));
    // seedRepository.clearSeed();

    List<Future<Wallet>> syncedFutures =
        state.derivedWallets.map((w) => Wallet.syncWallet(w)).toList();

    var completer = Completer();

    int syncedCount = 0;
    for (int i = 0; i < syncedFutures.length; i++) {
      syncedFutures[i].then((Wallet result) {
        if (++syncedCount == syncedFutures.length) {
          completer.complete();
        }
        emit(state.copyWith(derivedWallets: [
          ...state.derivedWallets.sublist(0, i),
          result,
          ...state.derivedWallets.sublist(i + 1),
        ], syncDerivedWalletStatus: [
          ...state.syncDerivedWalletStatus.sublist(0, i),
          LoadStatus.success,
          ...state.syncDerivedWalletStatus.sublist(i + 1),
        ]));
        BBLogger().logBloc(
            'WalletSensitiveBloc :: DeriveWallets (${event.walletName}) : sync complete $i');
      }).catchError((error, stackTrace) {
        if (++syncedCount == syncedFutures.length) {
          completer.complete();
        }
        BBLogger().error(
            'WalletSensitiveBloc :: DeriveWallets (${event.walletName}) : sync complete $i',
            stackTrace);
      });
    }

    await completer.future;
    // await Future.delayed(const Duration(seconds: 5));
    emit(state.copyWith(status: LoadStatus.success));
  }

  @override
  Future<void> close() {
    // TODO: Cancel sync() function from here.
    // Right now, it keeps running, even after the bloc that initiated it is closed.
    BBLogger().logBloc('WalletSensitiveBloc (${state.walletName}) :: close()');
    return super.close();
  }
}
