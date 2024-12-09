import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:payjoin_flutter/common.dart';
import 'package:payjoin_flutter/receive.dart';
import 'package:payjoin_flutter/uri.dart';

class PayJoin {
  static String directory = 'https://payjo.in';
  static String relay = 'https://pj.bobspacebkk.com';

  // from payjoin-flutter
  static Future<(Receiver, String)> initReceiver(
    BigInt sats,
    String address,
  ) async {
    final payjoinDirectory = await Url.fromStr(directory);
    final ohttpRelay = await Url.fromStr(relay);

    final ohttpKeys = await fetchOhttpKeys(
      ohttpRelay: ohttpRelay,
      payjoinDirectory: payjoinDirectory,
    );

    print('OHTTP KEYS FETCHED $ohttpKeys');

    // Create receiver session with new bindings
    final receiver = await Receiver.create(
      address: address,
      network: Network.signet,
      directory: payjoinDirectory,
      ohttpKeys: ohttpKeys,
      ohttpRelay: ohttpRelay,
      expireAfter: BigInt.from(60 * 5), // 5 minutes
    );

    print('INITIALIZED RECEIVER');

    final pjUrl = receiver.pjUriBuilder().amountSats(amount: sats).build();
    final pjStr = pjUrl.asString();

    print('PAYJOIN URL: $pjStr');

    return (receiver, pjStr);
  }

  static Future<String> processPsbt(
    String preProcessed,
    bdk.Wallet wallet,
  ) async {
    final psbt = await bdk.PartiallySignedTransaction.fromString(preProcessed);
    print('PSBT before: $psbt');
    await wallet.sign(
      psbt: psbt,
      signOptions: const bdk.SignOptions(
        trustWitnessUtxo: true,
        allowAllSighashes: false,
        removePartialSigs: true,
        tryFinalize: true,
        signWithTapInternalKey: true,
        allowGrinding: false,
      ),
    );
    print('PSBT after: $psbt');
    return psbt.asString();
  }

  static Future<String> getTxIdFromPsbt(String psbtBase64) async {
    final psbt = await bdk.PartiallySignedTransaction.fromString(psbtBase64);
    final txId = psbt.extractTx().txid();
    return txId;
  }
}
