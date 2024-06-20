import 'package:bb_arch/_pkg/tx/models/bitcoin_tx.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';

class BitcoinTxHelper {
  /// Summary from BIP 125;
  /// RBF happens under following conditions:
  ///   1. The original tx signal replaceability explicitly or through inheritance.
  ///     TODO: Implement this check
  ///   2. [DONE_Partial] The replacement tx may only include an unconfirmed input if that input was included in one of the original transactions.
  ///     TODO: But as per bdk's behavior, replacement tx can also contain additional inputs.
  ///     So we check only for a minimum of 1 matching input between replacement and original tx.
  ///   3. [TO_BE_TESTED] The replacement tx pays an absolute fee of at least the sum paid by the original transactions.
  ///   4. [TO_BE_TESTED] The replacement transaction must also pay for its own bandwidth.
  ///   5. [TO_BE_TESTED] number of original transactions to be replaced and their descendant transactions which will be evicted from the mempool must not exceed a total of 100 transactions.
  static List<Tx> findAndMergeReceiveRBFs(
      List<Tx> mergedTxs, List<Tx> newTxs, List<Tx> pendingTxs) {
    for (Tx tx in newTxs) {
      // print('NewTx: ${tx.id}');
      final rbfParent = isInRbfChain(tx, pendingTxs);

      // If a RbfParent is found
      if (rbfParent != null && rbfParent.rbfChain.length <= 100) {
        // If it's the first RBF in the chain
        if (rbfParent.rbfChain.isEmpty) {
          Tx updatedRbfParent = (rbfParent as BitcoinTx).copyWith(
            rbfChain: [rbfParent.id, tx.id],
            rbfIndex: 0,
          );
          updateTxInArray(mergedTxs, updatedRbfParent);

          Tx updatedTx = (tx as BitcoinTx).copyWith(
            rbfChain: [rbfParent.id, tx.id],
            rbfIndex: 1,
          );
          updateTxInArray(mergedTxs, updatedTx);
          // If it's already part of a Rbf chain
        } else {
          Tx? updatedRbfAncestorTx;
          // Update every Rbf ancestor with the new child Tx
          for (int i = 0; i < rbfParent.rbfChain.length; i++) {
            final rbfAncestorTxId = rbfParent.rbfChain[i];
            final rbfAncentorTx =
                pendingTxs.firstWhere((pTx) => pTx.id == rbfAncestorTxId);
            updatedRbfAncestorTx = (rbfAncentorTx as BitcoinTx).copyWith(
              rbfChain: [...rbfAncentorTx.rbfChain, tx.id],
            );
            updateTxInArray(mergedTxs, updatedRbfAncestorTx);
          }

          Tx updatedTx = (tx as BitcoinTx).copyWith(
            rbfChain: [...updatedRbfAncestorTx!.rbfChain],
            rbfIndex: updatedRbfAncestorTx.rbfChain.length - 1,
          );
          updateTxInArray(mergedTxs, updatedTx);
        }
      }
    }

    return mergedTxs;
  }

  static Tx? isInRbfChain(Tx tx, List<Tx> pendingTxs) {
    if (pendingTxs.isEmpty) {
      return null;
    }

    for (final pending in pendingTxs) {
      if (tx.id == pending.id) continue;
      final pendingMatchIndex = tx.inputs!.indexWhere((txIp) {
        final outpointStr = txIp.previousOutput.toStr();

        final matchingIndex = pending.inputs!.indexWhere((pTxIp) {
          final pendingOutpointStr = pTxIp.previousOutput.toStr();
          if (pendingOutpointStr == outpointStr &&
              tx.feeRate > pending.feeRate) {
            return true;
          }
          return false;
        });

        if (matchingIndex != -1) {
          return true;
        }
        return false;
      });

      if (pendingMatchIndex != -1) {
        return pending;
      }
    }

    return null;
  }

  static void updateTxInArray(List<Tx> txList, Tx tx) {
    txList.removeWhere((t) => t.id == tx.id);
    txList.add(tx);
  }
}
