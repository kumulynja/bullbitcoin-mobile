enum LoadStatus { initial, loading, success, failure }

extension LoadStatusExtension on LoadStatus {
  String get name {
    switch (this) {
      case LoadStatus.initial:
        return 'initial';
      case LoadStatus.loading:
        return 'loading';
      case LoadStatus.success:
        return 'success';
      case LoadStatus.failure:
        return 'failure';
    }
  }
}

abstract class ErrorState {
  Error? get error;
}
