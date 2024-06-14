import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TxCard extends StatelessWidget {
  const TxCard({
    super.key,
    required this.amount,
    required this.tx,
  });

  final String amount;
  final Tx tx;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(amount),
      subtitle: Text((DateTime.fromMillisecondsSinceEpoch(tx.timestamp * 1000))
          .toString()),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        print('TxList: tx: $tx');
        context.read<TxBloc>().add(SelectTx(tx: tx));
        GoRouter.of(context).push('/wallet/${tx.walletId}/tx/${tx.id}');
      },
    );
  }
}
