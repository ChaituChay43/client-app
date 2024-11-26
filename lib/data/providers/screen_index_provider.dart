import 'package:amplify/data/repositories/DashboardRepository/DashboardRepositoryImpl.dart';
import 'package:amplify/data/repositories/HouseholdRepository/HouseholdRepositoryImpl.dart';
import 'package:amplify/domain/services/DashboardService.dart';
import 'package:amplify/domain/services/HouseholdService.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:flutter/foundation.dart';

class ScreenIndexProvider with ChangeNotifier {
  final DashboardService accountsService = DashboardService(DashboardRepositoryImpl());
    final HouseholdService service = HouseholdService(HouseholdRepositoryImpl());

  List<String> _householdIds = [];
  List<String> get householdIds => _householdIds;
  bool _isLoading = false;

  int _selectedIndex = 0;
  String? _selectedAccountId;
  Account? _selectedAccount;

  late List<Household> fetchedHouseholds = [];
  List<Account> _accounts = []; // List to store fetched accounts
  List<Account> get accounts => _accounts; // Getter to access accounts list

  final Map<String, bool> _expandedStates = {}; // Map to track isExpanded for each household
  bool isExpanded(String householdId) => _expandedStates[householdId] ?? false; // Getter for specific household's expanded state

  int get selectedIndex => _selectedIndex;
  String? get selectedAccountId => _selectedAccountId;
  Account? get selectedAccount => _selectedAccount;
  bool get isLoading => _isLoading;

  // Constructor to initialize the households when the provider is created
  ScreenIndexProvider() {
    _initializeHouseholds();
  }

  // Method to initialize households and set householdIds
  Future<void> _initializeHouseholds() async {
    setLoading(true);
    try {
      // Fetch households
      fetchedHouseholds = await service.getHouseholds();

      // Extract householdIds
      List<String> householdIds = fetchedHouseholds.map((household) => household.id).toList();
      setHouseholdIds(householdIds);
    } catch (e) {
      print("Error initializing households: $e");
    } finally {
      setLoading(false);
    }
  }

  // Setter for householdIds with added logic to check for accounts
  void setHouseholdIds(List<String> ids) async {
    _householdIds = ids;
    notifyListeners();

    // Try to fetch accounts using the first householdId
    await _tryFetchAccountsForHousehold(ids);
  }

  // Method to try fetching accounts for a householdId
  Future<void> _tryFetchAccountsForHousehold(List<String> ids) async {
    for (String householdId in ids) {
      try {
        // Fetch accounts using the householdId
        var accounts = await accountsService.getAllAccountsByHouseholdId(householdId);

        // If accounts are found, update the selected account and store all accounts
        if (accounts.isNotEmpty) {
          _accounts = accounts; // Store all fetched accounts
          _selectedAccountId = accounts.first.id; // Get the first account
          _selectedAccount = await accountsService.getAccountById(accounts[0].id);
          notifyListeners(); // Notify listeners after updating selected account
          break; // Exit loop if accounts are found and selected
        }
      } catch (e) {
        print('Error fetching accounts for household $householdId: $e');
      }
    }
  }

  // Method to update selected account if selectedAccountId is changed
  Future<void> updateSelectedAccountId(String newAccountId) async {
    _selectedAccountId = newAccountId;
    notifyListeners();

    // Fetch the account data based on the new selectedAccountId
    if (_selectedAccountId != null) {
      _selectedAccount = await accountsService.getAccountById(_selectedAccountId!);
      print('My selectedAccount is $_selectedAccount'); // Assuming this method exists
      notifyListeners();
    }
  }

  // Setter for updating selectedIndex
  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  // Toggle `isExpanded` state for a specific household
  void toggleExpanded(String householdId) {
    _expandedStates[householdId] = !isExpanded(householdId);
    notifyListeners();
  }

  // Explicit setter for `isExpanded` for a specific household
  void setExpanded(String householdId, bool value) {
    _expandedStates[householdId] = value;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
