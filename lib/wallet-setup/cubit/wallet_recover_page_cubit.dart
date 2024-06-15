import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/wallet-setup/cubit/wallet_recover_page_state.dart';
import 'package:bb_arch/wallet-setup/view/wallet_type_selection_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WalletRecoverPageCubit extends Cubit<WalletRecoverPageState> {
  final SeedRepository seedRepository;

  WalletRecoverPageCubit({required this.seedRepository})
      : super(const WalletRecoverPageState());

  // TODO: BdkException handling should happen here?
  Future<String?> validateSeedPhrase(String seedphrase) {
    return seedRepository.validateSeedPhrase(seedphrase);
  }
}
