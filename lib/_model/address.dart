// ignore_for_file: invalid_annotation_target

import 'package:bb_mobile/_model/wallet.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address.freezed.dart';
part 'address.g.dart';

enum AddressKind {
  deposit,
  change,
  external,
}

enum AddressStatus {
  unused,
  active,
  used,
  copied,
}

@freezed
class Address with _$Address {
  factory Address({
    required String address,
    int? index,
    required AddressKind kind,
    required AddressStatus state,
    // String? label,
    List<String>? labels,
    String? spentTxId,
    @Default(true) bool spendable,
    @Default(0) int highestPreviousBalance,
    @Default(0) int balance,
  }) = _Address;
  const Address._();

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  // TODO: UTXO
  // Updated with UTXO change
  List<bdk.OutPoint> getUnspentUtxosOutpoints(List<UTXO> utxos) {
    return utxos
        .where((ut) => ut.address.address == address)
        .map((e) => bdk.OutPoint(txid: e.txid, vout: e.txIndex))
        .toList();
    // return utxos?.where((tx) => !tx.isSpent).map((tx) => tx.outpoint).toList() ?? [];
  }

  (List<String>, bool) getLabels(Wallet w) {
    if (labels != null && labels!.isNotEmpty) return (labels!, false);

    final List<String> lbls = [];
    // TODO: Calling this on every build is super inefficient. Ideally have a address / txid map for labels
    for (final tx in w.transactions) {
      if (tx.labels != null && tx.labels!.isNotEmpty) {
        // TODO: Think about this: if (!tx.isReceived()) {
        for (final outAddr in tx.outAddrs) {
          if (outAddr.address == address) {
            lbls.addAll(tx.labels ?? []);
          }
        }

        // if (!tx.isReceived() && tx.txid.endsWith('316b')) {
        //   for (final prevTxId in tx.prevTxIds) {
        //     for (final txx in w.transactions) {
        //       if (txx.labels != null && txx.labels!.isNotEmpty) {
        //         if (prevTxId == tx.txid) {
        //           lbls.addAll(txx.labels ?? []);
        //         }
        //       }
        //     }
        //   }
        // }
      }
      // TODO: Should look in external address book?
    }
    return (Set<String>.from(lbls).toList(), true);
  }

  String miniString() {
    return address.substring(0, 6) + '[...]' + address.substring(address.length - 6);
  }

  String largeString() {
    return address.substring(0, 10) + '[...]' + address.substring(address.length - 10);
  }

  String toShortString() {
    return address.substring(0, 5) + '...' + address.substring(address.length - 5);
  }

  String getKindString() {
    switch (kind) {
      case AddressKind.deposit:
        return 'Receive';
      case AddressKind.change:
        return 'Change';
      case AddressKind.external:
        return 'External';
    }
  }
}

@freezed
class UTXO with _$UTXO {
  factory UTXO({
    required String txid,
    required int txIndex,
    required bool isSpent,
    required int value,
    required String label,
    required Address address,
    required bool spendable,
  }) = _UTXO;
  const UTXO._();

  factory UTXO.fromJson(Map<String, dynamic> json) => _$UTXOFromJson(json);

  @override
  String toString() {
    return '$txid:$txIndex';
  }
}

extension Y on List<UTXO> {
  bool containsUtxo(UTXO utxo) => where((utx) => utx.toString() == utxo.toString()).isNotEmpty;

  List<UTXO> removeUtxo(UTXO utxo) => where((utx) => utx.toString() != utxo.toString()).toList();
}
