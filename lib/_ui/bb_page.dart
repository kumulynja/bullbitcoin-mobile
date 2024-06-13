import 'package:bb_arch/_pkg/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BBScaffold extends StatelessWidget {
  final String title;
  final Widget? child;
  final List<BlocBase<ExceptionState>>? blocs;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final LoadStatus? loadStatus;
  final String? errorText;

  const BBScaffold(
      {super.key,
      required this.title,
      this.child,
      this.blocs,
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
                  .map((bloc) =>
                      BlocListener<BlocBase<ExceptionState>, ExceptionState>(
                        bloc: bloc,
                        listener: (context, state) {
                          if (state.error != null) {
                            _showErrorDialog(context, state.error!);
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(error.toString()),
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
