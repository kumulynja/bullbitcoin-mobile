import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:bb_arch/wallet/widgets/wallet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletList extends StatelessWidget {
  const WalletList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BBLogger().logBuild('WalletListWidget :: build');
    final walletBlocs =
        context.select((WalletListBloc cubit) => cubit.state.walletBlocs);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final walletBloc = walletBlocs[index];
        return BlocProvider(
            key: Key(walletBloc.state.wallet?.id ?? index.toString()),
            create: (context) => walletBloc,
            child: const WalletCard());
      },
      itemCount: walletBlocs.length,
    );
  }
}
