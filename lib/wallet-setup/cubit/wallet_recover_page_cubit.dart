import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/wallet-setup/cubit/wallet_recover_page_state.dart';
import 'package:bb_arch/wallet-setup/view/wallet_type_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletRecoverPageCubit extends Cubit<WalletRecoverPageState> {
  final SeedRepository seedRepository;

  WalletRecoverPageCubit({required this.seedRepository})
      : super(const WalletRecoverPageState());

  void navigateToWalletTypePage(BuildContext context, String mnemonic,
      String passphrase, String walletName, String walletType) {
    final baseRoute = WalletTypeSelectionPage.route;
    final mnemonicParam =
        '${WalletTypeSelectionPage.routeQParamMnemonic}=$mnemonic';
    final passphraseParam =
        '${WalletTypeSelectionPage.routeQParamPassphrase}=$passphrase';
    final walletNameParam =
        '${WalletTypeSelectionPage.routeQParamWalletName}=$walletName';
    final walletTypeParam =
        '${WalletTypeSelectionPage.routeQParamWalletType}=$walletType';

    final finalRoute =
        '$baseRoute?$mnemonicParam&$passphraseParam&$walletNameParam&$walletTypeParam';
    GoRouter.of(context).push(finalRoute);
  }

  // TODO: BdkException handling should happen here?
  Future<String?> validateSeedPhrase(String seedphrase) {
    return seedRepository.validateSeedPhrase(seedphrase);
  }
}
