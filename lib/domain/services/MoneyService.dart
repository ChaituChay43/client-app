// /lib/domain/services/household_service.dart
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/StockAsset.dart';
import 'package:amplify/data/repositories/moneyRepository/moneyRepository.dart';


class MoneyService {
  final MoneyRepository repository;

  MoneyService(this.repository);

  Future<List<Asset>> getAssets(String accountId) async {
    print('My Assets are ');
    print(repository.fetchAssets(accountId));
    return await repository.fetchAssets(accountId);
  }
   Future<List<StockAsset>> getHoldings(String accountId) async {
     print('My Holdings  are ');
    print(repository.fetchHoldings(accountId));
    return await repository.fetchHoldings(accountId);
  }

}
