import 'package:bb_mobile/_pkg/barcode.dart';
import 'package:bb_mobile/_pkg/boltz/swap.dart';
import 'package:bb_mobile/_pkg/bull_bitcoin_api.dart';
import 'package:bb_mobile/_pkg/file_storage.dart';
import 'package:bb_mobile/_pkg/mempool_api.dart';
import 'package:bb_mobile/_pkg/payjoin/manager.dart';
import 'package:bb_mobile/_pkg/storage/hive.dart';
import 'package:bb_mobile/_pkg/wallet/repository/sensitive_storage.dart';
import 'package:bb_mobile/_pkg/wallet/transaction.dart';
import 'package:bb_mobile/_ui/page_view/page_view_with_bloc.dart';
import 'package:bb_mobile/currency/bloc/currency_cubit.dart';
import 'package:bb_mobile/home/bloc/home_cubit.dart';
import 'package:bb_mobile/locator.dart';
import 'package:bb_mobile/network/bloc/network_cubit.dart';
import 'package:bb_mobile/network_fees/bloc/networkfees_cubit.dart';
import 'package:bb_mobile/send/bloc/send_cubit.dart';
import 'package:bb_mobile/send/bloc/send_state.dart';
import 'package:bb_mobile/send/screens/send_bitcoin_confirmation_screen.dart';
import 'package:bb_mobile/send/screens/send_input_screen.dart';
import 'package:bb_mobile/send/screens/send_liquid_confirmation_screen.dart';
import 'package:bb_mobile/settings/bloc/settings_cubit.dart';
import 'package:bb_mobile/swap/create_swap_bloc/swap_cubit.dart';
import 'package:bb_mobile/swap/watcher_bloc/watchtxs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendFlow extends StatelessWidget {
  const SendFlow({
    this.walletId,
    this.scannedPaymentRequest,
    this.openScanner = false,
  });

  // TODO: scanner should be another "feature" and screen with its own route and bloc and should navigate to send flow with the scanned data
  final bool openScanner;
  final String? walletId;
  final String? scannedPaymentRequest;

  @override
  Widget build(BuildContext context) {
    final isTestnet = context.read<NetworkCubit>().state.testnet;

    // TODO: Do not inject cubits or blocs into the SendCubit, only the repositories or services they depend on
    return BlocProvider(
      create: (context) => SendCubit(
        walletTx: locator<WalletTx>(),
        barcode: locator<Barcode>(),
        defaultRBF: locator<SettingsCubit>().state.defaultRBF,
        fileStorage: locator<FileStorage>(),
        networkCubit: locator<NetworkCubit>(),
        networkFeesCubit: NetworkFeesCubit(
          networkCubit: locator<NetworkCubit>(),
          hiveStorage: locator<HiveStorage>(),
          mempoolAPI: locator<MempoolAPI>(),
          defaultNetworkFeesCubit: context.read<NetworkFeesCubit>(),
        ),
        homeCubit: locator<HomeCubit>(),
        payjoinManager: locator<PayjoinManager>(),
        swapBoltz: locator<SwapBoltz>(),
        currencyCubit: CurrencyCubit(
          hiveStorage: locator<HiveStorage>(),
          bbAPI: locator<BullBitcoinAPI>(),
          defaultCurrencyCubit: context.read<CurrencyCubit>(),
        ),
        openScanner: openScanner,
        walletBlocs: context.read<HomeCubit>().state.getMainWallets(
              isTestnet,
            ), // TODO: This should be replaced by all WalletService providers
        swapCubit: CreateSwapCubit(
          walletSensitiveRepository:
              locator<WalletSensitiveStorageRepository>(),
          swapBoltz: locator<SwapBoltz>(),
          walletTx: locator<WalletTx>(),
          homeCubit: context.read<HomeCubit>(),
          watchTxsBloc: context.read<WatchTxsBloc>(),
          networkCubit: context.read<NetworkCubit>(),
        )..fetchFees(context.read<NetworkCubit>().state.testnet),
        oneWallet: false,
      )..start(
          walletId: walletId,
          scannedPaymentRequest: scannedPaymentRequest,
        ),
      child: BlocListener<SendCubit, SendState>(
        listener: (context, state) => {
          // TODO: Listen for a success state and navigate to the success screen
          //  or check for other states too and show a snackbar or dialog
        },
        child: BlocBuilder<SendCubit, SendState>(
          builder: (context, state) {
            switch (state) {
              case SendInitialState():
                // TODO: Show a loading screen
                throw UnimplementedError();
              case SendNoWalletState():
                // TODO: Show an error screen
                throw UnimplementedError();
              case SendUnknownWalletIdState():
                // TODO: Show a screen with an error message
                throw UnimplementedError();
              case SendBitcoinState():
                return const PageViewWithBloc(
                  pages: [
                    SendInputScreen(), // TODO: pass the wallet type/payment method to the SendInputScreen
                    SendBitcoinConfirmationScreen(),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                );
              case SendLiquidState():
                return const PageViewWithBloc(
                  pages: [
                    SendInputScreen(), // TODO: pass the wallet type/payment method to the SendInputScreen
                    SendLiquidConfirmationScreen(),
                  ],
                  physics: NeverScrollableScrollPhysics(),
                );
              case SendLightningState():
                // TODO: Handle this case.
                throw UnimplementedError();
            }
          },
        ),
      ),
    );
  }
}
