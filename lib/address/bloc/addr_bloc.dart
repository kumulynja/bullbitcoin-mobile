// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/address/bloc/addr_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addr_event.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository addrRepository;

  AddressBloc({required this.addrRepository}) : super(const AddressState()) {
    on<LoadAddresses>(_onLoadAddresses);
    // on<SyncAddresss>(_onSyncAddresses);
    on<SelectAddress>(_onSelectAddress);
    on<LoadAddress>(_onLoadAddress);
    on<ChangeSelectedAddressKind>(_changeSelectedAddressKind);
  }

  void _onLoadAddresses(LoadAddresses event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    print('_onLoadAddresses: ${event.walletId}');

    final ads = await addrRepository.listAddresses(event.walletId);
    // if (err != null) {
    //   emit(state.copyWith(depositAddresses: [], status: LoadStatus.failure, error: err.toString()));
    //   return;
    // }

    // TODO: Optimize
    final deposit = ads!.where((a) => a.kind == AddressKind.deposit).toList();
    final change = ads.where((a) => a.kind == AddressKind.change).toList();

    // await Future.delayed(const Duration(seconds: 10));

    emit(state.copyWith(
        depositAddresses: deposit,
        changeAddresses: change,
        status: LoadStatus.success));
  }

  /*
  void _onSyncAddresses(SyncAddresss event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    print('_onSyncAddresses: ${event.wallet.name}');

    final (depositAddresses, depositErr) =
        await addrRepository.syncAddresses(event.txs, event.oldAddresses, AddressKind.deposit, event.wallet);
    if (depositErr != null) {
      emit(state.copyWith(depositAddresses: [], status: LoadStatus.failure, error: depositErr.toString()));
      return;
    }
    await addrRepository.persistAddresses(event.wallet, depositAddresses!);

    final (changeAddresses, changeErr) =
        await addrRepository.syncAddresses(event.txs, event.oldAddresses, AddressKind.change, event.wallet);
    if (changeErr != null) {
      emit(state.copyWith(changeAddresses: [], status: LoadStatus.failure, error: changeErr.toString()));
      return;
    }
    await addrRepository.persistAddresses(event.wallet, changeAddresses!);

    emit(state.copyWith(
        depositAddresses: depositAddresses, changeAddresses: changeAddresses, status: LoadStatus.success));
  }
  */

  void _onSelectAddress(SelectAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(selectedAddress: event.address));
  }

  void _onLoadAddress(LoadAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: LoadStatus.loading));

    print('_onLoadAddress: ${event.address}');

    // await Future.delayed(const Duration(seconds: 2));

    final address =
        await addrRepository.loadAddress(event.walletId, event.address);
    emit(state.copyWith(selectedAddress: address, status: LoadStatus.success));
  }

  void _changeSelectedAddressKind(
      ChangeSelectedAddressKind event, Emitter<AddressState> emit) async {
    emit(state.copyWith(selectedAddressKind: event.kind));
  }
}
