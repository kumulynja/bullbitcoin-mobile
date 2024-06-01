import 'package:bb_mobile/_model/address.dart';
import 'package:bb_mobile/_model/wallet.dart';
import 'package:bb_mobile/_pkg/clipboard.dart';
import 'package:bb_mobile/_pkg/launcher.dart';
import 'package:bb_mobile/_pkg/storage/hive.dart';
import 'package:bb_mobile/_pkg/wallet/address.dart';
import 'package:bb_mobile/_pkg/wallet/repository.dart';
import 'package:bb_mobile/_pkg/wallet/sync.dart';
import 'package:bb_mobile/_ui/bottom_sheet.dart';
import 'package:bb_mobile/_ui/components/button.dart';
import 'package:bb_mobile/_ui/components/text.dart';
import 'package:bb_mobile/_ui/headers.dart';
import 'package:bb_mobile/_ui/inline_label.dart';
import 'package:bb_mobile/_ui/label_field.dart';
import 'package:bb_mobile/address/bloc/address_cubit.dart';
import 'package:bb_mobile/address/bloc/address_state.dart';
import 'package:bb_mobile/currency/bloc/currency_cubit.dart';
import 'package:bb_mobile/locator.dart';
import 'package:bb_mobile/network/bloc/network_cubit.dart';
import 'package:bb_mobile/settings/bloc/settings_cubit.dart';
import 'package:bb_mobile/styles.dart';
import 'package:bb_mobile/wallet/bloc/wallet_bloc.dart';
import 'package:bb_mobile/wallet_settings/bloc/wallet_settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddressPopUp extends StatelessWidget {
  const AddressPopUp({super.key});

  static Future openPopup(
    BuildContext context,
    Address address,
  ) async {
    final settings = context.read<SettingsCubit>();
    final wallet = context.read<WalletBloc>();
    final walletSettings = context.read<WalletSettingsCubit>();
    final addressCubit = AddressCubit(
      address: address,
      walletAddress: locator<WalletAddress>(),
      hiveStorage: locator<HiveStorage>(),
      walletRead: locator<WalletSync>(),
      walletSettingsCubit: walletSettings,
      walletBloc: wallet,
      walletRepository: locator<WalletRepository>(),
    );

    return showBBBottomSheet(
      context: context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: settings),
          BlocProvider.value(value: wallet),
          BlocProvider.value(value: walletSettings),
          BlocProvider.value(value: addressCubit),
        ],
        child: const AddressPopUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const _Screen();
  }
}

class _Screen extends StatelessWidget {
  const _Screen();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BBHeader.popUpCenteredText(
            text: 'Address',
          ),
          const Title(),
          const AddressQR(),
          const Gap(8),
          Divider(
            color: context.colour.onBackground.withOpacity(0.3),
          ),
          const Gap(8),
          const AddressDetails(),
          const Gap(4),
          Divider(
            color: context.colour.onBackground.withOpacity(0.3),
          ),
          const Gap(4),
          const AddressActions(),
          const Gap(40),
          const CopyButton(),
          const Gap(80),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.select((AddressCubit cubit) => cubit.state.address!);
    final labels =
        context.select((AddressCubit cubit) => cubit.state.address!.labels?.join(', ') ?? '');
    final address = context.select((AddressCubit cubit) => cubit.state.address!.miniString());

    final walletName = context.select((WalletBloc cubit) => cubit.state.wallet!.name ?? '');
    final walletFingerprint = context.select(
      (WalletBloc cubit) => cubit.state.wallet!.sourceFingerprint,
    );
    final title = walletName.isEmpty ? walletFingerprint : walletName;

    return Center(
      child: Column(
        children: [
          BBText.body(
            labels.isEmpty ? address : labels,
          ),
          const Gap(8),
          BBText.title(
            'From wallet: ' + title,
          ),
        ],
      ),
    );
  }
}

class AddressQR extends StatelessWidget {
  const AddressQR({super.key});

  @override
  Widget build(BuildContext context) {
    final address = context.select((AddressCubit cubit) => cubit.state.address!);
    final url = context.select(
      (NetworkCubit _) => _.state.explorerAddressUrl(address.address),
    );

    return Column(
      children: [
        const Gap(8),
        ColoredBox(
          color: Colors.white,
          child: QrImageView(
            data: address.address,
            padding: EdgeInsets.zero,
          ),
        ),
        const Gap(8),
        InkWell(
          onTap: () {
            locator<Launcher>().launchApp(url);
          },
          child: BBText.body(
            address.address,
            isBlue: true,
          ),
        ),
      ],
    );
  }
}

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletBloc bloc) => bloc.state.wallet!);
    final address = context.select((AddressCubit cubit) => cubit.state.address!);
    final (labels, labelsInherited) = address.getLabels(wallet);
    final isReceive = address.kind == AddressKind.deposit;
    final balance = address.balance;
    final amt = context.select((CurrencyCubit cubit) => cubit.state.getAmountInUnits(balance));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        InlineLabel(
          title: 'Index',
          body: (address.index == null) ? 'N/A' : address.index.toString(),
        ),
        const Gap(8),
        InlineLabel(title: 'Balance', body: amt),
        if (labels.isNotEmpty) ...[
          const Gap(8),
          InlineLabel(
            title: 'Labels',
            body: (labelsInherited ? '[I]' : '') + (labels.isNotEmpty ? labels.join(', ') : ''),
          ),
        ],
        const Gap(8),
        InlineLabel(
          title: 'Type',
          body: (isReceive ? 'Receive' : 'Change'),
        ),
        const Gap(8),
      ],
    );
  }
}

