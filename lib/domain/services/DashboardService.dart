// /lib/domain/services/household_service.dart
import 'dart:async';
import 'package:amplify/data/repositories/DashboardRepository/DashboardRepository.dart';
import 'package:amplify/models/other/account_data.dart';

class DashboardService {
  final DashboardRepository repository;

  final StreamController<int> _indexController = StreamController<int>.broadcast();

  DashboardService(this.repository);

  Stream<int> get indexStream => _indexController.stream;

  Future<List<Account>> getAllAccountsByHouseholdId(String uniqueId) async {
    try {
      return await repository.getAccountsByhouseholdGuid(uniqueId);
    } catch (e) {
      // Handle or log the error accordingly
      print("Error fetching accounts by Household ID: $e");
      return [];
    }
  }

  Future<Account?> getAccountById(String id) async {
    try {
      return await repository.getAccountById(id);
    } catch (e) {
      // Handle or log the error accordingly
      print("Error fetching account by ID: $e");
      return null;
    }
  }

  int getCurrentIndex() {
    return repository.getIndex();
  }

  void setCurrentIndex(int index) {
      _indexController.add(index);
  }

   void dispose() {
    _indexController.close();
  }
}
