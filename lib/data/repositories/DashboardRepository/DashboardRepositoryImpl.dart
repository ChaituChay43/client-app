
import 'package:amplify/data/api_services/api_services.dart';
import 'package:amplify/data/repositories/DashboardRepository/DashboardRepository.dart';
import 'package:amplify/models/other/account_data.dart';


class DashboardRepositoryImpl implements DashboardRepository {
  int _currentIndex=0;
    final ApiServices _apiServices = ApiServices();

  @override
@override
Future<List<Account>> getAccountsByhouseholdGuid(String uniqueId) async {
  try {
    print('My Household id is $uniqueId');
    final accounts = await _apiServices.fetchAccountsByClientId(uniqueId);
    print('Fetched accounts: $accounts');

    // Filter accounts by householdGuid
    return accounts.where((account) => account.householdId == uniqueId).toList();
  } catch (e) {
    print("Error in getAccountsByhouseholdGuid: $e");
    return [];
  }
}

  @override
 @override
Future<Account?> getAccountById(String uniqueId) async {
  try {
    // Fetch the account directly by uniqueId
    final account = await _apiServices.fetchAccountById(uniqueId);
    print('selected account is $account');
    return account; // Return the fetched account directly
  } catch (e) {
    print("Error in getAccountById: $e");
    return null; // Return null if an error occurs
  }
}


   @override
     int getIndex() {
    return _currentIndex;
  }

  @override
  void setIndex(int index) {
    _currentIndex = index;
  }
}
