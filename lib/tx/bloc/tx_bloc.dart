// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/tx/bloc/tx_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tx_event.dart';

class TxBloc extends Bloc<TxEvent, TxState> {
  final TxRepository txRepository;
  final BBLogger logger;

  TxBloc({required this.txRepository, required this.logger})
      : super(const TxState()) {
    on<FetchLatestTxsAcrossWallets>(_onFetchLatestTxsAcrossWallets);
    on<LoadTxs>(_onLoadTxs);
    // on<SyncTxs>(_onSyncTxs);
    on<SelectTx>(_onSelectTx);
    on<LoadTx>(_onLoadTx);
  }

  void _onFetchLatestTxsAcrossWallets(
      FetchLatestTxsAcrossWallets event, Emitter<TxState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    logger.log('TxBloc :: FetchLatestTxsAcrossWallets : ${event.limit}');

    final (txs, err) =
        await txRepository.fetchLatestTxsAcrossWallets(event.limit);
    if (err != null) {
      emit(state.copyWith(
          txs: [], status: LoadStatus.failure, error: err.toString()));
      return;
    }
    emit(state.copyWith(txs: txs!, status: LoadStatus.success));
  }

  void _onLoadTxs(LoadTxs event, Emitter<TxState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    logger.log('TxBloc :: LoadTxs : ${event.wallet.name}');

    final (txs, err) = await txRepository.listTxs(event.wallet);
    if (err != null) {
      emit(state.copyWith(
          txs: [], status: LoadStatus.failure, error: err.toString()));
      return;
    }
    emit(state.copyWith(txs: txs!, status: LoadStatus.success));
  }

  /*
  void _onSyncTxs(SyncTxs event, Emitter<TxState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    print('_onSyncTxs: ${event.wallet.name}');

    final (txs, err) = await txRepository.syncTxs(event.wallet);
    if (err != null) {
      emit(state.copyWith(status: LoadStatus.failure, error: err.toString()));
      return;
    }
    await txRepository.persistTxs(event.wallet, txs!);
    emit(state.copyWith(txs: txs, status: LoadStatus.success));
  }
  */

  void _onSelectTx(SelectTx event, Emitter<TxState> emit) async {
    logger.log('TxBloc :: SelectTx : ${event.tx.id}');
    emit(state.copyWith(selectedTx: event.tx));
  }

  void _onLoadTx(LoadTx event, Emitter<TxState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    logger.log('TxBloc :: LoadTx : ${event.txid}');
    // await Future.delayed(const Duration(seconds: 1));

    final tx = await txRepository.loadTx(event.walletId, event.txid);
    //if (err != null) {
    //  emit(state.copyWith(selectedTx: null, status: LoadStatus.failure, error: err.toString()));
    //  return;
    //}
    emit(state.copyWith(selectedTx: tx, status: LoadStatus.success));
  }
}
