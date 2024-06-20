import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/tx/widgets/tx_card.dart';
import 'package:flutter/material.dart';

class TxListWidget extends StatelessWidget {
  const TxListWidget({
    super.key,
    required this.txs,
  });

  final List<Tx> txs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Tx tx = txs[index];
        String amount =
            '${tx.amount} - ${(tx.amount ?? 0) > 0 ? 'received' : 'sent'} ${tx.timestamp == 0 ? '(pending)' : ''}';
        return TxCard(amount: amount, tx: tx);
      },
      itemCount: txs.length,
    );
  }
}
