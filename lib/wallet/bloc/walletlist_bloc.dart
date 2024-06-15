// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'walletlist_event.dart';

class WalletListBloc extends Bloc<WalletListEvent, WalletListState> {
  final WalletRepository walletRepository;
  final TxRepository txRepository;
  final AddressRepository addressRepository;
  final SeedRepository seedRepository;
  final BuildContext context;
  Timer? _loadWalletsTimer;

  WalletListBloc({
    required this.walletRepository,
    required this.seedRepository,
    required this.txRepository,
    required this.addressRepository,
    required this.context,
  }) : super(WalletListState.initial()) {
    on<LoadAllWallets>(_onLoadAllWallets);
    on<SyncAllWallets>(_onSyncAllWallets);
    on<SelectWallet>(_onSelectWallet);
    on<DeleteWalletWithDelay>(_onDeleteWalletWithDelay);

    BBLogger().logBloc('WalletListBloc :: Init');
  }

  @override
  Future<void> close() {
    _loadWalletsTimer?.cancel();
    return super.close();
  }

  void _onLoadAllWallets(
      LoadAllWallets event, Emitter<WalletListState> emit) async {
    try {
      BBLogger().logBloc('WalletListBloc :: LoadAllWallets');
      emit(state.copyWith(status: LoadStatus.loading));

      final wallets = await walletRepository.loadWallets();

      for (var bloc in state.walletBlocs) {
        bloc.close();
      }

      final walletBlocs = wallets
          .map((wallet) => WalletBloc(
                walletRepository: walletRepository,
                wallet: wallet,
                seedRepository: seedRepository,
                txRepository: txRepository,
                addressRepository: addressRepository,
              ))
          .toList();

      emit(
          state.copyWith(walletBlocs: walletBlocs, status: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(error, stackTrace);
    }
  }

  void _onSyncAllWallets(
      SyncAllWallets event, Emitter<WalletListState> emit) async {
    for (var bloc in state.walletBlocs) {
      bloc.add(SyncWallet());
    }
  }

  void _onSelectWallet(
      SelectWallet event, Emitter<WalletListState> emit) async {
    emit(state.copyWith(selectedWallet: event.wallet));
  }

  void _onDeleteWalletWithDelay(
      DeleteWalletWithDelay event, Emitter<WalletListState> emit) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));

      await Future.delayed(event.delay);

      await txRepository.deleteAllTxsInWallet(event.walletId);
      await addressRepository.deleteAllAddressInWallet(event.walletId);
      await walletRepository.deleteWallet(event.walletId);
      await seedRepository.removeWalletForSeed(
          event.walletId, event.seedFingerprint);

      final walletBlocs = [...state.walletBlocs];
      walletBlocs
          .removeWhere((element) => element.state.wallet?.id == event.walletId);

      emit(
          state.copyWith(walletBlocs: walletBlocs, status: LoadStatus.success));
    } catch (error, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(error, stackTrace);
    }
  }
}
