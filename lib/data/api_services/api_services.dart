import 'package:amplify/data/api_services/base_service.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/response/Household.dart';

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

Future<Map<String, dynamic>> fetchDataByClientId(String clientId) async {
  try {
    // Make GET request to fetch data (assets and history)
    final BaseResModel baseRes = await doGet('$serviceURL/portal/household/$clientId');
    print('Fetched data for client $clientId: ${baseRes.data}');
    
    // Ensure the data is in the correct format
    final Map<String, dynamic> data = baseRes.data;
    if (data.containsKey('assets') && data.containsKey('history')) {
      return data; // Return the entire response data
    } else {
      throw const FormatException('Response does not contain required fields: assets or history.');
    }
  } catch (e, stacktrace) {
    print("Error in fetchDataByClientId: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}

Future<Map<String, dynamic>> fetchAccountData(String accountId) async {
  try {
    // Fetch account data in one API call
    final BaseResModel baseRes = await doGet('$serviceURL/portal/account/$accountId');
    print('Fetched account data for ID $accountId: $baseRes');
    
    final Map<String, dynamic> data = baseRes.data;
    print('Complete account data: $data');
    
    // Ensure data contains the expected keys
    if (data.isEmpty || (!data.containsKey('assets') && !data.containsKey('holdings'))) {
      throw const FormatException('Expected assets or holdings data not found.');
    }

    return data; // Return the raw account data
  } catch (e, stacktrace) {
    print("Error in fetchAccountData: $e");
    print("Stacktrace: $stacktrace");
    rethrow;
  }
}

}


