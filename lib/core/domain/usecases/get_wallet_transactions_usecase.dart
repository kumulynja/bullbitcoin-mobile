import 'package:bb_mobile/core/domain/services/wallet_repository_manager.dart';

/*class GetWalletTransactionsUseCase {
  final WalletRepositoryManager _manager;

  GetWalletTransactionsUseCase(
      {required WalletRepositoryManager walletRepositoryManager})
      : _manager = walletRepositoryManager;

  Future<List<Transaction>> execute(
    String walletId, {
    int? offset,
    int? limit,
  }) async {
    final walletRepository = _manager.getRepository(walletId);

    if (walletRepository == null) {
      return [];
    }

    return await walletRepository.getTransactions(offset: offset, limit: limit);
  }
}*/
