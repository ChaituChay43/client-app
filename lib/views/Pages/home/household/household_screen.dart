import 'package:amplify/data/providers/screen_index_provider.dart';
import 'package:amplify/data/repositories/DashboardRepository/DashboardRepositoryImpl.dart';
import 'package:amplify/data/repositories/householdRepository/HouseholdRepositoryImpl.dart';
import 'package:amplify/domain/services/DashboardService.dart';
import 'package:amplify/domain/services/HouseholdService.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/views/Pages/home/household/household_subscreens/expandable_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HouseholdScreen extends StatefulWidget {
  const HouseholdScreen({super.key});

  @override
  State<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
  late String getId; 
  late List<Household> fetchedHouseholds = [];
  final HouseholdService service = HouseholdService(HouseholdRepositoryImpl());
  final DashboardService accountsService = DashboardService(DashboardRepositoryImpl());

  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchHouseholds();
  }

  Future<void> _fetchHouseholds() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });


    try {
      fetchedHouseholds = await service.getHouseholds();
    } catch (e) {
      setState(() {
        hasError = true;
      });
      print('Error fetching households: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : hasError
              ? const Center(child: Text('Error loading households.'))
              : SingleChildScrollView(
                  child: Column(
                children: fetchedHouseholds.map((household) {
                  return ExpandableHouseholdSection(
                    household: household,
                    accountsService: accountsService,
                  );
  }).toList(),
)
                ),
    );
  }
}
