import 'package:amplify/data/api_services/base_service.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/models/response/StockAsset.dart';
import 'package:amplify/models/response/history.dart';

class ApiServices extends BaseService {
  Future<List<Household>> fetchClients() async {
    try {
      final BaseResModel baseRes = await doGet('$serviceURL/portal');
      print('fetching households: $baseRes');

      // Ensure that baseRes.data is a list before attempting to map it to Household objects
      if (baseRes.data is List) {
        final List<dynamic> data = baseRes.data;
        return data.map((json) => Household.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception("Unexpected data format: Expected a list of households.");
      }
    } catch (e) {
      print("Error in fetchClients: $e");
      rethrow;
    }
  }

   Future<List<Account>> fetchAccountsByClientId(String clientId) async {
  try {
    final BaseResModel baseRes = await doGet('$serviceURL/portal/household/$clientId/accounts');
    print('fetching accounts for client $clientId: $baseRes');

    if (baseRes.data is List) {
      final List<dynamic> data = baseRes.data;
      print('My accounts $data');

      // Ensure each element is parsed as a Map<String, dynamic>
      return data.map((json) {
        if (json is Map<String, dynamic>) {
          return Account.fromJson(json);
        } else {
          throw Exception('Unexpected data format for account: $json');
        }
      }).toList();
    } else {
      throw Exception("Unexpected data format: Expected a list of accounts.");
    }
  } catch (e, stacktrace) {
    print("Error in fetchAccountsByClientId: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}

Future<Account> fetchAccountById(String accountId) async {
  try {
    final BaseResModel baseRes = await doGet('$serviceURL/portal/account/$accountId');
    print('Fetching account for account ID $accountId: $baseRes');

    if (baseRes.data is Map<String, dynamic>) {
      final Map<String, dynamic> data = baseRes.data;
      print('Account data: $data');

      return Account.fromJson(data);
    } else {
      throw Exception("Unexpected data format: Expected an account object.");
    }
  } catch (e, stacktrace) {
    print("Error in fetchAccountById: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}


Future<List<Asset>> fetchAssetsByClientId(String clientId) async {
  try {
    // Make GET request to fetch assets
    final BaseResModel baseRes = await doGet('$serviceURL/portal/household/$clientId');
    print('Fetching assets for client $clientId: $baseRes');
      final List<dynamic> data = baseRes.data["assets"];
      print('Assets data: $data');

      // Parse each item as Asset if it is a Map
      return data.map((json) {
        if (json is Map<String, dynamic>) {
          return Asset.fromJson(json);
        } else {
          throw FormatException('Unexpected data format for asset: $json');
        }
      }).toList();
  } catch (e, stacktrace) {
    print("Error in fetchAssetsByClientId: $e");
    print("Stacktrace: $stacktrace");
    rethrow; // Rethrow to allow upstream error handling
  }
}

Future<List<History>> fetchHistoryByClientId(String clientId) async {
  try {
    // Make GET request to fetch history data
    final BaseResModel baseRes = await doGet('$serviceURL/portal/household/$clientId');
    print('Fetching history for client $clientId: $baseRes');
    
    // Assuming the response contains a field "history" with a list of historical records
    final List<dynamic> data = baseRes.data["history"];
    print('History data: $data');
    
    // Parse each item as History if it is a Map
    return data.map((json) {
      if (json is Map<String, dynamic>) {
        return History.fromJson(json); // Assuming History class has fromJson method
      } else {
        throw FormatException('Unexpected data format for history: $json');
      }
    }).toList();
  } catch (e, stacktrace) {
    print("Error in fetchHistoryByClientId: $e");
    print("Stacktrace: $stacktrace");
    rethrow; // Rethrow to allow upstream error handling
  }
}

Future<List<Asset>> fetchAssetsByAccountId(String accountId) async {
  try {
    final BaseResModel baseRes = await doGet('$serviceURL/portal/account/$accountId');
    print('Fetching assets for account ID $accountId: $baseRes');
    
    final Map<String, dynamic> data = baseRes.data;
    print('Account data including assets and holdings: $data');

    if (data.containsKey('assets') && data['assets'] is List) {
      final List<dynamic> assetsData = data['assets'];
      print('Assets data received: $assetsData');
      return assetsData.map((json) {
        final assetJson = Map<String, dynamic>.from(json as Map);
        return Asset.fromJson(assetJson);
      }).toList();
    } else {
      throw FormatException('Assets data not found or in unexpected format.');
    }
  } catch (e, stacktrace) {
    print("Error in fetchAssetsByAccountId: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}

Future<List<StockAsset>> fetchHoldingsByAccountId(String accountId) async {
  try {
    final BaseResModel baseRes = await doGet('$serviceURL/portal/account/$accountId');
    print('Fetching holdings for account ID $accountId: $baseRes');
    
    final Map<String, dynamic> data = baseRes.data;
    print('Account data including assets and holdings: $data');

    if (data.containsKey('holdings') && data['holdings'] is List) {
      final List<dynamic> holdingsData = data['holdings'];
      print('Holdings data received: $holdingsData');
      
      // Check the structure of each holding object
      holdingsData.forEach((holding) {
        print('Holding item: $holding');
      });

      // Convert to StockAsset objects
      return holdingsData.map((json) {
        final holdingJson = Map<String, dynamic>.from(json as Map);
        return StockAsset.fromJson(holdingJson);
      }).toList();
    } else {
      throw FormatException('Holdings data not found or in unexpected format.');
    }
  } catch (e, stacktrace) {
    print("Error in fetchHoldingsByAccountId: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}




}


