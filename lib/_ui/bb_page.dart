import 'package:bb_arch/_pkg/error.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BBScaffold extends StatelessWidget {
  final String title;
  final Widget? child;
  final List<BlocBase<ExceptionState>>? blocs;
  final List<Type>? clearErrorEvents;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final LoadStatus? loadStatus;
  final String? errorText;

  const BBScaffold(
      {super.key,
      required this.title,
      this.child,
      this.blocs,
      this.clearErrorEvents,
      this.actions,
      this.floatingActionButton,
      this.loadStatus = LoadStatus.success,
      this.errorText = ''});

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget = SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );

    if (loadStatus == LoadStatus.success) {
      bodyWidget = child!;
    } else if (loadStatus == LoadStatus.failure) {
      bodyWidget = Text(errorText!);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: actions,
      ),
      body: (blocs != null)
          ? MultiBlocListener(
              listeners: blocs!
                  .asMap()
                  .entries
                  .map((entry) =>
                      BlocListener<BlocBase<ExceptionState>, ExceptionState>(
                        bloc: entry.value,
                        listener: (context, state) {
                          if (state.error != null) {
                            _showErrorDialog(context, state.error!);
                            int index = entry.key;
                            Type? clearErrorEvent = clearErrorEvents != null
                                ? clearErrorEvents![index]
                                : null;
                            if (clearErrorEvent != null) {
                              (entry.value as Bloc)
                                  .add(EventFactory.create(clearErrorEvent));
                            }
                          }
                        },
                      ))
                  .toList(),
              child: bodyWidget,
            )
          : bodyWidget,
      floatingActionButton:
          loadStatus == LoadStatus.success ? floatingActionButton : null,
    );
  }

  void _showErrorDialog(BuildContext context, Exception error) {
    String title = 'Error';
    String msg = error.toString();
    String desc = '';
    if (error is BBException) {
      title = error.title ?? 'Error';
      msg = error.message ?? error.toString();
      desc = error.description ?? '';
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('$msg\n\n$desc'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("OK"),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class EventFactory {
  static WalletEvent create(Type type) {
    if (type == WalletBlocClearError) {
      return WalletBlocClearError();
    }
    throw ArgumentError('Unknown event type: $type');
  }
}
