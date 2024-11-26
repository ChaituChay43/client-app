import 'package:amplify/models/other/account_data.dart';

abstract class DashboardRepository {
  // Method to get accounts by household ID
  Future<List<Account>> getAccountsByhouseholdGuid(String uniqueId);

  // Method to get a single account by its ID
  Future<Account?> getAccountById(String uniqueId);

  int getIndex();

  void setIndex(int index);
}
