import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/wallet-setup/view/wallet_create_view.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCreatePage extends StatelessWidget {
  const WalletCreatePage({super.key});

  static String route = '/wallet/0/setup/create';

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);
    final seedRepository = RepositoryProvider.of<SeedRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => WalletSensitiveBloc(
                walletRepository: walletRepository,
                seedRepository: seedRepository)
              ..add(CreateNewSeed())),
      ],
      child: const WalletCreateScaffold(),
    );
  }
}
