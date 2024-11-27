
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/models/response/history.dart';

abstract class HouseholdRepository {
  Future<List<Household>> fetchHouseholds();
  Future<List<Asset>> fetchAssetsByhouseholdGuid(String householdGuid);
  Future<List<History>> fetchHistoryByhouseholdGuid(String householdGuid);
}
