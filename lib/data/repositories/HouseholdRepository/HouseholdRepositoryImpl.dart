import 'package:amplify/data/api_services/api_services.dart';
import 'package:amplify/data/repositories/householdRepository/HouseholdRepository.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/models/response/history.dart';

class HouseholdRepositoryImpl implements HouseholdRepository {
  final ApiServices _apiServices = ApiServices();

   @override
  Future<List<Household>> fetchHouseholds() async {
    try {
      final households = await _apiServices.fetchClients();
      return households;
    } catch (e) {
      print('Error fetching households: $e');
      return [];
    }
  }

  @override
  Future<Household?> getHouseholdById(String uniqueId) async {
    final households = await fetchHouseholds();
    return households.firstWhere(
      (household) => household.id == uniqueId,
    );
  }

//  @override
// Future<List<Account>> fetchAccountsByhouseholdGuid(String householdGuid) async {
//   try {

//     final accounts = await _apiServices.fetchAccountsByClientId(householdGuid);

//     return accounts
//         .map((json) => Account.fromJson(json as Map<String, dynamic>))
//         .where((account) => account.householdGuid == householdGuid)
//         .toList();
//     } catch (e) {

//     print('Error fetching accounts: $e');
//     return [];
//   }
// }


  @override
Future<List<Asset>> fetchAssetsByhouseholdGuid(String id) async {
  try {
    // Call the API to fetch assets based on the clientId (which corresponds to the householdGuid in your case)
    final assets = await _apiServices.fetchAssetsByClientId(id);
    
   print(assets);
    return assets;
  } catch (e) {
    print('Error fetching assets by householdGuid: $e');
    return [];
  }
}

@override
Future<List<History>> fetchHistoryByhouseholdGuid(String householdGuid) async {
  try {
    // Call the API to fetch history based on the clientId (which corresponds to the householdGuid in your case)
    final List<History> history = await _apiServices.fetchHistoryByClientId(householdGuid);

    // Print the fetched history for debugging purposes
    print('Fetched history: $history');

    // Return the fetched history
    return history;
  } catch (e, stacktrace) {
    // Log the error and stacktrace for debugging
    print('Error fetching history by householdGuid: $e');
    print('Stacktrace: $stacktrace');

    // Return an empty list in case of an error
    return [];
  }
}

}
