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

  TxBloc({required this.txRepository}) : super(const TxState()) {
    on<FetchLatestTxsAcrossWallets>(_onFetchLatestTxsAcrossWallets);
    on<LoadTxs>(_onLoadTxs);
    // on<SyncTxs>(_onSyncTxs);
    on<SelectTx>(_onSelectTx);
    on<LoadTx>(_onLoadTx);
  }

  void _onFetchLatestTxsAcrossWallets(
      FetchLatestTxsAcrossWallets event, Emitter<TxState> emit) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));

      BBLogger()
          .logBloc('TxBloc :: FetchLatestTxsAcrossWallets : ${event.limit}');
      await Future.delayed(const Duration(seconds: 15));

      final txs = await txRepository.fetchLatestTxsAcrossWallets(event.limit);
      // if (err != null) {
      //   emit(state.copyWith(
      //       txs: [], status: LoadStatus.failure, error: err.toString()));
      //   return;
      // }

      emit(state.copyWith(txs: txs, status: LoadStatus.success));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(e, stackTrace);
    }
  }

  void _onLoadTxs(LoadTxs event, Emitter<TxState> emit) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));

      BBLogger().logBloc('TxBloc :: LoadTxs : ${event.wallet.name}');

      final txs = await txRepository.listTxsForUI(event.wallet);
      emit(state.copyWith(txs: txs, status: LoadStatus.success));
    } catch (e, stackTrace) {
      emit(state.copyWith(status: LoadStatus.failure));
      addError(e, stackTrace);
    }
  }

  void _onSelectTx(SelectTx event, Emitter<TxState> emit) async {
    BBLogger().logBloc('TxBloc :: SelectTx : ${event.tx.id}');
    emit(state.copyWith(selectedTx: event.tx));
  }

  void _onLoadTx(LoadTx event, Emitter<TxState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    BBLogger().logBloc('TxBloc :: LoadTx : ${event.txid}');

    final tx = await txRepository.loadTx(event.walletId, event.txid);
    emit(state.copyWith(selectedTx: tx, status: LoadStatus.success));
  }
}
