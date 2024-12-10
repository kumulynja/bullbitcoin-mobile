import 'package:bb_mobile/_pkg/wallet/bdk/sensitive_create.dart';
import 'package:bb_mobile/_pkg/wallet/repository/network.dart';
import 'package:bb_mobile/_pkg/wallet/repository/sensitive_storage.dart';
import 'package:bb_mobile/_pkg/wallet/repository/wallets.dart';
import 'package:bb_mobile/_ui/app_bar.dart';
import 'package:bb_mobile/_ui/components/button.dart';
import 'package:bb_mobile/locator.dart';
import 'package:bb_mobile/payjoin/cubit.dart';
import 'package:bb_mobile/payjoin/state.dart';
import 'package:bb_mobile/wallet/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PayjoinPage extends StatelessWidget {
  const PayjoinPage({super.key, required this.walletBloc});

  final WalletBloc walletBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PayjoinCubit>(
      create: (_) => PayjoinCubit(
        walletBloc: walletBloc,
        walletsRepository: locator<WalletsRepository>(),
        networkRepository: locator<NetworkRepository>(),
        bdkSensitiveCreate: locator<BDKSensitiveCreate>(),
        walletSensitiveStorageRepository:
            locator<WalletSensitiveStorageRepository>(),
      )..init(),
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: BBAppBar(text: 'Payjoin', onBack: () => context.pop()),
        ),
        body: BlocListener<PayjoinCubit, PayjoinState>(
          listener: (context, state) {
            if (state.toast.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.toast),
                  backgroundColor: Colors.orange,
                ),
              );
              context.read<PayjoinCubit>().clearToast();
            }
          },
          child: BlocBuilder<PayjoinCubit, PayjoinState>(
            builder: (context, state) {
              final cubit = context.read<PayjoinCubit>();

              return Column(
                children: [
                  SwitchListTile(
                    title: Text(state.isReceiver ? 'Receiver' : 'Sender'),
                    value: state.isReceiver,
                    onChanged: cubit.toggleReceiver,
                  ),
                  Expanded(
                    child: state.isReceiver
                        ? _buildReceiver(context, cubit, state)
                        : _buildSender(context, cubit, state),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildReceiver(
    BuildContext context,
    PayjoinCubit cubit,
    PayjoinState state,
  ) {
    return Form(
      key: cubit.form,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: cubit.address,
                  decoration: const InputDecoration(
                    labelText: 'address',
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextFormField(
                  controller: cubit.satoshis,
                  decoration: const InputDecoration(
                    labelText: 'satoshis',
                  ),
                  validator: cubit.validateSatoshis,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          BBButton.big(
            loading: state.isAwaiting,
            onPressed: cubit.clickCreateInvoice,
            label: 'invoice',
          ),
          if (state.payjoinUri.isNotEmpty) SelectableText(state.payjoinUri),
        ],
      ),
    );
  }

  Widget _buildSender(
    BuildContext context,
    PayjoinCubit cubit,
    PayjoinState state,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 200,
          child: TextFormField(
            controller: cubit.uri,
            decoration: const InputDecoration(labelText: 'payjoin link'),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            controller: cubit.fees,
            decoration: const InputDecoration(
              labelText: 'fees',
            ),
            validator: cubit.validateSatoshis,
            keyboardType: TextInputType.number,
          ),
        ),
        BBButton.big(
          loading: state.isAwaiting,
          onPressed: cubit.clickConfirmPayJoin,
          label: 'payjoin',
        ),
      ],
    );
  }
}
