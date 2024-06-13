// ignore_for_file: avoid_print

import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/address/models/bitcoin_address.dart';
import 'package:bb_arch/_pkg/address/models/liquid_address.dart';
import 'package:bb_arch/_pkg/misc.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/bb_page.dart';
import 'package:bb_arch/address/bloc/addr_bloc.dart';
import 'package:bb_arch/address/widgets/bitcoin_address_list.dart';
import 'package:bb_arch/address/widgets/liquid_address_list.dart';
import 'package:bb_arch/tx/bloc/tx_bloc.dart';
import 'package:bb_arch/tx/bloc/tx_state.dart';
import 'package:bb_arch/wallet/bloc/walletlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressListScaffold extends StatelessWidget {
  const AddressListScaffold({super.key, required this.walletId});

  final String walletId;

  @override
  Widget build(BuildContext context) {
    final addressLoadStatus =
        context.select((AddressBloc bloc) => bloc.state.status);
    final txLoadStatus = context.select((TxBloc bloc) => bloc.state.status);

    final wallet = context.select((WalletListBloc cubit) => cubit
        .state.walletBlocs
        .firstWhere((bloc) => bloc.state.wallet?.id == walletId)
        .state
        .wallet);
    final txs = context.select((TxBloc cubit) => cubit.state.txs);
    final depositAddresses =
        context.select((AddressBloc bloc) => bloc.state.depositAddresses);
    final changeAddresses =
        context.select((AddressBloc bloc) => bloc.state.changeAddresses);

    LoadStatus loadStatus;

    if (addressLoadStatus == LoadStatus.success &&
        txLoadStatus == LoadStatus.success) {
      loadStatus = LoadStatus.success;
    } else if (addressLoadStatus == LoadStatus.failure ||
        txLoadStatus == LoadStatus.failure) {
      loadStatus = LoadStatus.failure;
    } else {
      loadStatus = LoadStatus.loading;
    }

    print('AddressListScaffold: $loadStatus $addressLoadStatus $txLoadStatus');

    return BlocBuilder<TxBloc, TxState>(
      builder: (context, state) {
        print('AddressListScaffold: txCount: ${state.txs.length}');
        return BBScaffold(
            title: 'Address list',
            loadStatus: loadStatus,
            child: loadStatus == LoadStatus.success
                ? AddressListView(
                    wallet: wallet!,
                    depositAddresses: depositAddresses,
                    changeAddresses: changeAddresses,
                  )
                : null);
      },
    );
  }
}

class AddressListView extends StatefulWidget {
  const AddressListView(
      {super.key,
      required this.wallet,
      required this.depositAddresses,
      required this.changeAddresses});

  final Wallet wallet;
  final List<Address> depositAddresses;
  final List<Address> changeAddresses;

  @override
  State<AddressListView> createState() => _AddressListView();
}

class _AddressListView extends State<AddressListView> {
  AddressKind selectedKind = AddressKind.deposit;
  Widget? bitcoinDepositAddressListView;
  Widget? bitcoinChangeAddressListView;
  Widget? liquidAddressListView;

  @override
  Widget build(BuildContext context) {
    print('selectedKind: $selectedKind');

    // TODO: Optimize: This switch takes time for loading.
    Widget listView;
    if (widget.wallet.type == WalletType.Bitcoin) {
      if (selectedKind == AddressKind.deposit) {
        print('loading with deposit addr');
        bitcoinDepositAddressListView ??= BitcoinAddressList(
            walletId: widget.wallet.id,
            addresses: List<BitcoinAddress>.from(widget.depositAddresses));
        listView = bitcoinDepositAddressListView!;
      } else if (selectedKind == AddressKind.change) {
        print('loading with change addr');
        bitcoinChangeAddressListView ??= BitcoinAddressList(
            walletId: widget.wallet.id,
            addresses: List<BitcoinAddress>.from(widget.changeAddresses));
        listView = bitcoinChangeAddressListView!;
      } else {
        listView = const Text('Unsupported address kind');
      }
    } else if (widget.wallet.type == WalletType.Liquid) {
      liquidAddressListView ??= LiquidAddressList(
          walletId: widget.wallet.id,
          addresses: List<LiquidAddress>.from(widget.depositAddresses));
      listView = liquidAddressListView!;
    } else {
      listView = const Text('Unsupported wallet type');
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddressKindSegment(
              selectedKind: selectedKind,
              onChange: (Set<AddressKind> newValue) {
                setState(() {
                  print('Changing to ${newValue.first}');
                  selectedKind = newValue.first;
                });
              },
            ),
            listView,
          ],
        ),
      ),
    );
  }
}

class AddressKindSegment extends StatelessWidget {
  const AddressKindSegment({
    super.key,
    this.selectedKind,
    this.onChange,
  });

  final AddressKind? selectedKind;
  final void Function(Set<AddressKind>)? onChange;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<AddressKind>(
      multiSelectionEnabled: false,
      segments: const <ButtonSegment<AddressKind>>[
        ButtonSegment<AddressKind>(
          value: AddressKind.deposit,
          label: Text('Deposit'),
        ),
        ButtonSegment<AddressKind>(
          value: AddressKind.change,
          label: Text('Change'),
        ),
        // ButtonSegment<AddressKind>(
        //   value: AddressKind.confidential,
        //   label: Text('Confidential'),
        // ),
      ],
      selected: {selectedKind ?? AddressKind.deposit},
      onSelectionChanged: onChange ?? (_) {},
    );
  }
}
