import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/settings/view/settings_page.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/tx/widgets/tx_list.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:bb_arch/wallet/widgets/wallets_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final loadStatus =
        context.select((WalletListBloc cubit) => cubit.state.status);
    // final txsStatus = context.select((TxBloc cubit) => cubit.state.status);

    /*
    final finalStatus =
        loadStatus == LoadStatus.success && txsStatus == LoadStatus.success
            ? LoadStatus.success
            : LoadStatus.loading;
            */

    BBLogger().logBuild('HomeScaffold :: build : $loadStatus');

    return BBScaffold(
      title: 'Bull Bitcoin',
      actions: [
        loadStatus == LoadStatus.loading
            ? const CircularProgressIndicator()
            : const SizedBox.shrink(),
        IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () {
              GoRouter.of(context).push(SettingsPage.route);
            }),
      ],
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              print('Action 1');
            },
            tooltip: 'Load',
            heroTag: 'loadTag',
            child: const Icon(Icons.sync),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              context.read<WalletListBloc>().add(SyncAllWallets());
            },
            tooltip: 'Sync',
            heroTag: 'syncTag',
            child: const Icon(Icons.cloud_sync),
          ),
        ],
      ),
      child: loadStatus == LoadStatus.success
          ? const HomeView()
          : const Text('Loading...'),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final txs = context.select((TxBloc cubit) => cubit.state.txs);
    final txsStatus = context.select((TxBloc cubit) => cubit.state.status);
    BBLogger().logBuild('HomeView :: build');

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: WalletList(),
        ),
        Container(
          color: Colors.grey,
          height: 4,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: txsStatus == LoadStatus.loading
                ? const CircularProgressIndicator()
                : TxListWidget(
                    txs: txs,
                  ),
          ),
        ),
      ],
    );
  }
}
