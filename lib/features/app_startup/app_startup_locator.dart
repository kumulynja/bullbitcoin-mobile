import 'package:bb_mobile/app_locator.dart';
import 'package:bb_mobile/core/domain/repositories/seed_repository.dart';
import 'package:bb_mobile/core/domain/repositories/wallet_metadata_repository.dart';
import 'package:bb_mobile/core/domain/services/wallet_repository_manager.dart';
import 'package:bb_mobile/features/app_startup/domain/usecases/get_wallets_metadata_usecase.dart';
import 'package:bb_mobile/features/app_startup/domain/usecases/init_wallets_usecase.dart';
import 'package:bb_mobile/features/app_startup/presentation/bloc/app_startup_bloc.dart';

class AppStartupLocator {
  static void setup() {
    // Use cases
    locator.registerFactory<GetWalletsMetadataUseCase>(
      () => GetWalletsMetadataUseCase(
        seedRepository: locator<SeedRepository>(),
        walletMetadataRepository: locator<WalletMetadataRepository>(),
      ),
    );
    locator.registerFactory<InitWalletsUseCase>(
      () => InitWalletsUseCase(
        walletManager: locator<WalletRepositoryManager>(),
      ),
    );
    // Bloc
    locator.registerFactory<AppStartupBloc>(
      () => AppStartupBloc(
        getWalletsMetadataUseCase: locator<GetWalletsMetadataUseCase>(),
        initWalletsUseCase: locator<InitWalletsUseCase>(),
      ),
    );
  }
}
