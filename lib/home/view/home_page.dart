import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/home/home.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final txRepository = context.read<TxRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(
            create: (_) => TxBloc(txRepository: txRepository)
              ..add(FetchLatestTxsAcrossWallets(limit: 10))),
      ],
      child: const HomeScaffold(),
    );
  }
}
