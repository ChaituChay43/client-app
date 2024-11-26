import 'package:amplify/data/api_services/api_services.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/StockAsset.dart';
import 'package:amplify/data/repositories/moneyRepository/moneyRepository.dart';


class MoneyRepositoryImpl implements MoneyRepository {
    final ApiServices _apiServices = ApiServices();

@override
Future<List<Asset>> fetchAssets(String accountId) async {
  try {
    // Fetch assets from the API
    final List<Asset> assets = await _apiServices.fetchAssetsByAccountId(accountId);
    
    // Print the fetched assets to verify data with readable output using toString()
    print("Fetched assets: ${assets.map((asset) => asset.toString()).toList()}");

    // Return the assets list
    return assets;
  } catch (e) {
    print("Error in fetchAssets: $e");
    rethrow; // Rethrow the error after logging it
  }
}

@override
Future<List<StockAsset>> fetchHoldings(String accountId) async {
  try {
    // Fetch holdings from the API
    final List<StockAsset> holdings = await _apiServices.fetchHoldingsByAccountId(accountId);
    
    // Print the fetched holdings to verify data with readable output using toString()
    print("Fetched holdings: ${holdings.map((holding) => holding.toString()).toList()}");

    // Return the holdings list
    return holdings;
  } catch (e) {
    print("Error in fetchHoldings: $e");
    rethrow; // Rethrow the error after logging it
  }
}



}