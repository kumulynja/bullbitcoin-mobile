import 'package:bb_mobile/_core/domain/entities/electrum_server.dart';
import 'package:bb_mobile/_core/domain/entities/wallet_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'electrum_server_model.freezed.dart';
part 'electrum_server_model.g.dart';

@freezed
class ElectrumServerModel with _$ElectrumServerModel {
  factory ElectrumServerModel({
    required String url,
    String? socks5,
    required int retry,
    int? timeout,
    required int stopGap,
    required bool validateDomain,
    required bool isTestnet,
    required bool isLiquid,
  }) = _ElectrumServerModel;
  const ElectrumServerModel._();

  factory ElectrumServerModel.fromJson(Map<String, dynamic> json) =>
      _$ElectrumServerModelFromJson(json);

  ElectrumServer toEntity() {
    // toEntity is always to a custom ElectrumServer, since only the custom ones
    //  should be stored as a model. The default ones are defined with constants
    //  in the entity class.
    return ElectrumServer.custom(
      url: url,
      network:
          Network.fromEnvironment(isTestnet: isTestnet, isLiquid: isLiquid),
      socks5: socks5,
      stopGap: stopGap,
      timeout: timeout ?? 5,
      retry: retry,
      validateDomain: validateDomain,
    );
  }
}
