import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  SimpleBlocObserver({required this.logger});

  final BBLogger logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (error is WalletLoadException) {
      logger.error(
          '${bloc.runtimeType}: ${error.error.toString()}', stackTrace);
    } else if (error is JsonParseException) {
      logger.error(
          '${bloc.runtimeType}: ParseException (${error.modal}): ${error.error.toString()}',
          stackTrace);
    } else if (error is BdkElectrumException) {
      logger.error(
          '${bloc.runtimeType}: BdkElectrumException ${error.serverUrl ?? ''}: ${error.error.toString()}',
          stackTrace);
    } else {
      logger.error(error.toString(), stackTrace);
    }
    super.onError(bloc, error, stackTrace);
  }
}
