import 'package:bb_arch/address/view/addr_list_page.dart';
import 'package:bb_arch/address/view/addr_page.dart';
import 'package:bb_arch/home/home.dart';
import 'package:bb_arch/receive/view/receive_page.dart';
import 'package:bb_arch/send/view/send_page.dart';
import 'package:bb_arch/settings/_sub/logs/log_view.dart';
import 'package:bb_arch/settings/view/settings_page.dart';
import 'package:bb_arch/tx/view/tx_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_create_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_import_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_recover_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_type_selection_page.dart';
import 'package:bb_arch/wallet/view/wallet_page.dart';
import 'package:bb_arch/wallet-setup/view/wallet_setup_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
          path: '/wallet/:walletId',
          builder: (context, state) {
            return WalletPage(id: state.pathParameters['walletId'] ?? '');
          },
          routes: <RouteBase>[
            GoRoute(
                path: 'tx/:txId',
                builder: (context, state) {
                  return TxPage(
                      walletId: state.pathParameters['walletId'] ?? '',
                      id: state.pathParameters['txId'] ?? '');
                }),
            GoRoute(
                path: 'address-list',
                builder: (context, state) {
                  return AddressListPage(
                      walletId: state.pathParameters['walletId'] ?? '');
                }),
            GoRoute(
                path: 'address/:addressId',
                builder: (context, state) {
                  return AddressPage(
                      walletId: state.pathParameters['walletId'] ?? '',
                      id: state.pathParameters['addressId'] ?? '');
                  //return const AddressPage();
                }),
            GoRoute(
              path: WalletSetupPage.route.split('/').last,
              builder: (context, state) {
                return const WalletSetupPage();
              },
              routes: <RouteBase>[
                GoRoute(
                    path: WalletCreatePage.route.split('/').last,
                    builder: (context, state) {
                      return const WalletCreatePage();
                    }),
                GoRoute(
                    path: WalletImportPage.route.split('/').last,
                    builder: (context, state) {
                      return const WalletImportPage();
                    }),
                GoRoute(
                    path: WalletRecoverPage.route.split('/').last,
                    builder: (context, state) {
                      return const WalletRecoverPage();
                    }),
                GoRoute(
                    path: WalletTypeSelectionPage.route.split('/').last,
                    builder: (context, state) {
                      final q = state.uri.queryParameters;
                      return WalletTypeSelectionPage(
                        mnemonic:
                            q[WalletTypeSelectionPage.routeQParamMnemonic] ??
                                '',
                        passphrase:
                            q[WalletTypeSelectionPage.routeQParamPassphrase] ??
                                '',
                        walletName:
                            q[WalletTypeSelectionPage.routeQParamWalletName] ??
                                '',
                        walletType:
                            q[WalletTypeSelectionPage.routeQParamWalletType] ??
                                '',
                      );
                    }),
              ],
            ),
          ]),
      GoRoute(
        path: SettingsPage.route,
        builder: (context, state) {
          return const SettingsPage();
        },
        routes: <RouteBase>[
          GoRoute(
              path: 'logs',
              builder: (context, state) {
                return LogListScreen();
              }),
        ],
      ),
      GoRoute(
        path: ReceivePage.route,
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return ReceivePage(walletId: q['walletId'] ?? '');
        },
      ),
      GoRoute(
        path: SendPage.route,
        builder: (context, state) {
          final q = state.uri.queryParameters;
          return SendPage(walletId: q['walletId'] ?? '');
        },
      ),
    ]);
