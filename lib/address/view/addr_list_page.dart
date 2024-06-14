// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/address/bloc/addr_bloc.dart';
import 'package:bb_arch/address/bloc/address_cubit.dart';
import 'package:bb_arch/address/view/addr_list_view.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    final addressRepository = context.read<AddressRepository>();
    final txRepository = context.read<TxRepository>();
    final selectedWallet = context.select((WalletListBloc cubit) => cubit
        .state.walletBlocs
        .firstWhere((bloc) => bloc.state.wallet?.id == walletId)
        .state
        .wallet);
    // final txs = context.select((TxBloc cubit) => cubit.state.txs);

    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => AddressCubit()),
      BlocProvider(
          create: (_) => TxBloc(txRepository: txRepository)
            ..add(LoadTxs(wallet: selectedWallet!))),
      BlocProvider(
          create: (_) => AddressBloc(addrRepository: addressRepository)
            ..add(LoadAddresses(walletId: selectedWallet?.id ?? ''))),
    ], child: AddressListScaffold(walletId: walletId));
    // child: BlocBuilder<TxBloc, TxState>(
    //     buildWhen: (previous, current) => current.txs.isNotEmpty, // TODO: Update this later
    //     builder: (context, state) {
    //       print('Address List Page: ${state.txs.length}');
    //       context.read<AddressBloc>().add(LoadAddresses(walletId: selectedWallet.id));
    //       // context.read<AddressBloc>().add(SyncAddresss(txs: state.txs, oldAddresses: [], wallet: selectedWallet));
    //       return const AddressListScaffold();
    //     }));
  }
}
