import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/send/view/send_view.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:bb_arch/wallet/widgets/wallets_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key, required this.walletId});

  static String route = '/send';
  final String walletId;

  @override
  Widget build(BuildContext context) {
    final walletBloc = context.read<WalletListBloc>().state.walletBlocs[0];

    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => walletBloc),
    ], child: SendScaffold(walletId: walletId));
  }
}
