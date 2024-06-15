// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/router.dart';
import 'package:bb_arch/wallet-setup/cubit/wallet_recover_page_cubit.dart';
import 'package:bb_arch/wallet-setup/view/wallet_type_selection_page.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletCreateScaffold extends StatelessWidget {
  const WalletCreateScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final seed =
        context.select((WalletSensitiveBloc cubit) => cubit.state.seed);
    final status =
        context.select((WalletSensitiveBloc cubit) => cubit.state.status);
    final walletName = context.select((WalletSensitiveBloc cubit) =>
        cubit.state.seed?.mnemonic.split(' ').getRange(0, 2).join('-') ??
        'wallet-name');
    return BBScaffold(
        title: 'Wallet Create',
        loadStatus: status,
        child: status == LoadStatus.success
            ? WalletCreateView(
                seed: seed!,
                walletName: walletName,
              )
            : const Text('Loading...'));
  }
}

class WalletCreateView extends StatefulWidget {
  const WalletCreateView(
      {super.key, required this.seed, required this.walletName});

  final Seed seed;
  final String walletName;

  @override
  WalletCreateViewState createState() => WalletCreateViewState();
}

class WalletCreateViewState extends State<WalletCreateView> {
  WalletType _selectedAsset = WalletType.Bitcoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Mnemonic:'),
          Text(widget.seed.mnemonic),
          const SizedBox(height: 8),
          const Text('Wallet name:'),
          Text(widget.walletName),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: const Text('Bitcoin'),
                  leading: Radio<WalletType>(
                    value: WalletType.Bitcoin,
                    groupValue: _selectedAsset,
                    onChanged: (value) {
                      setState(() {
                        _selectedAsset = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAsset = WalletType.Bitcoin;
                    });
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text('Liquid'),
                  leading: Radio<WalletType>(
                    value: WalletType.Liquid,
                    groupValue: _selectedAsset,
                    onChanged: (value) {
                      setState(() {
                        _selectedAsset = value!;
                      });
                    },
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAsset = WalletType.Liquid;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
              onPressed: () async {
                print('Create clicked');

                navigateToWalletTypePage(
                    context,
                    widget.seed.mnemonic,
                    widget.seed.passphrase,
                    widget.walletName,
                    _selectedAsset.name);

                // final (seedFingerprint, _) = await widget.seed
                //     .getBdkFingerprint(NetworkType.Testnet); // TODO:
                // final newSeed =
                //     widget.seed.copyWith(fingerprint: seedFingerprint ?? '');
                // context.read<WalletSensitiveBloc>().add(
                //     DeriveWalletFromStoredSeed(
                //         seed: newSeed,
                //         walletName: widget.walletName,
                //         walletType: _selectedAsset,
                //         networkType: NetworkType.Testnet)); // TODO:
                // GoRouter.of(context).push(WalletTypeSelectionPage.route);
              },
              child: const Text('Create wallet')),
        ],
      ),
    );
  }
}
