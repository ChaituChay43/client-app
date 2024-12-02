import 'package:amplify/data/api_services/api_services.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/StockAsset.dart';
import 'package:amplify/data/repositories/moneyRepository/moneyRepository.dart';


class MoneyRepositoryImpl implements MoneyRepository {
    final ApiServices _apiServices = ApiServices();

@override
Future<List<Asset>> fetchAssets(String accountId) async {
  try {
    final data = await _apiServices.fetchAccountData(accountId);
    // Parse the 'assets' part of the response
    if (data.containsKey('assets') && data['assets'] is List) {
      final List<dynamic> assetsData = data['assets'];
      print('Fetched assets data: $assetsData');
      
      return assetsData.map((json) {
        final assetJson = Map<String, dynamic>.from(json as Map);
        return Asset.fromJson(assetJson);
      }).toList();
    } else {
      throw const FormatException('Assets data not found or in unexpected format.');
    }
  } catch (e) {
    print("Error in fetchAssets: $e");
    rethrow;
  }
}

@override
Future<List<StockAsset>> fetchHoldings(String accountId) async {
  try {
    final data = await _apiServices.fetchAccountData(accountId);
    // Parse the 'holdings' part of the response
    if (data.containsKey('holdings') && data['holdings'] is List) {
      final List<dynamic> holdingsData = data['holdings'];
      print('Fetched holdings data: $holdingsData');
      return holdingsData.map((json) {
        final holdingJson = Map<String, dynamic>.from(json as Map);
        return StockAsset.fromJson(holdingJson);
      }).toList();
    } else {
      throw const FormatException('Holdings data not found or in unexpected format.');
    }
  } catch (e) {
    print("Error in fetchHoldings: $e");
    rethrow;
  }
}

}