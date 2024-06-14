// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/bitcoin_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/liquid_wallet.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/wallet/bloc/wallet_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_bloc.dart';
import 'package:bb_arch/wallet/bloc/walletsensitive_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// TODO: This is messy. Cleanup
class WalletTypeSelectionScaffold extends StatelessWidget {
  const WalletTypeSelectionScaffold(
      {super.key, required this.seed, required this.walletName});

  final Seed seed;
  final String walletName;

  @override
  Widget build(BuildContext context) {
    final walletRepository = RepositoryProvider.of<WalletRepository>(context);
    final seedRepository = RepositoryProvider.of<SeedRepository>(context);

    return FutureBuilder<(String?, dynamic)>(
        future: seed.getBdkFingerprint(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data?.$2 == null) {
            final newSeed = seed.copyWith(fingerprint: snapshot.data?.$1 ?? '');
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (_) => WalletSensitiveBloc(
                        walletRepository: walletRepository,
                        seedRepository: seedRepository)
                      ..add(DeriveWalletFromStoredSeed(
                          seed: newSeed, walletName: walletName))),
              ],
              child: BlocBuilder<WalletSensitiveBloc, WalletSensitiveState>(
                  builder: (context, status) {
                final wallets = context.select(
                    (WalletSensitiveBloc cubit) => cubit.state.derivedWallets);
                final syncStatuses = context.select(
                    (WalletSensitiveBloc cubit) =>
                        cubit.state.syncDerivedWalletStatus);
                return BBScaffold(
                    title: 'Type selection',
                    child: WalletTypeSelectionView(
                      seed: newSeed,
                      wallets: wallets,
                      syncStatuses: syncStatuses,
                    ));
              }),
            );
          } else {
            return const BBScaffold(
              title: 'Type selection',
              loadStatus: LoadStatus.loading,
              child: null,
            );
          }
        });
  }
}

class WalletTypeSelectionView extends StatelessWidget {
  const WalletTypeSelectionView(
      {super.key,
      required this.seed,
      required this.wallets,
      required this.syncStatuses});

  final Seed seed;
  final List<Wallet> wallets;
  final List<LoadStatus> syncStatuses;

  @override
  Widget build(BuildContext context) {
    print('WalletTypeSelectionView');
    print(wallets.length);

    final walletListBloc = context.read<WalletListBloc>();

    return ListView.builder(
      itemBuilder: (context, index) {
        final w = wallets[index];
        final syncStatus = syncStatuses[index];
        return BlocProvider(
          create: (context) => WalletBloc(
            wallet: w,
            walletRepository: walletListBloc.walletRepository,
            txRepository: walletListBloc.txRepository,
            seedRepository: walletListBloc.seedRepository,
            addressRepository: walletListBloc.addressRepository,
          ),
          child: Builder(builder: (context) {
            return ListTile(
              title: Text(
                  '[${w.scriptType?.name}] ${w.name} (${w.seedFingerprint}: ${w.id})'),
              subtitle: Text('Tx count: ${w.txCount}, Balance: ${w.balance}'),
              leading: syncStatus.name == 'loading'
                  ? const CircularProgressIndicator()
                  : syncStatus.name == 'initial'
                      ? const Icon(Icons.hourglass_empty)
                      : const Icon(Icons.check),
              trailing: TextButton(
                child: const Text('Import'),
                onPressed: () async {
                  print('Import $index wallet type');
                  context
                      .read<WalletSensitiveBloc>()
                      .add(PersistSeed(seed: seed));
                  if (w is BitcoinWallet) {
                    BitcoinWallet w = wallets[index] as BitcoinWallet;
                    context.read<WalletBloc>().add(PersistWallet(
                        wallet: w.copyWith(
                            name: '${w.name}: ${w.scriptType.name}')));
                  } else if (w is LiquidWallet) {
                    LiquidWallet w = wallets[index] as LiquidWallet;
                    context.read<WalletBloc>().add(PersistWallet(
                        wallet: w.copyWith(
                            name: '${w.name}: ${w.scriptType.name}')));
                  }
                  // await Future.delayed(const Duration(milliseconds: 1000));
                  context.read<WalletListBloc>().add(LoadAllWallets());
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                },
              ),
              onTap: () {
                context
                    .read<WalletListBloc>()
                    .add(SelectWallet(wallet: wallets[index]));
              },
            );
          }),
        );
      },
      itemCount: wallets.length,
    );
  }
}
