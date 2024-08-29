// Change 1: move ln swap fields from SwapTx to SwapTx.lnSwapDetails
import 'package:bb_mobile/_pkg/storage/hive.dart';
import 'package:bb_mobile/_pkg/storage/secure_storage.dart';

Future<void> doMigration0_2to0_3(
  SecureStorage secureStorage,
  HiveStorage hiveStorage,
) async {
  print('Migration: 0.2 to 0.3');
}
