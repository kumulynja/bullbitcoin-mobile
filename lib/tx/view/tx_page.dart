import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/address/bloc/addr_bloc.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/tx/bloc/tx_state.dart';
import 'package:bb_arch/tx/cubit/tx_page_cubit.dart';
import 'package:bb_arch/tx/view/bitcoin_tx_view.dart';
import 'package:bb_arch/tx/view/liquid_tx_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TxPage extends StatelessWidget {
  const TxPage({super.key, required this.walletId, required this.id});

  final String walletId;
  final String id;

  @override
  Widget build(BuildContext context) {
    final txRepository = context.read<TxRepository>();
    final addressRepository = context.read<AddressRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TxPageCubit()),
        BlocProvider(
            create: (_) => TxBloc(txRepository: txRepository)
              ..add(LoadTx(walletId: walletId, txid: id))),
        BlocProvider(
            create: (_) => AddressBloc(addrRepository: addressRepository)
              ..add(LoadAddresses(
                  walletId:
                      walletId))), // TODO: Remove this after cleanup. Added this now for `isMyAddress` to work in TxView
      ],
      child: const TxScaffold(),
    );
  }
}

class TxScaffold extends StatelessWidget {
  const TxScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final loadstatus = context.select((TxBloc cubit) => cubit.state.status);
    final tx = context.select((TxBloc cubit) => cubit.state.selectedTx);

    Widget? txView;
    if (tx != null && tx.type == TxType.Bitcoin) {
      txView = BitcoinTxView(tx: tx);
    } else if (tx != null && tx.type == TxType.Liquid) {
      txView = LiquidTxView(tx: tx);
    }
    return BBScaffold(
        title: 'Tx', loadStatus: loadstatus, child: tx != null ? txView : null);
  }
}
