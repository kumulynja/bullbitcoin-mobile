import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/router.dart';
import 'package:bb_arch/wallet-setup/cubit/wallet_recover_page_cubit.dart';
import 'package:bb_arch/wallet-setup/widgets/test_hardcoded_wallets.dart';
import 'package:bb_arch/wallet-setup/widgets/wallet_recover_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletRecoverScaffold extends StatelessWidget {
  const WalletRecoverScaffold({super.key});

  Future<String?> _asyncValidateSeedPhrase(
      BuildContext context, String seedPhrase) {
    return context
        .read<WalletRecoverPageCubit>()
        .validateSeedPhrase(seedPhrase);
  }

  void _handleSubmit(
      {required BuildContext context,
      required String seedPhrase,
      required String passphrase,
      required String walletName,
      required WalletType assetName}) {
    navigateToWalletTypePage(
        context, seedPhrase, passphrase, walletName, assetName.name);
  }

  @override
  Widget build(BuildContext context) {
    return BBScaffold(
        title: 'Wallet Recover',
        child: WalletRecoverView(
          asyncValidateSeedPhrase: _asyncValidateSeedPhrase,
          onSubmit: _handleSubmit,
        ));
  }
}

class WalletRecoverView extends StatelessWidget {
  const WalletRecoverView(
      {super.key, this.onSubmit, this.asyncValidateSeedPhrase});

  final Function({
    required BuildContext context,
    required String seedPhrase,
    required String passphrase,
    required String walletName,
    required WalletType assetName,
  })? onSubmit;

  final Future<String?> Function(BuildContext, String)? asyncValidateSeedPhrase;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletRecoverForm(
              asyncValidateSeedPhrase: (value) =>
                  asyncValidateSeedPhrase!(context, value),
              onSubmit: (
                  {required String seedPhrase,
                  required String passphrase,
                  required String walletName,
                  required WalletType assetName}) {
                onSubmit!(
                    context: context,
                    seedPhrase: seedPhrase,
                    passphrase: passphrase,
                    walletName: walletName,
                    assetName: assetName);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('Import predefined wallets'),
              ),
            ),
            const PikachuWallet(),
            const NarutoWallet(),
            const VegetaWallet(),
            const First24Wallet(),
            const VegetaLiquidWallet(),
          ],
        ),
      ),
    );
  }
}
