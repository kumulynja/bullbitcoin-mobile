import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletList extends StatelessWidget {
  const WalletList({
    super.key,
    required this.walletBlocs,
  });

  final List<WalletBloc> walletBlocs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final walletBloc = walletBlocs[index];
        return BlocProvider(
            create: (context) => walletBloc, child: WalletListItem());
      },
      itemCount: walletBlocs.length,
    );
  }
}

class WalletListItem extends StatelessWidget {
  const WalletListItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletBloc bloc) => bloc.state.wallet);
    final status = context.select((WalletBloc bloc) => bloc.state.status);

    print('WalletTile :: build (${wallet?.name}) loadStatus: $status');

    if (wallet == null) {
      return const CircularProgressIndicator();
    }

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
        // context.read<TxBloc>().add(LoadTxs(wallet: wallet));
        // context.read<TxBloc>().add(SyncTxs(wallet: wallet));
        GoRouter.of(context).push('/wallet/${wallet.id}');
      },
    );
  }
}
