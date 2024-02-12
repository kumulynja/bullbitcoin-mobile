import 'package:bb_mobile/_pkg/boltz/swap.dart';
import 'package:bb_mobile/_pkg/bull_bitcoin_api.dart';
import 'package:bb_mobile/_pkg/consts/keys.dart';
import 'package:bb_mobile/_pkg/storage/hive.dart';
import 'package:bb_mobile/_pkg/storage/secure_storage.dart';
import 'package:bb_mobile/_pkg/wallet/address.dart';
import 'package:bb_mobile/_pkg/wallet/repository.dart';
import 'package:bb_mobile/_pkg/wallet/sensitive/repository.dart';
import 'package:bb_mobile/_pkg/wallet/transaction.dart';
import 'package:bb_mobile/_ui/app_bar.dart';
import 'package:bb_mobile/_ui/components/button.dart';
import 'package:bb_mobile/_ui/components/text.dart';
import 'package:bb_mobile/_ui/components/text_input.dart';
import 'package:bb_mobile/currency/amount_input.dart';
import 'package:bb_mobile/currency/bloc/currency_cubit.dart';
import 'package:bb_mobile/home/bloc/home_cubit.dart';
import 'package:bb_mobile/locator.dart';
import 'package:bb_mobile/network/bloc/network_cubit.dart';
import 'package:bb_mobile/receive/bloc/receive_cubit.dart';
import 'package:bb_mobile/receive/bloc/state.dart';
import 'package:bb_mobile/receive/receive_page.dart';
import 'package:bb_mobile/settings/bloc/settings_cubit.dart';
import 'package:bb_mobile/styles.dart';
import 'package:bb_mobile/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ReceivePage2 extends StatefulWidget {
  const ReceivePage2({super.key});

  @override
  State<ReceivePage2> createState() => _ReceivePage2State();
}

class _ReceivePage2State extends State<ReceivePage2> {
  late ReceiveCubit _cubit;
  late HomeCubit home;

  @override
  void initState() {
    _cubit = ReceiveCubit(
      walletAddress: locator<WalletAddress>(),
      hiveStorage: locator<HiveStorage>(),
      walletRepository: locator<WalletRepository>(),
      settingsCubit: locator<SettingsCubit>(),
      networkCubit: locator<NetworkCubit>(),
      swapBoltz: locator<SwapBoltz>(),
      secureStorage: locator<SecureStorage>(),
      walletSensitiveRepository: locator<WalletSensitiveRepository>(),
      walletTx: locator<WalletTx>(),
      currencyCubit: CurrencyCubit(
        hiveStorage: locator<HiveStorage>(),
        bbAPI: locator<BullBitcoinAPI>(),
        defaultCurrencyCubit: context.read<CurrencyCubit>(),
      ),
    );

    home = locator<HomeCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final network = context.select((NetworkCubit _) => _.state.getBBNetwork());
    final walletBlocs = home.state.walletBlocsFromNetwork(network);

    WalletBloc? walletBloc;
    if (walletBlocs.isNotEmpty) {
      walletBloc = walletBlocs.first;
      _cubit.updateWalletBloc(walletBloc);
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider.value(value: _cubit.networkCubit),
        BlocProvider.value(value: _cubit.currencyCubit),
        BlocProvider.value(value: home),
        if (walletBloc != null) BlocProvider.value(value: walletBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const _ReceiveAppBar(),
          automaticallyImplyLeading: false,
        ),
        body: const _WalletProvider(child: _Screen()),
      ),
    );
  }
}

class _ReceiveAppBar extends StatelessWidget {
  const _ReceiveAppBar();

  @override
  Widget build(BuildContext context) {
    return BBAppBar(
      text: 'Receive bitcoin',
      onBack: () {
        context.pop();
      },
    );
  }
}

class _WalletProvider extends StatelessWidget {
  const _WalletProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((ReceiveCubit _) => _.state.walletBloc);

    if (wallet == null) return child;
    return BlocProvider.value(value: wallet, child: child);
  }
}

class _Screen extends StatelessWidget {
  const _Screen();

