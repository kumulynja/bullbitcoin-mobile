import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class PayjoinState with _$PayjoinState {
  const factory PayjoinState({
    @Default('') String payjoinUri,
    @Default('') String toast,
    @Default(true) bool isReceiver,
    @Default(false) bool isAwaiting,
  }) = _PayjoinState;

  const PayjoinState._();
}
