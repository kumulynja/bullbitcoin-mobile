// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/receive/view/widgets/bitcoin_receive_view.dart';
import 'package:bb_arch/receive/view/widgets/lightning_receive_view.dart';
import 'package:bb_arch/receive/view/widgets/liquid_receive_view.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReceiveScaffold extends StatelessWidget {
  const ReceiveScaffold({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    final loadStatus =
        context.select((WalletListBloc cubit) => cubit.state.status);
    final wallets = context.select((WalletListBloc cubit) => cubit
        .state.walletBlocs
        .where((bloc) => bloc.state.wallet != null)
        .map((bloc) => bloc.state.wallet!)
        .toList());
    return BBScaffold(
      title: 'Receive',
      loadStatus: loadStatus,
      child: ReceiveView(
        walletId: walletId,
        wallets: wallets,
      ),
    );
  }
}

enum ReceiveMethod {
  LIGHTNING,
  BITCOIN,
  LIQUID,
}

class ReceiveView extends StatefulWidget {
  const ReceiveView({super.key, required this.walletId, required this.wallets});

  final String walletId;
  final List<Wallet> wallets;

  @override
  State<ReceiveView> createState() => _ReceiveViewState();
}

class _ReceiveViewState extends State<ReceiveView> {
  ReceiveMethod selectedReceiveMethod = ReceiveMethod.BITCOIN;
  Wallet? selectedWallet;

  Widget buildReceiveWidget(ReceiveMethod selectedReceiveMethod) {
    Widget receiveWidget;
    switch (selectedReceiveMethod) {
      case ReceiveMethod.LIGHTNING:
        receiveWidget = const LightningReceive();
        break;
      case ReceiveMethod.BITCOIN:
        receiveWidget = const BitcoinReceive(
          address: '1Lbcfr7sAHTD9CgdQo3HTMTkV8LK4ZnX71',
        );
        break;
      case ReceiveMethod.LIQUID:
        receiveWidget = const LiquidReceive(
          address: 'bc1qar0srrr7xfkvy5l643lydnw9re59gt',
        );
        break;
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: receiveWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DropdownButton<String>(
                hint: const Text('Choose wallet'),
                items: widget.wallets.map((Wallet wallet) {
                  return DropdownMenuItem<String>(
                    value: wallet.id,
                    child: Text(wallet.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWallet = widget.wallets
                        .where((wallet) => wallet.id == value)
                        .first;
                  });
                },
                value: selectedWallet?.id,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SegmentedButton<ReceiveMethod>(
                segments: const <ButtonSegment<ReceiveMethod>>[
                  ButtonSegment<ReceiveMethod>(
                    value: ReceiveMethod.LIGHTNING,
                    label: Text('Lightning'),
                  ),
                  ButtonSegment<ReceiveMethod>(
                    value: ReceiveMethod.BITCOIN,
                    label: Text('Bitcoin'),
                  ),
                  ButtonSegment<ReceiveMethod>(
                    value: ReceiveMethod.LIQUID,
                    label: Text('Liquid'),
                  ),
                ],
                selected: {selectedReceiveMethod},
                onSelectionChanged: (Set<ReceiveMethod> newSelection) {
                  setState(() {
                    selectedReceiveMethod = newSelection.first;
                  });
                },
              ),
            ),
            buildReceiveWidget(selectedReceiveMethod),
          ],
        ),
      ),
    );
  }
}
