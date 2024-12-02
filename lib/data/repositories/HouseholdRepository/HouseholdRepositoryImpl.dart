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
Future<List<Asset>> fetchAssetsByhouseholdGuid(String householdGuid) async {
  try {
    // Fetch combined data from the API
    final data = await _apiServices.fetchDataByClientId(householdGuid);
    
    // Extract and parse 'assets' from the data
    final List<dynamic> assetsData = data['assets'];
    print('Fetched assets: $assetsData');
    return assetsData.map((json) {
      if (json is Map<String, dynamic>) {
        return Asset.fromJson(json);
      } else {
        throw FormatException('Unexpected data format for asset: $json');
      }
    }).toList();
  } catch (e, stacktrace) {
    print('Error fetching assets by householdGuid: $e');
    print('Stacktrace: $stacktrace');
    return []; // Return an empty list in case of error
  }
}
@override
Future<List<History>> fetchHistoryByhouseholdGuid(String householdGuid) async {
  try {
    // Fetch combined data from the API
    final data = await _apiServices.fetchDataByClientId(householdGuid);

    // Extract and parse 'history' from the data
    final List<dynamic> historyData = data['history'];
    print('Fetched history: $historyData');
    return historyData.map((json) {
      if (json is Map<String, dynamic>) {
        return History.fromJson(json);
      } else {
        throw FormatException('Unexpected data format for history: $json');
      }
    }).toList();
  } catch (e, stacktrace) {
    print('Error fetching history by householdGuid: $e');
    print('Stacktrace: $stacktrace');
    return []; // Return an empty list in case of error
  }
}

  @override
  Future<Household?> getHouseholdById(String uniqueId) {
    // TODO: implement getHouseholdById
    throw UnimplementedError();
  }
}
