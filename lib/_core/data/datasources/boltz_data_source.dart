import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bb_mobile/_core/data/datasources/boltz_storage_data_source.dart';
import 'package:bb_mobile/_core/data/models/swap_model.dart';
import 'package:bb_mobile/_core/domain/entities/swap.dart' as swap_entity;
import 'package:bb_mobile/_utils/constants.dart';
import 'package:boltz/boltz.dart';

abstract class BoltzDataSource {
  // Reverse Swaps
  Future<(int, int)> getBtcReverseSwapLimits();
  Future<(int, int)> getLbtcReverseSwapLimits();

  Future<SwapModel> createBtcReverseSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required int outAmount,
    required bool isTestnet,
    required String electrumUrl,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> claimBtcReverseSwap({
    required String swapId,
    required String claimAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });
  Future<String> broadcastBtcLnSwap({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  });
  Future<SwapModel> createLBtcReverseSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required int outAmount,
    required bool isTestnet,
    required String electrumUrl,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> claimLBtcReverseSwap({
    required String swapId,
    required String claimAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });
  Future<String> broadcastLbtcLnSwap({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  });
  // Submarine Swaps
  Future<(int, int)> getBtcSubmarineSwapLimits();
  Future<(int, int)> getLbtcSubmarineSwapLimits();