  @override
  Widget build(BuildContext context) {
    final showQR = context.select((ReceiveCubit x) => x.state.showQR());
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(32),
            const ReceiveWalletsDropDown(),
            const Gap(24),
            const SelectWalletType(),
            const Gap(48),
            if (showQR) ...[
              const ReceiveQRImage(),
              const ReceiveAddressText(),
            ] else ...[
              const BBText.body('Lightning invoice'),
              const CreateLightningInvoice(),
            ],
            const Gap(48),
            const WalletActions(),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}

class ReceiveWalletsDropDown extends StatelessWidget {
  const ReceiveWalletsDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final network = context.select((NetworkCubit _) => _.state.getBBNetwork());
    final walletBlocs = context.select((HomeCubit _) => _.state.walletBlocsFromNetwork(network));
    final selectedWalletBloc = context.select((ReceiveCubit _) => _.state.walletBloc);

    final walletBloc = selectedWalletBloc ?? walletBlocs.first;

    return Center(
      child: SizedBox(
        width: 250,
        height: 45,
        child: Material(
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: DropdownButtonFormField<WalletBloc>(
            padding: EdgeInsets.zero,
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            isExpanded: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: NewColours.lightGray,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: NewColours.lightGray,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: NewColours.offWhite,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: NewColours.lightGray,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
            value: walletBloc,
            onChanged: (value) {
              if (value == null) return;
              context.read<ReceiveCubit>().updateWalletBloc(value);
            },
            items: walletBlocs.map((wallet) {
              final name = wallet.state.wallet!.name ?? wallet.state.wallet!.sourceFingerprint;
              return DropdownMenuItem<WalletBloc>(
                value: wallet,
                child: Center(
                  child: BBText.body(name),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ReceiveQRImage extends StatelessWidget {
  const ReceiveQRImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReceiveQRDisplay();
  }
}

class ReceiveAddressText extends StatelessWidget {
  const ReceiveAddressText({super.key});

  @override
  Widget build(BuildContext context) {
    return const ReceiveDisplayAddress();
  }
}

class WalletActions extends StatelessWidget {
  const WalletActions({super.key});

  @override
  Widget build(BuildContext context) {
    final showRequestButton = context.select((ReceiveCubit x) => x.state.showNewRequestButton());
    final errLoadingAddress = context.select((ReceiveCubit x) => x.state.errLoadingAddress);

    return Column(
      children: [
        if (showRequestButton)
          SizedBox(
            width: 300,
            height: 44,
            child: BBButton.big2(
              buttonKey: UIKeys.receiveRequestPaymentButton,
              label: 'Request payment',
              onPressed: () {
                CreateInvoice.openPopUp(context);
              },
            ),
          ),
        const Gap(8),
        SizedBox(
          width: 300,
          height: 44,
          child: BBButton.big2(
            buttonKey: UIKeys.receiveGenerateAddressButton,
            label: 'Get new address',
            onPressed: () {
              context.read<ReceiveCubit>().generateNewAddress();
            },
          ),
        ),
        BBText.errorSmall(errLoadingAddress),
      ],
    );
  }
}

class SelectWalletType extends StatelessWidget {
  const SelectWalletType({super.key});

  @override
  Widget build(BuildContext context) {
    final isTestnet = context.select((NetworkCubit _) => _.state.testnet);
    final walletType = context.select((ReceiveCubit x) => x.state.walletType);

    if (!isTestnet) return const SizedBox.shrink();

    return CupertinoSlidingSegmentedControl(
      groupValue: walletType,
      children: const {
        ReceiveWalletType.secure: Text('Secure'),
        ReceiveWalletType.lightning: Text('Lightning'),
      },
      onValueChanged: (value) {
        if (value == null) return;
        context.read<ReceiveCubit>().updateWalletType(value);
      },
    );
  }
}

class CreateLightningInvoice extends StatelessWidget {
  const CreateLightningInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    final description = context.select((ReceiveCubit _) => _.state.description);
    final err = context.select((ReceiveCubit _) => _.state.errGeneratingInvoice);

    return Column(
      children: [
        const EnterAmount2(),
        BBTextInput.big(
          uiKey: UIKeys.receiveDescriptionField,
          value: description,
          hint: 'Enter description',
          onChanged: (txt) {
            context.read<ReceiveCubit>().descriptionChanged(txt);
          },
        ),
        BBButton.bigRed(
          buttonKey: UIKeys.receiveSavePaymentButton,
          label: 'Save',
          onPressed: () {
            context.read<ReceiveCubit>().createBtcLightningInvoice();
          },
        ),
        BBText.errorSmall(err),
        const Gap(40),
      ],
    );
  }
}