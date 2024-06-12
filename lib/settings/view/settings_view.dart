// ignore_for_file: avoid_print

import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/receive/view/receive_page.dart';
import 'package:bb_arch/send/view/send_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return const BBScaffold(title: 'Settings', child: SettingsView());
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return ListTile(
                  title: const Text('Testnet mode'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Testnet');
                  },
                );
              case 1:
                return ListTile(
                  title: const Text('Default RBF'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Default RBF');
                  },
                );
              case 2:
                return ListTile(
                  title: const Text('Default fee rate'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Default fee rate');
                  },
                );
              case 3:
                return ListTile(
                  title: const Text('Create / Import wallet'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    GoRouter.of(context).push(WalletSetupPage.route);
                  },
                );
              case 4:
                return ListTile(
                  title: const Text('Broadcast'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Broadcast');
                  },
                );
              case 5:
                return ListTile(
                  title: const Text('Electrum Server'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Electrum Server');
                  },
                );
              case 6:
                return ListTile(
                  title: const Text('Change PIN'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    print('SettingsView: Change PIN');
                  },
                );
              case 7:
                return ListTile(
                  title: const Text('Send'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    GoRouter.of(context).push(SendPage.route);
                  },
                );
              case 8:
                return ListTile(
                  title: const Text('Receive'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    GoRouter.of(context).push(ReceivePage.route);
                  },
                );
              case 9:
                return ListTile(
                  title: const Text('Logs'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    GoRouter.of(context).push('/settings/logs');
                  },
                );
              default:
                return const ListTile(
                  title: Text('Hanled index'),
                );
            }
          },
          itemCount: 10),
    );
  }
}
