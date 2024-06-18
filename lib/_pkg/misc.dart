import 'package:bb_arch/_pkg/error.dart';

enum LoadStatus { initial, loading, success, exception, failure }

extension LoadStatusExtension on LoadStatus {
  String get name {
    switch (this) {
      case LoadStatus.initial:
        return 'initial';
      case LoadStatus.loading:
        return 'loading';
      case LoadStatus.success:
        return 'success';
      case LoadStatus.exception:
        return 'success';
      case LoadStatus.failure:
        return 'failure';
    }
  }
}

class BBEvent {}

class ClearEvent extends BBEvent {}

abstract class ExceptionState {
  BBException? get error;
}

T safeFromJson<T>(Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonFunction, String modal) {
  try {
    return fromJsonFunction(json);
  } catch (e, stackTrace) {
    Error.throwWithStackTrace(JsonParseException(e, modal: modal), stackTrace);
  }
}
