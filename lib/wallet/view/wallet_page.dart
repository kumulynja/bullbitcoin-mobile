import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/cubit/wallet_page_cubit.dart';
import 'package:bb_arch/wallet/view/wallet_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final wallet =
        context.select((WalletBloc cubit) => cubit.state.selectedWallet!);
    final txRepository = context.read<TxRepository>();
    final logger = context.read<BBLogger>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => TxBloc(txRepository: txRepository, logger: logger)
              ..add(LoadTxs(wallet: wallet))),
        BlocProvider(create: (_) => WalletPageCubit()),
      ],
      child: WalletScaffold(id: id),
    );
  }
}