  Future<SwapModel> createBtcSubmarineSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required String invoice,
    required bool isTestnet,
    required String electrumUrl,
  });
  Future<void> coopSignBtcSubmarineSwap({required String swapId});
  // TODO: add function to get invoice preimage
  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> refundBtcSubmarineSwap({
    required String swapId,
    required String refundAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });
  Future<SwapModel> createLbtcSubmarineSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required String invoice,
    required bool isTestnet,
    required String electrumUrl,
  });
  Future<void> coopSignLbtcSubmarineSwap({required String swapId});
  // TODO: add function to get invoice preimage
  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> refundLbtcSubmarineSwap({
    required String swapId,
    required String refundAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });

  // Chain Swap
  Future<(int, int)> getBtcToLbtcChainSwapLimits();
  Future<(int, int)> getLbtcToBtcChainSwapLimits();

  Future<SwapModel> createBtcToLbtcChainSwap({
    required String sendWalletId,
    required String mnemonic,
    required int index,
    required int amountSat,
    required bool isTestnet,
    required String btcElectrumUrl,
    required String lbtcElectrumUrl,
    String? receiveWalletId,
    String? externalRecipientAddress,
  });
  Future<SwapModel> createLbtcToBtcChainSwap({
    required String sendWalletId,
    required String mnemonic,
    required int index,
    required int amountSat,
    required bool isTestnet,
    required String btcElectrumUrl,
    required String lbtcElectrumUrl,
    String? receiveWalletId,
    String? externalRecipientAddress,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> claimBtcToLbtcChainSwap({
    required String swapId,
    required String claimLiquidAddress,
    required String refundBitcoinAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> claimLbtcToBtcChainSwap({
    required String swapId,
    required String claimBitcoinAddress,
    required String refundLiquidAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });
  Future<String> broadcastChainSwapClaim({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> refundBtcToLbtcChainSwap({
    required String swapId,
    required String refundBitcoinAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });

  /// Returns a signed tx hex which needs to be broadcasted
  Future<String> refundLbtcToBtcChainSwap({
    required String swapId,
    required String refundLiquidAddress,
    required int absoluteFees,
    required bool tryCooperate,
  });

  Future<String> broadcastChainSwapRefund({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  });

  // WebSocket stream handling - replace the old methods with these
  void subscribeToSwaps(List<String> swapIds);
  void unsubscribeToSwaps(List<String> swapIds);
  void resetStream();

  // Expose a standardized stream for the repository layer
  Stream<SwapModel> get swapUpdatesStream;
  // STORAGE
  BoltzStorageDataSourceImpl get storage;

  // Add connection management methods
  bool get isConnected;
  Future<void> reconnect();
}

class BoltzDataSourceImpl implements BoltzDataSource {
  final String _url;

  late BoltzWebSocket _boltzWebSocket;
  final BoltzStorageDataSourceImpl _boltzStore;

  final _swapUpdatesController = StreamController<SwapModel>.broadcast();

  // Connection state tracking
  bool _isConnected = false;
  Timer? _reconnectTimer;
  int _reconnectAttempts = 0;
  final _maxReconnectAttempts = 10;
  final List<String> _activeSwapIds = [];

  BoltzDataSourceImpl({
    String url = ApiServiceConstants.boltzMainnetUrlPath,
    required BoltzStorageDataSourceImpl boltzStore,
  })  : _url = url,
        _boltzStore = boltzStore {
    _initializeBoltzWebSocket();
  }

  @override
  bool get isConnected => _isConnected;

  @override
  BoltzStorageDataSourceImpl get storage => _boltzStore;

  @override
  Stream<SwapModel> get swapUpdatesStream => _swapUpdatesController.stream;

  // REVERSE SWAPS

  @override
  Future<SwapModel> createBtcReverseSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required int outAmount,
    required bool isTestnet,
    required String electrumUrl,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final reverseFees = await fees.reverse();
    final btcLnSwap = await BtcLnSwap.newReverse(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      outAmount: BigInt.from(outAmount),
      network: isTestnet ? Chain.bitcoinTestnet : Chain.bitcoin,
      electrumUrl: electrumUrl,
      boltzUrl: _url,
    );
    await _boltzStore.storeBtcLnSwap(btcLnSwap);
    final swapModel = SwapModel.lnReceive(
      id: btcLnSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.lightningToBitcoin.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      receiveWalletId: walletId,
      invoice: btcLnSwap.invoice,
      boltzFees: reverseFees.btcFees.percentage * outAmount ~/ 100,
      lockupFees: reverseFees.btcFees.minerFees.lockup.toInt(),
      claimFees: reverseFees.btcFees.minerFees.claim.toInt(),
    );
    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<String> claimBtcReverseSwap({
    required String swapId,
    required String claimAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final btcLnSwap = await _boltzStore.getBtcLnSwap(swapId);

    return btcLnSwap.claim(
      outAddress: claimAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<SwapModel> createLBtcReverseSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required int outAmount,
    required bool isTestnet,
    required String electrumUrl,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final reverseFees = await fees.reverse();
    final lbtcLnSwap = await LbtcLnSwap.newReverse(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      outAmount: BigInt.from(outAmount),
      network: isTestnet ? Chain.liquidTestnet : Chain.liquid,
      electrumUrl: electrumUrl,
      boltzUrl: _url,
    );

    await _boltzStore.storeLbtcLnSwap(lbtcLnSwap);

    final swapModel = SwapModel.lnReceive(
      id: lbtcLnSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.lightningToLiquid.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      receiveWalletId: walletId,
      invoice: lbtcLnSwap.invoice,
      boltzFees: reverseFees.lbtcFees.percentage * outAmount ~/ 100,
      lockupFees: reverseFees.lbtcFees.minerFees.lockup.toInt(),
      claimFees: reverseFees.lbtcFees.minerFees.claim.toInt(),
    );

    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<String> claimLBtcReverseSwap({
    required String swapId,
    required String claimAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final lbtcLnSwap = await _boltzStore.getLbtcLnSwap(swapId);

    return lbtcLnSwap.claim(
      outAddress: claimAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<String> broadcastBtcLnSwap({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  }) async {
    final btcLnSwap = await _boltzStore.getBtcLnSwap(swapId);

    return broadcastViaBoltz
        ? btcLnSwap.broadcastLocal(
            signedHex: signedTxHex,
          )
        : btcLnSwap.broadcastBoltz(
            signedHex: signedTxHex,
          );
  }

  @override
  Future<String> broadcastLbtcLnSwap({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  }) async {
    final lbtcLnSwap = await _boltzStore.getLbtcLnSwap(swapId);

    return broadcastViaBoltz
        ? lbtcLnSwap.broadcastLocal(
            signedHex: signedTxHex,
          )
        : lbtcLnSwap.broadcastBoltz(
            signedHex: signedTxHex,
          );
  }

  // SUBMARINE SWAPS
  // @override
  // Future<swap_entity.SubmarineSwapFeesAndLimits>
  //     getSubmarineFeesAndLimits() async {
  //   final fees = Fees(boltzUrl: _url);
  //   final submarine = await fees.submarine();
  //   return submarine.toDomainEntity();
  // }

  @override
  Future<SwapModel> createBtcSubmarineSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required String invoice,
    required bool isTestnet,
    required String electrumUrl,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final submarineFees = await fees.submarine();
    final btcLnSwap = await BtcLnSwap.newSubmarine(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      invoice: invoice,
      network: isTestnet ? Chain.bitcoinTestnet : Chain.bitcoin,
      electrumUrl: electrumUrl,
      boltzUrl: _url,
    );

    await _boltzStore.storeBtcLnSwap(btcLnSwap);

    final swapModel = SwapModel.lnSend(
      id: btcLnSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.bitcoinToLightning.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      sendWalletId: walletId,
      invoice: invoice,
      boltzFees: submarineFees.btcFees.percentage *
          (btcLnSwap.outAmount.toInt()) ~/
          100,
      lockupFees: submarineFees.btcFees.minerFees.toInt(),
      claimFees: submarineFees.btcFees.minerFees.toInt(),
    );

    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<void> coopSignBtcSubmarineSwap({required String swapId}) async {
    final btcLnSwap = await _boltzStore.getBtcLnSwap(swapId);
    return btcLnSwap.coopCloseSubmarine();
  }

  @override
  Future<void> coopSignLbtcSubmarineSwap({required String swapId}) async {
    final lbtcLnSwap = await _boltzStore.getLbtcLnSwap(swapId);
    return lbtcLnSwap.coopCloseSubmarine();
  }

  @override
  Future<String> refundBtcSubmarineSwap({
    required String swapId,
    required String refundAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final btcLnSwap = await _boltzStore.getBtcLnSwap(swapId);
    return btcLnSwap.refund(
      outAddress: refundAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<SwapModel> createLbtcSubmarineSwap({
    required String walletId,
    required String mnemonic,
    required int index,
    required String invoice,
    required bool isTestnet,
    required String electrumUrl,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final submarineFees = await fees.submarine();
    final lbtcLnSwap = await LbtcLnSwap.newSubmarine(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      invoice: invoice,
      network: isTestnet ? Chain.liquidTestnet : Chain.liquid,
      electrumUrl: electrumUrl,
      boltzUrl: _url,
    );

    await _boltzStore.storeLbtcLnSwap(lbtcLnSwap);

    final swapModel = SwapModel.lnSend(
      id: lbtcLnSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.liquidToLightning.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      sendWalletId: walletId,
      invoice: invoice,
      boltzFees: submarineFees.lbtcFees.percentage *
          (lbtcLnSwap.outAmount.toInt()) ~/
          100,
      lockupFees: submarineFees.lbtcFees.minerFees.toInt(),
      claimFees: submarineFees.lbtcFees.minerFees.toInt(),
    );

    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<String> refundLbtcSubmarineSwap({
    required String swapId,
    required String refundAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final lbtcLnSwap = await _boltzStore.getLbtcLnSwap(swapId);
    return lbtcLnSwap.refund(
      outAddress: refundAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  // // CHAIN SWAPS
  // @override
  // Future<ChainFeesAndLimits> getChainFeesAndLimits() async {
  //   final fees = Fees(boltzUrl: _url);
  //   final chain = await fees.chain();
  //   return chain;
  // }

  @override
  Future<SwapModel> createBtcToLbtcChainSwap({
    required String sendWalletId,
    required String mnemonic,
    required int index,
    required int amountSat,
    required bool isTestnet,
    required String btcElectrumUrl,
    required String lbtcElectrumUrl,
    String? receiveWalletId,
    String? externalRecipientAddress,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final chainFees = await fees.chain();
    final chainSwap = await ChainSwap.newSwap(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      boltzUrl: _url,
      direction: ChainSwapDirection.btcToLbtc,
      amount: BigInt.from(amountSat),
      isTestnet: isTestnet,
      btcElectrumUrl: btcElectrumUrl,
      lbtcElectrumUrl: lbtcElectrumUrl,
    );

    await _boltzStore.storeChainSwap(chainSwap);

    final swapModel = SwapModel.chain(
      id: chainSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.bitcoinToLiquid.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      sendWalletId: sendWalletId,
      receiveWalletId: receiveWalletId,
      receiveAddress: externalRecipientAddress,
      boltzFees: chainFees.lbtcFees.percentage * amountSat ~/ 100 +
          chainFees.lbtcFees.server.toInt(),
      lockupFees: chainFees.btcFees.userLockup.toInt(),
      claimFees: chainFees.lbtcFees.userClaim.toInt(),
    );

    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<SwapModel> createLbtcToBtcChainSwap({
    required String sendWalletId,
    required String mnemonic,
    required int index,
    required int amountSat,
    required bool isTestnet,
    required String btcElectrumUrl,
    required String lbtcElectrumUrl,
    String? receiveWalletId,
    String? externalRecipientAddress,
  }) async {
    final fees = Fees(boltzUrl: _url);
    final chainFees = await fees.chain();

    final chainSwap = await ChainSwap.newSwap(
      mnemonic: mnemonic,
      index: BigInt.from(index),
      boltzUrl: _url,
      direction: ChainSwapDirection.lbtcToBtc,
      amount: BigInt.from(amountSat),
      isTestnet: isTestnet,
      btcElectrumUrl: btcElectrumUrl,
      lbtcElectrumUrl: lbtcElectrumUrl,
    );

    await _boltzStore.storeChainSwap(chainSwap);

    final swapModel = SwapModel.chain(
      id: chainSwap.id,
      status: swap_entity.SwapStatus.pending.name,
      type: swap_entity.SwapType.liquidToBitcoin.name,
      isTestnet: isTestnet,
      keyIndex: index,
      creationTime: DateTime.now().millisecondsSinceEpoch,
      sendWalletId: sendWalletId,
      receiveWalletId: receiveWalletId,
      receiveAddress: externalRecipientAddress,
      boltzFees: chainFees.btcFees.percentage * amountSat ~/ 100 +
          chainFees.btcFees.server.toInt(),
      lockupFees: chainFees.lbtcFees.userLockup.toInt(),
      claimFees: chainFees.btcFees.userClaim.toInt(),
    );

    await _boltzStore.store(swapModel);
    return swapModel;
  }

  @override
  Future<String> broadcastChainSwapRefund({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return broadcastViaBoltz
        ? chainSwap.broadcastLocal(
            signedHex: signedTxHex,
            kind: SwapTxKind.refund,
          )
        : chainSwap.broadcastBoltz(
            signedHex: signedTxHex,
            kind: SwapTxKind.refund,
          );
  }

  @override
  Future<String> claimBtcToLbtcChainSwap({
    required String swapId,
    required String claimLiquidAddress,
    required String refundBitcoinAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return await chainSwap.claim(
      outAddress: claimLiquidAddress,
      refundAddress: refundBitcoinAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<String> claimLbtcToBtcChainSwap({
    required String swapId,
    required String claimBitcoinAddress,
    required String refundLiquidAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return await chainSwap.claim(
      outAddress: claimBitcoinAddress,
      refundAddress: refundLiquidAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<String> broadcastChainSwapClaim({
    required String swapId,
    required String signedTxHex,
    required bool broadcastViaBoltz,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return broadcastViaBoltz
        ? chainSwap.broadcastLocal(
            signedHex: signedTxHex,
            kind: SwapTxKind.claim,
          )
        : chainSwap.broadcastBoltz(
            signedHex: signedTxHex,
            kind: SwapTxKind.claim,
          );
  }

  @override
  Future<String> refundBtcToLbtcChainSwap({
    required String swapId,
    required String refundBitcoinAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return await chainSwap.refund(
      refundAddress: refundBitcoinAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<String> refundLbtcToBtcChainSwap({
    required String swapId,
    required String refundLiquidAddress,
    required int absoluteFees,
    required bool tryCooperate,
  }) async {
    final chainSwap = await _boltzStore.getChainSwap(swapId);
    return await chainSwap.refund(
      refundAddress: refundLiquidAddress,
      minerFee: TxFee.absolute(BigInt.from(absoluteFees)),
      tryCooperate: tryCooperate,
    );
  }

  @override
  Future<(int, int)> getBtcReverseSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final reverse = await fees.reverse();
    return (
      reverse.btcLimits.minimal.toInt(),
      reverse.btcLimits.maximal.toInt()
    );
  }

  @override
  Future<(int, int)> getLbtcReverseSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final reverse = await fees.reverse();
    return (
      reverse.lbtcLimits.minimal.toInt(),
      reverse.lbtcLimits.maximal.toInt()
    );
  }

  @override
  Future<(int, int)> getBtcSubmarineSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final submarine = await fees.submarine();
    return (
      submarine.btcLimits.minimal.toInt(),
      submarine.btcLimits.maximal.toInt()
    );
  }

  @override
  Future<(int, int)> getLbtcSubmarineSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final submarine = await fees.submarine();
    return (
      submarine.lbtcLimits.minimal.toInt(),
      submarine.lbtcLimits.maximal.toInt()
    );
  }

  @override
  Future<(int, int)> getBtcToLbtcChainSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final chain = await fees.chain();
    return (chain.btcLimits.minimal.toInt(), chain.btcLimits.maximal.toInt());
  }

  @override
  Future<(int, int)> getLbtcToBtcChainSwapLimits() async {
    final fees = Fees(boltzUrl: _url);
    final chain = await fees.chain();
    return (chain.lbtcLimits.minimal.toInt(), chain.lbtcLimits.maximal.toInt());
  }

  void _initializeBoltzWebSocket() {
    try {
      _boltzWebSocket = BoltzWebSocket.create(_url);
      _isConnected = true;
      _reconnectAttempts = 0;

      _boltzWebSocket.stream.listen(
        (event) async {
          final swapId = event.id;
          final boltzStatus = event.status;
          try {
            final swapModel = await _boltzStore.get(swapId);
            if (swapModel == null) {
              print('No swap found for id: $swapId');
              return;
            }

            // Check if swap is already in terminal state
            final swapCompleted =
                swapModel.status == swap_entity.SwapStatus.completed.name;
            final swapFailed =
                swapModel.status == swap_entity.SwapStatus.failed.name;
            final swapExpired =
                swapModel.status == swap_entity.SwapStatus.expired.name;

            if (swapCompleted || swapFailed || swapExpired) {
              // Unsubscribe from the swap if it's in a terminal state
              unsubscribeToSwaps([swapId]);
              return;
            }

            // Process the event
            SwapModel? updatedSwapModel;
            switch (boltzStatus) {
              case SwapStatus.swapCreated:
              case SwapStatus.invoiceSet:
              case SwapStatus.invoicePending:
              case SwapStatus.minerfeePaid:
                // No action needed for these status updates
                return;

              case SwapStatus.invoicePaid:
              case SwapStatus.txnClaimPending:
                // Handle cooperative closing for submarine swaps
                if (swapModel is LnSendSwapModel) {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.canCoop.name,
                  );
                }

              case SwapStatus.invoiceSettled:
                // Invoice settled for reverse swaps
                if (swapModel is LnReceiveSwapModel) {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.claimable.name,
                  );
                }

              case SwapStatus.invoiceFailedToPay:
                // Failed submarine swap
                if (swapModel is LnSendSwapModel) {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.refundable.name,
                  );
                }

              case SwapStatus.txnMempool:
                // For reverse swaps on Liquid, no confirmation needed
                if (swapModel is LnReceiveSwapModel) {
                  final type = swapModel.type;
                  if (type == swap_entity.SwapType.lightningToLiquid.name) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.claimable.name,
                    );
                  }
                }

              case SwapStatus.txnConfirmed:
                // For reverse swaps on Bitcoin or chain swaps
                if (swapModel is LnReceiveSwapModel ||
                    swapModel is ChainSwapModel) {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.claimable.name,
                  );
                }

              case SwapStatus.txnClaimed:
                // Swap has been claimed successfully
                updatedSwapModel = swapModel.copyWith(
                  status: swap_entity.SwapStatus.completed.name,
                  completionTime: DateTime.now().millisecondsSinceEpoch,
                );

              case SwapStatus.txnRefunded:
                // Check if this swap needs to be refunded (no refundTxid)
                if (swapModel is ChainSwapModel ||
                    swapModel is LnSendSwapModel) {
                  final refunded = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).refundTxid != null
                      : (swapModel as LnSendSwapModel).refundTxid != null;

                  if (!refunded) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.refundable.name,
                    );
                  } else {
                    // Already refunded, mark as completed
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.completed.name,
                      completionTime: DateTime.now().millisecondsSinceEpoch,
                    );
                  }
                } else if (swapModel is LnReceiveSwapModel) {
                  // For reverse swaps, this means failure
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.failed.name,
                  );
                }

              case SwapStatus.txnLockupFailed:
              case SwapStatus.txnFailed:
                // Transaction failed - check if refundable
                if (swapModel is ChainSwapModel ||
                    swapModel is LnSendSwapModel) {
                  final hasSentFunds = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).sendTxid != null
                      : (swapModel as LnSendSwapModel).sendTxid != null;

                  final hasRefunded = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).refundTxid != null
                      : (swapModel as LnSendSwapModel).refundTxid != null;

                  if (hasSentFunds && !hasRefunded) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.refundable.name,
                    );
                  } else {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.failed.name,
                    );
                  }
                }

              case SwapStatus.swapExpired:
              case SwapStatus.invoiceExpired:
                // Check if funds were sent but not refunded
                if (swapModel is ChainSwapModel ||
                    swapModel is LnSendSwapModel) {
                  final hasSentFunds = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).sendTxid != null
                      : (swapModel as LnSendSwapModel).sendTxid != null;

                  final hasRefunded = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).refundTxid != null
                      : (swapModel as LnSendSwapModel).refundTxid != null;

                  if (hasSentFunds && !hasRefunded) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.refundable.name,
                    );
                  } else {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.expired.name,
                    );
                  }
                } else if (swapModel is LnReceiveSwapModel) {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.expired.name,
                  );
                }

              case SwapStatus.swapRefunded:
                if (swapModel is ChainSwapModel ||
                    swapModel is LnSendSwapModel) {
                  final hasRefunded = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).refundTxid != null
                      : (swapModel as LnSendSwapModel).refundTxid != null;

                  if (!hasRefunded) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.refundable.name,
                    );
                  } else {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.completed.name,
                      completionTime: DateTime.now().millisecondsSinceEpoch,
                    );
                  }
                }

              case SwapStatus.swapError:
                // Handle error states
                if (swapModel is ChainSwapModel ||
                    swapModel is LnSendSwapModel) {
                  final hasSentFunds = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).sendTxid != null
                      : (swapModel as LnSendSwapModel).sendTxid != null;

                  final hasRefunded = swapModel is ChainSwapModel
                      ? (swapModel as ChainSwapModel).refundTxid != null
                      : (swapModel as LnSendSwapModel).refundTxid != null;

                  if (hasSentFunds && !hasRefunded) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.refundable.name,
                    );
                  } else {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.failed.name,
                    );
                  }
                } else {
                  updatedSwapModel = swapModel.copyWith(
                    status: swap_entity.SwapStatus.failed.name,
                  );
                }

              case SwapStatus.txnServerMempool:
              case SwapStatus.txnServerConfirmed:
                // Handle server-side transaction states
                if (swapModel is ChainSwapModel) {
                  final type = swapModel.type;
                  // For liquid swaps, mempool is enough, BTC needs confirmation
                  final isLiquid =
                      type == swap_entity.SwapType.bitcoinToLiquid.name;
                  final isMempoolEnough =
                      isLiquid && boltzStatus == SwapStatus.txnServerMempool;
                  final isConfirmed =
                      boltzStatus == SwapStatus.txnServerConfirmed;

                  if (isMempoolEnough || isConfirmed) {
                    updatedSwapModel = swapModel.copyWith(
                      status: swap_entity.SwapStatus.claimable.name,
                    );
                  }
                }
            }

            // Update storage and emit event if status changed
            if (updatedSwapModel != null &&
                updatedSwapModel.status != swapModel.status) {
              await _boltzStore.store(updatedSwapModel);
              print(
                  'Updated swap $swapId from ${swapModel.status} to ${updatedSwapModel.status}');
              _swapUpdatesController.add(updatedSwapModel);
            }
          } catch (e) {
            print('Error processing swap status update: $e');
          }
        },
        onError: (error) {
          print('Boltz WebSocket error: $error');
          _isConnected = false;
          _swapUpdatesController.addError(error as Error);
          _scheduleReconnect();
        },
        onDone: () {
          print('Boltz WebSocket connection closed');
          _isConnected = false;
          _scheduleReconnect();
        },
      );

      // If we have active swap IDs, resubscribe after reconnection
      if (_activeSwapIds.isNotEmpty) {
        subscribeToSwaps(_activeSwapIds);
      }
    } catch (e) {
      _isConnected = false;
      print('Error initializing BoltzWebSocket: $e');
      _scheduleReconnect();
      // Don't rethrow here to allow for graceful recovery
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      print('Max reconnect attempts reached. Giving up.');
      return;
    }
    // Exponential backoff strategy
    final delay =
        Duration(milliseconds: 1000 * pow(2, _reconnectAttempts).round());
    print(
        'Scheduling reconnect attempt ${_reconnectAttempts + 1} in ${delay.inSeconds} seconds');

    _reconnectTimer = Timer(delay, () {
      _reconnectAttempts++;
      reconnect();
    });
  }

  @override
  Future<void> reconnect() async {
    try {
      print('Attempting to reconnect to Boltz WebSocket...');
      resetStream();
    } catch (e) {
      print('Failed to reconnect: $e');
      _scheduleReconnect();
    }
  }

  @override
  void resetStream() {
    try {
      _boltzWebSocket.dispose();
    } catch (e) {
      print('Error disposing WebSocket: $e');
    }
    _initializeBoltzWebSocket();
  }

  @override
  void subscribeToSwaps(List<String> swapIds) {
    _activeSwapIds.addAll(swapIds);
    final uniqueIds = _activeSwapIds.toSet().toList();
    _activeSwapIds.clear();
    _activeSwapIds.addAll(uniqueIds);

    if (!_isConnected) {
      print(
        'Cannot subscribe to swaps: WebSocket not connected. Will subscribe on reconnect.',
      );
      _scheduleReconnect();
      return;
    }

    try {
      _boltzWebSocket.subscribe(swapIds);
    } catch (e) {
      print('Error subscribing to swaps: $e');
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  @override
  void unsubscribeToSwaps(List<String> swapIds) {
    _activeSwapIds.removeWhere((id) => swapIds.contains(id));
    if (!_isConnected) {
      print(
        'Cannot subscribe to swaps: WebSocket not connected. Will subscribe on reconnect.',
      );
      _scheduleReconnect();
      return;
    }
    try {
      _boltzWebSocket.unsubscribe(swapIds);
    } catch (e) {
      print('Error unsubscribing from swaps: $e');
      _isConnected = false;
      _scheduleReconnect();
    }
  }

  void dispose() {
    _reconnectTimer?.cancel();
    _swapUpdatesController.close();
    try {
      _boltzWebSocket.dispose();
    } catch (e) {
      print('Error disposing WebSocket: $e');
    }
  }
}
