// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/address/models/bitcoin_address.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendScaffold extends StatelessWidget {
  const SendScaffold({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    return BBScaffold(
        title: 'Send',
        child: SendView(
          walletId: walletId,
        ));
  }
}

class SendView extends StatelessWidget {
  const SendView({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    final wallet = context.read<WalletBloc>().state.wallet;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Address'),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Amount'),
            const SizedBox(
              height: 10,
            ),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  print("Send :: Send btn clicked");
                  context.read<WalletBloc>().add(BuildTx(
                      wallet: wallet!,
                      address: BitcoinAddress(
                          address: 'tb1qeteg326txsxgq2p8cma44hh0x94gt7s6nyhwsh',
                          index: 0,
                          kind: AddressKind.external,
                          walletId: walletId,
                          balance: 0,
                          status: AddressStatus.active,
                          type: AddressType.Bitcoin),
                      amount: 1000));
                },
                child: const Text("Send"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
