import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletBloc bloc) => bloc.state.wallet);
    final status = context.select((WalletBloc bloc) => bloc.state.status);

    BBLogger()
        .logBuild('WalletTile :: build (${wallet?.name}) loadStatus: $status');

    if (wallet == null) {
      return const CircularProgressIndicator();
    }

    return WalletCardWidget(wallet: wallet, status: status);
  }
}

// TODO: Logics for different wallet types and their view goes in here.
class WalletCardWidget extends StatelessWidget {
  const WalletCardWidget({
    super.key,
    required this.wallet,
    required this.status,
  });

  final Wallet wallet;
  final LoadStatus status;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text('${wallet.name} (${wallet.type.name}: ${wallet.network.name})'),
      subtitle:
          Text('Tx: ${wallet.txCount}, Balance: ${wallet.balance.toString()}'),
      leading: status.name == 'loading'
          ? const CircularProgressIndicator()
          : status.name == 'initial'
              ? const Icon(Icons.hourglass_empty)
              : const Icon(Icons.check),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        context.read<WalletListBloc>().add(SelectWallet(wallet: wallet));
        GoRouter.of(context).push('/wallet/${wallet.id}');
      },
    );
  }
}
