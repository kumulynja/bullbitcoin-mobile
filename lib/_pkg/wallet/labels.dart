import 'package:bb_mobile/_model/address.dart';
import 'package:bb_mobile/_model/bip329_label.dart';
import 'package:bb_mobile/_model/transaction.dart';

class WalletLabels {
  Future<List<Bip329Label>> txsToBip329(List<Transaction> txs, String origin) async {
    return txs
        .where((tx) => tx.labels != null && tx.labels!.isNotEmpty)
        .map(
          (tx) => Bip329Label(
            type: BIP329Type.tx,
            ref: tx.txid,
            label: tx.labels!.join(', '),
            origin: origin,
          ),
        )
        .toList();
  }

  List<Transaction> txsFromBip329(List<Bip329Label> labels) {
    return labels
        .where((label) => label.type == BIP329Type.tx)
        .map(
          (label) => Transaction(
            timestamp: 0,
            txid: label.ref,
            labels: label.label!.split(', '),
          ),
        )
        .toList();
  }

  Future<List<Bip329Label>> addressesToBip329(List<Address> addresses, String origin) async {
    return addresses
        .where((address) => address.labels != null && address.labels!.isNotEmpty)
        .map(
          (address) => Bip329Label(
            type: BIP329Type.address,
            ref: address.address,
            label: address.labels!.join(', '),
            spendable: address.spendable,
            origin: origin,
          ),
        )
        .toList();
  }

  List<Address> addressesFromBip329(List<Bip329Label> labels) {
    return labels
        .where((label) => label.type == BIP329Type.address)
        .map(
          (label) => Address(
            address: label.ref,
            kind: AddressKind.deposit,
            state: AddressStatus.unused,
            labels: label.label!.split(', '),
            spendable: label.spendable ?? true,
          ),
        )
        .toList();
  }
}
