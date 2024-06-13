import 'package:bb_arch/_pkg/address/address_repository.dart';
import 'package:bb_arch/_pkg/address/models/address.dart';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/seed/models/seed.dart';
import 'package:bb_arch/_pkg/seed/seed_repository.dart';
import 'package:bb_arch/_pkg/storage/hive.dart';
import 'package:bb_arch/_pkg/storage/secure_storage.dart';
import 'package:bb_arch/_pkg/tx/models/tx.dart';
import 'package:bb_arch/_pkg/tx/tx_repository.dart';
import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_pkg/wallet/wallet_repository.dart';
import 'package:bb_arch/app/app.dart';
import 'package:bb_arch/app/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Move this to a Splash loader

  final logger = BBLogger();
  await logger.init();

  Bloc.observer = SimpleBlocObserver(logger: logger);

  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [WalletSchema, TxSchema, AddressSchema, SeedSchema],
    directory: dir.path,
  );

  final HiveStorage storage = HiveStorage();
  await storage.init();

  final SecureStorage secureStorage = SecureStorage();

  final SeedRepository seedRepository =
      SeedRepository(storage: storage, isar: isar);
  final WalletRepository walletRepository =
      WalletRepository(storage: storage, isar: isar);
  final TxRepository txRepository = TxRepository(storage: storage, isar: isar);
  final AddressRepository addressRepository =
      AddressRepository(storage: storage, isar: isar);

  runApp(MyApp(
    isar: isar,
    storage: storage,
    secureStorage: secureStorage,
    seedRepository: seedRepository,
    walletRepository: walletRepository,
    txRepository: txRepository,
    addressRepository: addressRepository,
    logger: logger,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.isar,
      required this.storage,
      required this.secureStorage,
      required this.seedRepository,
      required this.walletRepository,
      required this.txRepository,
      required this.addressRepository,
      required this.logger});

  final Isar isar;
  final HiveStorage storage;
  final SecureStorage secureStorage;
  final SeedRepository seedRepository;
  final WalletRepository walletRepository;
  final TxRepository txRepository;
  final AddressRepository addressRepository;
  final BBLogger logger;

  @override
  Widget build(BuildContext context) {
    return App(
      storage: storage,
      secureStorage: secureStorage,
      seedRepository: seedRepository,
      walletRepository: walletRepository,
      txRepository: txRepository,
      addressRepository: addressRepository,
      logger: logger,
    );
  }
}
