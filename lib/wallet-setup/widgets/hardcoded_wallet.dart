import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/wallet-setup/cubit/wallet_recover_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HardcodedWallet extends StatelessWidget {
  const HardcodedWallet({
    super.key,
    required this.mnemonic,
    required this.passphrase,
    required this.walletName,
    required this.walletType,
    required this.walletDisplayName,
  });

  final String mnemonic;
  final String passphrase;
  final String walletName;
  final WalletType walletType;
  final String walletDisplayName;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          // WARNING: Having bloc/cubit access inside Widgets is strictly not allowed.
          // This is done here, as this is dev only widget.
          context.read<WalletRecoverPageCubit>().navigateToWalletTypePage(
              context, mnemonic, passphrase, walletName, walletType.name);
          BBLogger().log(walletDisplayName);
        },
        child: Text(walletDisplayName));
  }
}
