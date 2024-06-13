// ignore_for_file: avoid_print, invalid_annotation_target

import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:lwk_dart/lwk_dart.dart' as lwk;
import 'package:isar/isar.dart';

part 'seed.freezed.dart';
part 'seed.g.dart';

// TODO:
// This is a Isar model now just for dev/debugging.
// It will later be saved in Secure storage.
@freezed
@Collection(ignore: {'copyWith'})
class Seed with _$Seed {
  const factory Seed({
    required String mnemonic,
    required String passphrase,
    @Index() required String fingerprint,
    @Enumerated(EnumType.ordinal)
    required WalletType walletType, // TODO: Needed here?
    @Enumerated(EnumType.ordinal)
    required NetworkType network, // TODO: Needed here?
  }) = _Seed;
  const Seed._();

  Id get isarId => Isar.autoIncrement;

  @Index()
  String get id => '${fingerprint}_${walletType.name}_${network.name}';

  factory Seed.fromJson(Map<String, dynamic> json) =>
      safeFromJson(json, _$SeedFromJson, 'Seed');

  Future<(String?, dynamic)> getLwkFingerprint() async {
    // lwk.Wallet.
    return ('', null);
  }

  // TODO: Is this the right place to have this?
  Future<(String?, dynamic)> getBdkFingerprint() async {
    try {
      final mn = await bdk.Mnemonic.fromString(mnemonic);
      final descriptorSecretKey = await bdk.DescriptorSecretKey.create(
        network: network.getBdkType,
        mnemonic: mn,
        password: passphrase,
      );

      final externalDescriptor = await bdk.Descriptor.newBip84(
        secretKey: descriptorSecretKey,
        network: network.getBdkType,
        keychain: bdk.KeychainKind.External,
      );
      final edesc = await externalDescriptor.asString();
      final fgnr = fingerPrintFromXKeyDesc(edesc);

      return (fgnr, null);
    } on Exception catch (e) {
      return (null, e);
    }
  }
}

String fingerPrintFromXKeyDesc(
  String xkey,
) {
  final startIndex = xkey.indexOf('[');
  if (startIndex == -1) return 'Unknown';
  final fingerPrintEndIndex = xkey.indexOf('/');
  final fingerPrint = xkey.substring(startIndex + 1, fingerPrintEndIndex);
  return fingerPrint;
}

/*
@freezed
class Passphrase with _$Passphrase {
  const factory Passphrase({
    @Default('') String passphrase,
    required String sourceFingerprint,
  }) = _Passphrase;
  const Passphrase._();

  factory Passphrase.fromJson(Map<String, dynamic> json) => _$PassphraseFromJson(json);
}
*/