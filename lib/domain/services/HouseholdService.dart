import 'package:amplify/data/repositories/householdRepository/HouseholdRepository.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/models/response/history.dart';

class HouseholdService {
  final HouseholdRepository _householdRepository;

  HouseholdService(this._householdRepository);

  Future<List<Household>> getHouseholds() async {
    try {
      var households = await _householdRepository.fetchHouseholds();
      print('Fetched households: $households');
      return households;
    } catch (error) {
      print('Error fetching households: $error'); 
      throw Exception('Failed to fetch households'); 
    }
  }

  Future<Household?> getHouseholdById(String householdGuid) async {
    try {
      var household = await _householdRepository.getHouseholdById(householdGuid);
      return household;
    } catch (error) {
      print('Error fetching household by ID: $error');
      throw Exception('Failed to fetch household with ID: $householdGuid');
    }
  }

  // Future<List<Account>> getAccountsByhouseholdGuid(String householdGuid) async {
  //   try {
  //     var accounts = await _householdRepository.fetchAccountsByhouseholdGuid(householdGuid);
  //     return accounts;
  //   } catch (error) {
  //     print('Error fetching accounts for household ID: $error');
  //     throw Exception('Failed to fetch accounts for household ID: $householdGuid');
  //   }
  // }

  Future<List<Asset>> getAssetsByhouseholdGuid(String householdGuid) async {
    try {
      var assets = await _householdRepository.fetchAssetsByhouseholdGuid(householdGuid);
      print('Fetched assets: $assets');
      return assets;
    } catch (error) {
      print('Error fetching assets for household ID: $error');
      throw Exception('Failed to fetch assets for household ID: $householdGuid');
    }
  }

  Future<List<History>> getHistoryByhouseholdGuid(String householdGuid) async {
    try {
      var history = await _householdRepository.fetchHistoryByhouseholdGuid(householdGuid);
      print('Fetched history: $history');
      return history;
    } catch (error) {
      print('Error fetching history for household ID: $error');
      throw Exception('Failed to fetch history for household ID: $householdGuid');
    }
  }
}
