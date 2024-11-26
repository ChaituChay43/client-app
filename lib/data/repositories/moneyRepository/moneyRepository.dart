import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/StockAsset.dart';


abstract class MoneyRepository {
  Future<List<Asset>> fetchAssets(String accountId);
  Future<List<StockAsset>> fetchHoldings(String accountId);
}
