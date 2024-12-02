import 'package:amplify/data/repositories/DashboardRepository/DashboardRepositoryImpl.dart';
import 'package:amplify/data/repositories/HouseholdRepository/HouseholdRepositoryImpl.dart';
import 'package:amplify/domain/services/DashboardService.dart';
import 'package:amplify/domain/services/HouseholdService.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:flutter/foundation.dart';

class ScreenIndexProvider with ChangeNotifier {
  // Services
  final DashboardService accountsService = DashboardService(DashboardRepositoryImpl());
  final HouseholdService service = HouseholdService(HouseholdRepositoryImpl());
  List<String> _householdIds = [];
  List<String> get householdIds => _householdIds;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _selectedIndex = 0;
  String? _selectedAccountId;
  Account? _selectedAccount;

  List<Account> _accounts = [];
  List<Account> get accounts => _accounts;

  late List<Household> fetchedHouseholds = [];

  final Map<String, bool> _expandedStates = {}; // To track isExpanded for each household
  final Map<String, double> _savedPositions = {}; // To track saved scroll positions

  // -------------------- Constructor --------------------
  ScreenIndexProvider() {
    _initializeHouseholds();
  }

  // -------------------- Getters and Setters --------------------

  int get selectedIndex => _selectedIndex;
  String? get selectedAccountId => _selectedAccountId;
  Account? get selectedAccount => _selectedAccount;

  /// Check if a specific household is expanded
  bool isExpanded(String householdId) {
    return _expandedStates[householdId] ?? false;
  }

  /// Get saved scroll position for a specific household
  double getSavedPosition(String householdId) {
    return _savedPositions[householdId] ?? 0.0;
  }

  /// Set loading state
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Update household IDs
  void setHouseholdIds(List<String> ids) async {
    _householdIds = ids;
    notifyListeners();

    // Fetch accounts for the households
    await _tryFetchAccountsForHousehold(ids);
  }

  /// Update selected index
  void updateIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  /// Set expanded state for a household
  void setExpanded(String householdId, bool value) {
    _expandedStates[householdId] = value;
    notifyListeners();
  }

  /// Toggle expanded state for a household
  void toggleExpanded(String householdId) {
    _expandedStates[householdId] = !isExpanded(householdId);
    notifyListeners();
  }

  /// Save scroll position for a specific household
  void savePosition(String householdId, double position) {
    _savedPositions[householdId] = position;
    notifyListeners();
  }

  // -------------------- Initialization and Data Fetching --------------------

  /// Initialize households and set household IDs
  Future<void> _initializeHouseholds() async {
    setLoading(true);
    try {
      fetchedHouseholds = await service.getHouseholds();
      List<String> householdIds = fetchedHouseholds.map((household) => household.id).toList();
      setHouseholdIds(householdIds);
    } catch (e) {
      print("Error initializing households: $e");
    } finally {
      setLoading(false);
    }
  }

  /// Try fetching accounts for each household ID
  Future<void> _tryFetchAccountsForHousehold(List<String> ids) async {
    for (String householdId in ids) {
      try {
        var accounts = await accountsService.getAllAccountsByHouseholdId(householdId);
        if (accounts.isNotEmpty) {
          _accounts = accounts;
          _selectedAccountId = accounts.first.id;
          _selectedAccount = await accountsService.getAccountById(accounts[0].id);
          notifyListeners();
          break; // Stop looping once accounts are found
        }
      } catch (e) {
        print('Error fetching accounts for household $householdId: $e');
      }
    }
  }

  // -------------------- Account Selection --------------------

  /// Update selected account ID and fetch account details
  Future<void> updateSelectedAccountId(String newAccountId) async {
    _selectedAccountId = newAccountId;
    notifyListeners();

    if (_selectedAccountId != null) {
      try {
        _selectedAccount = await accountsService.getAccountById(_selectedAccountId!);
        print('Selected Account: $_selectedAccount');
        notifyListeners();
      } catch (e) {
        print('Error updating selected account: $e');
      }
    }
  }
}
