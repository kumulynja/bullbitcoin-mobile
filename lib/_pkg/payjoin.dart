import 'package:bdk_flutter/bdk_flutter.dart' as bdk;
import 'package:dio/dio.dart';
import 'package:payjoin_flutter/common.dart';
import 'package:payjoin_flutter/receive.dart';
import 'package:payjoin_flutter/send.dart';
import 'package:payjoin_flutter/uri.dart';

class PayJoin {
  static String directory = 'https://payjo.in';
  static String relay = 'https://pj.bobspacebkk.com';
  static String v2ContentType = 'message/ohttp-req';

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

  static Future<Uri> stringToUri(String pj) async {
    try {
      return await Uri.fromStr(pj);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<Sender> buildPayjoinRequest(
    String originalPsbt,
    Uri pjUri,
    int fee,
  ) async {
    final senderBuilder = await SenderBuilder.fromPsbtAndUri(
      psbtBase64: originalPsbt,
      pjUri: pjUri.checkPjSupported(),
    );
    final sender =
        await senderBuilder.buildRecommended(minFeeRate: BigInt.from(250));

    return sender;
  }

  static Future<String> buildOriginalPsbt(
    bdk.Wallet senderWallet,
    Uri pjUri,
    int fee,
  ) async {
    final txBuilder = bdk.TxBuilder();
    final address = await bdk.Address.fromString(
      s: pjUri.address(),
      network: bdk.Network.signet,
    );
    final script = address.scriptPubkey();
    final BigInt uriAmount = pjUri.amountSats() ?? BigInt.zero;
    final (psbt, _) = await txBuilder
        .addRecipient(script, uriAmount)
        .feeAbsolute(BigInt.from(fee))
        .finish(senderWallet);
    await senderWallet.sign(
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

    final psbtBase64 = psbt.asString();
    print('Original Sender Psbt for request: $psbtBase64');
    return psbtBase64;
  }

  static Future<String> requestAndPollV2Proposal(Sender sender) async {
    print('Sending V2 Proposal Request...');
    try {
      // Extract the request and context once
      final (request, postCtx) = await sender.extractV2(
        ohttpProxyUrl: await Url.fromStr(relay),
      );

      final dio = Dio();

      final response = await dio.post(
        request.url.asString(),
        options: Options(headers: {'Content-Type': v2ContentType}),
        data: request.body,
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      final bodyBytes = response.data as List<int>;
      final getCtx = await postCtx.processResponse(response: bodyBytes);

      // Loop to extract (request, ctx) from get_ctx
      while (true) {
        print('Polling for V2 Proposal...');
        try {
          final (getReq, ohttpCtx) = await getCtx.extractReq(
            ohttpRelay: await Url.fromStr(relay),
          );

          // Post the loop request to the server
          final loopResponse = await dio.post(
            getReq.url.asString(),
            options: Options(headers: {'Content-Type': v2ContentType}),
            data: getReq.body,
          );
          final bodyBytes = loopResponse.data as List<int>;

          // Process the loop response
          final proposal = await getCtx.processResponse(
            response: bodyBytes,
            ohttpCtx: ohttpCtx,
          );

          // If a valid proposal is received, return it
          if (proposal != null) {
            print('Received V2 proposal: $proposal');
            return proposal;
          }

          const timeout = Duration(seconds: 2);
          print(
            'No valid proposal received, retrying after ${timeout.inSeconds} seconds...',
          );
          // Add a delay to avoid spamming the server with requests
          await Future.delayed(timeout);
        } catch (e) {
          // If the session times out or another error occurs, rethrow the error
          rethrow;
        }
      }
    } catch (e) {
      // If the initial request fails, rethrow the error
      rethrow;
    }
  }

  static Future<bdk.Transaction> extractPjTx(
    bdk.Wallet senderWallet,
    String psbtString,
  ) async {
    final psbt = await bdk.PartiallySignedTransaction.fromString(psbtString);
    print('PSBT before: $psbt');
    senderWallet.sign(
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
    final transaction = psbt.extractTx();
    return transaction;
  }
}
