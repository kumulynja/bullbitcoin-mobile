import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/settings/view/settings_page.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/tx/widgets/tx_list.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/widgets/wallets_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = RepositoryProvider.of<BBLogger>(context);
    final loadStatus = context.select((WalletBloc cubit) => cubit.state.status);
    final wallets = context.select((WalletBloc cubit) => cubit.state.wallets);
    final syncStatus =
        context.select((WalletBloc cubit) => cubit.state.syncWalletStatus);
    final txsStatus = context.select((TxBloc cubit) => cubit.state.status);
    final txs = context.select((TxBloc cubit) => cubit.state.txs);

    logger.log('HomeView :: build : $loadStatus');

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
              context.read<WalletBloc>().add(SyncAllWallets());
            },
            tooltip: 'Sync',
            heroTag: 'syncTag',
            child: const Icon(Icons.cloud_sync),
          ),
        ],
      ),
      child: HomeView(
        wallets: wallets,
        syncStatus: syncStatus,
        txsStatus: txsStatus,
        txs: txs,
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
    required this.wallets,
    required this.syncStatus,
    required this.txsStatus,
    required this.txs,
  });

  final List<Wallet> wallets;
  final List<LoadStatus> syncStatus;
  final LoadStatus txsStatus;
  final List<Tx> txs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: WalletList(wallets: wallets, syncStatus: syncStatus),
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
                : TxList(
                    txs: txs,
                  ),
          ),
        ),
      ],
    );
  }
}
