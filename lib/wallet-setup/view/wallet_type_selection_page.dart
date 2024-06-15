import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet-setup/view/wallet_type_selection_view.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletTypeSelectionPage extends StatelessWidget {
  const WalletTypeSelectionPage(
      {super.key,
      required this.mnemonic,
      required this.passphrase,
      required this.walletName,
      required this.walletType});

  static String route = '/wallet/0/setup/type-select';
  static String routeQParamMnemonic = 'mnemonic';
  static String routeQParamPassphrase = 'passphrase';
  static String routeQParamWalletName = 'walletName';
  static String routeQParamWalletType = 'walletType';
  final String mnemonic;
  final String passphrase;
  final String walletName;
  final String walletType;

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);
    final seedRepository = RepositoryProvider.of<SeedRepository>(context);

    Seed seed = Seed(
      mnemonic: mnemonic,
      passphrase: passphrase,
      fingerprint: '',
    );

    // TODO: How to handle errors here
    // return FutureBuilder<(String?, dynamic)>(
    //     future: seed.getBdkFingerprint(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData && snapshot.data?.$2 == null) {
    //         seed = seed.copyWith(fingerprint: snapshot.data?.$1 ?? '');
    //         return MultiBlocProvider(
    //           providers: [
    //             BlocProvider(
    //                 create: (_) =>
    //                     WalletSensitiveBloc(walletRepository: walletRepository, seedRepository: seedRepository)
    //                       ..add(DeriveWalletFromStoredSeed(seed: seed, walletName: walletName))),
    //           ],
    //           child: WalletTypeSelectionScaffold(
    //             seed: seed,
    //             walletName: walletName,
    //           ),
    //         );
    //       } else {
    //         return const Center(child: CircularProgressIndicator());
    //       }
    //     });
    return WalletTypeSelectionScaffold(
      seed: seed,
      walletName: walletName,
      walletType: WalletTypeExtension.fromString(walletType),
    );
  }
}