class AddressActions extends StatelessWidget {
  const AddressActions({super.key});

  @override
  Widget build(BuildContext context) {
    final bool frozen = context.select(
      (AddressCubit cubit) => cubit.state.address!.spendable == false,
    );
    final freezing = context.select((AddressCubit cubit) => cubit.state.freezingAddress);
    final hasUtxos =
        context.select((AddressCubit cubit) => cubit.state.address?.state == AddressStatus.active);
    //TODO: UTXO context.select((AddressCubit cubit) => cubit.state.address!.utxos?.isNotEmpty ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(8),
        InkWell(
          onTap: () {
            AddressLabelFieldPopUp.openPopup(
              context,
              context.read<AddressCubit>().state.address!,
            );
          },
          child: const BBText.body(
            'Edit Label',
            isBlue: true,
          ),
        ),
        if (hasUtxos) ...[
          const Gap(8),
          InkWell(
            onTap: () {
              if (freezing) return;
              if (frozen)
                context.read<AddressCubit>().unfreezeAddress();
              else
                context.read<AddressCubit>().freezeAddress();
            },
            child: BBText.body(
              frozen ? 'Unfreeze address' : 'Freeze address',
              isBlue: true,
            ),
          ),
        ],
      ],
    );
  }
}

class CopyButton extends StatefulWidget {
  const CopyButton({super.key});

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final address = context.select((AddressCubit cubit) => cubit.state.address!);

    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: _copied
            ? const Center(child: BBText.body('Address copied'))
            : SizedBox(
                width: 250,
                child: BBButton.bigRed(
                  onPressed: () {
                    setState(() {
                      _copied = true;
                    });
                    if (locator.isRegistered<Clippboard>())
                      locator<Clippboard>().copy(address.address);

                    Future.delayed(const Duration(seconds: 2), () {
                      setState(() {
                        _copied = false;
                      });
                    });
                  },
                  label: 'Copy Address',
                ),
              ),
      ),
    );
  }
}

class AddressLabelFieldPopUp extends StatelessWidget {
  const AddressLabelFieldPopUp({super.key, required this.address, required this.wallet});

  final Address address;
  final Wallet wallet;

  static Future openPopup(
    BuildContext context,
    Address address,
  ) {
    final settings = context.read<SettingsCubit>();
    final wallet = context.read<WalletBloc>();
    final walletSettings = context.read<WalletSettingsCubit>();
    final addressCubit = context.read<AddressCubit>();

    return showBBBottomSheet(
      context: context,
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: settings),
          BlocProvider.value(value: wallet),
          BlocProvider.value(value: walletSettings),
          BlocProvider.value(value: addressCubit),
        ],
        child: BlocListener<AddressCubit, AddressState>(
          listenWhen: (previous, current) => previous.savedAddressName != current.savedAddressName,
          listener: (context, state) async {
            if (!state.savedAddressName) return;

            context.pop();
          },
          child: AddressLabelFieldPopUp(address: address, wallet: wallet.state.wallet!),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(24),
          Row(
            children: [
              const Gap(8),
              const BBText.body(
                'Change address label',
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(FontAwesomeIcons.xmark),
                onPressed: () => context.pop(),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 8,
            ),
            child: BBText.body(
              'Address: ' + address.address,
            ),
          ),
          const Gap(24),
          AddressLabelTextField(
            address: address,
            wallet: wallet,
          ),
          const Gap(80),
        ],
      ),
    );
  }
}

class AddressLabelTextField extends StatefulWidget {
  const AddressLabelTextField({super.key, required this.address, required this.wallet});

  final Address address;
  final Wallet wallet;

  @override
  State<AddressLabelTextField> createState() => _AddressLabelTextFieldState();
}

class _AddressLabelTextFieldState extends State<AddressLabelTextField> {
  late List<String> labels;

  @override
  void initState() {
    final (lbls, labelsInherited) = widget.address.getLabels(widget.wallet);
    labels = lbls;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final saving = context.select((AddressCubit cubit) => cubit.state.savingAddressName);
    final err = context.select((AddressCubit cubit) => cubit.state.errSavingAddressName);
    final saved = context.select((AddressCubit cubit) => cubit.state.savedAddressName);
    // final _ = widget.address.label ?? 'Enter Label';

    final suggestions =
        context.select((AddressCubit _) => _.walletBloc.state.wallet?.globalLabels ?? []);

    if (saved) const Center(child: BBText.body('Saved!')).animate(delay: 300.ms).fadeIn();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: LabelField(
            suggestions: suggestions,
            labels: labels,
            onChanged: (List<String> lbls) {
              setState(() {
                labels = lbls;
              });
            },
          ),
        ),
        const Gap(10),
        if (err.isNotEmpty) ...[
          BBText.body(
            err,
          ),
          const Gap(16),
        ],
        Center(
          child: SizedBox(
            width: 250,
            child: BBButton.bigRed(
              loading: saving,
              onPressed: () async {
                // TODO: [Bad practice] wait for LabelField.inputfield's focus lost event to propagate to onChanged
                FocusScope.of(context).requestFocus(FocusNode());
                await Future.delayed(const Duration(seconds: 1));
                context.read<AddressCubit>().saveAddressName(widget.address, labels);
              },
              label: 'Save',
            ),
          ),
        ),
      ],
    );
  }
}
