import 'package:bb_arch/_pkg/tx/models/liquid_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiquidTxView extends StatelessWidget {
  const LiquidTxView({super.key, required this.tx});

  final Tx tx;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tx ID'),
          Text(tx.id),
          const SizedBox(height: 8),
          const Text('Amount'),
          Text(tx.amount.toString()),
          const SizedBox(height: 8),
          const Text('Time'),
          Text(DateTime.fromMillisecondsSinceEpoch((tx.timestamp) * 1000).toString()),
          const SizedBox(height: 8),
          const Text('Fee'),
          Text(tx.fee.toString()),
          const SizedBox(height: 8),
          const Text('Coin Type'),
          Text(tx.type.name),
          const SizedBox(height: 8),
          const Text('Inputs'),
          if (tx is LiquidTx)
            ...(tx.linputs ?? []).map((e) {
              return Column(children: [
                Text('- ${e.previousOutput.toString()}'),
                const SizedBox(height: 4),
              ]);
            }).toList(),
          const SizedBox(height: 8),
          const Text('Outputs'),
          if (tx is LiquidTx)
            ...(tx.loutputs ?? []).map((e) {
              return Text('- ${e.address} ${e.scriptPubKey}: ${e.value}');
            }).toList(),
        ],
      ),
    ));
  }
}