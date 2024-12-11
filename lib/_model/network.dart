import 'package:bb_mobile/_model/wallet.dart';
import 'package:bb_mobile/_pkg/consts/configs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network.freezed.dart';
part 'network.g.dart';

enum ElectrumTypes { blockstream, bullbitcoin, custom }

enum LiquidElectrumTypes { blockstream, bullbitcoin, custom }

@freezed
class ElectrumNetwork with _$ElectrumNetwork {
  const factory ElectrumNetwork.bullbitcoin({
    @Default('ssl://$bbelectrumMain') String mainnet,
    @Default('ssl://$bbelectrumTest') String testnet,
    @Default(20) int stopGap,
    @Default(5) int timeout,
    @Default(5) int retry,
    @Default(true) bool validateDomain,
    @Default('bullbitcoin') String name,
    @Default(ElectrumTypes.bullbitcoin) ElectrumTypes type,
  }) = _BullbitcoinElectrumNetwork;

  const factory ElectrumNetwork.defaultElectrum({
    @Default('ssl://$openelectrumMain') String mainnet,
    @Default('ssl://$openelectrumTest') String testnet,
    @Default(20) int stopGap,
    @Default(5) int timeout,
    @Default(5) int retry,
    @Default(true) bool validateDomain,
    @Default('blockstream') String name,
    @Default(ElectrumTypes.blockstream) ElectrumTypes type,
  }) = _DefaultElectrumNetwork;

  const factory ElectrumNetwork.custom({
    required String mainnet,
    required String testnet,
    @Default(20) int stopGap,
    @Default(5) int timeout,
    @Default(5) int retry,
    @Default(true) bool validateDomain,
    @Default('custom') String name,
    @Default(ElectrumTypes.custom) ElectrumTypes type,
  }) = _CustomElectrumNetwork;

  const ElectrumNetwork._();

  factory ElectrumNetwork.fromJson(Map<String, dynamic> json) =>
      _$ElectrumNetworkFromJson(json);

  String getNetworkUrl(BBNetwork network, {bool split = false}) {
    String url;
    switch (network) {
      case BBNetwork.Mainnet:
        url = mainnet;
      case BBNetwork.Testnet:
        url = testnet;
      case BBNetwork.Regtest:
        return '';
      default:
        return '';
    }

    if (split) {
      final spliturl = url.split('://');
      if (spliturl.length > 1) url = spliturl[1];
    }

    return url;
  }
}

@freezed
class LiquidElectrumNetwork with _$LiquidElectrumNetwork {
  const factory LiquidElectrumNetwork.blockstream({
    @Default(liquidElectrumUrl) String mainnet,
    @Default(liquidElectrumTestUrl) String testnet,
    @Default(true) bool validateDomain,
    @Default('blockstream') String name,
    @Default(LiquidElectrumTypes.blockstream) LiquidElectrumTypes type,
  }) = _BlockstreamLiquidElectrumNetwork;

  const factory LiquidElectrumNetwork.bullbitcoin({
    @Default(bbLiquidElectrumUrl) String mainnet,
    @Default(bbLiquidElectrumTestUrl) String testnet,
    @Default(true) bool validateDomain,
    @Default('bullbitcoin') String name,
    @Default(LiquidElectrumTypes.bullbitcoin) LiquidElectrumTypes type,
  }) = _BullBitcoinLiquidElectrumNetwork;

  const factory LiquidElectrumNetwork.custom({
    required String mainnet,
    required String testnet,
    @Default(true) bool validateDomain,
    @Default('custom') String name,
    @Default(LiquidElectrumTypes.custom) LiquidElectrumTypes type,
  }) = _CustomLiquidElectrumNetwork;

  const LiquidElectrumNetwork._();

  factory LiquidElectrumNetwork.fromJson(Map<String, dynamic> json) =>
      _$LiquidElectrumNetworkFromJson(json);

  String getNetworkUrl(BBNetwork network) {
    switch (network) {
      case BBNetwork.Mainnet:
        return mainnet;
      case BBNetwork.Testnet:
        return testnet;
      case BBNetwork.Regtest:
        return '';
      default:
        return '';
    }
  }

  // String getNetworkUrl(bool isTestnet, {bool split = true}) {
  //   String url;
  //   if (isTestnet)
  //     url = testnet;
  //   else
  //     url = mainnet;

  //   if (split) url = url.split('://')[1];

  //   return url;
  // }
}
