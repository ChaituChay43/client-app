import 'package:amplify/data/providers/screen_index_provider.dart';
import 'package:amplify/data/repositories/HouseholdRepository/HouseholdRepositoryImpl.dart';
import 'package:amplify/domain/services/DashboardService.dart';
import 'package:amplify/domain/services/HouseholdService.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/Household.dart';
import 'package:amplify/models/response/history.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/views/Pages/home/household/household_subscreens/chartScreen.dart';
import 'package:amplify/views/Pages/home/household/household_subscreens/household_accountList.dart';
import 'package:amplify/views/components/home/household/HistoryGraph.dart';
import 'package:amplify/views/components/home/household/summary_card.dart';
import 'package:amplify/views/components/home/money/table_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';


class ExpandableHouseholdSection extends StatefulWidget {
  final Household household;
  final DashboardService accountsService;

  const ExpandableHouseholdSection({
    Key? key,
    required this.household,
    required this.accountsService, 
  }) : super(key: key);

  @override
  _ExpandableHouseholdSectionState createState() => _ExpandableHouseholdSectionState();
}

class _ExpandableHouseholdSectionState extends State<ExpandableHouseholdSection> {
  List<Account> accounts = [];
  List<Asset> stockAssets = [];
  bool isLoading = false;
  bool hasError = false;
  String errorMessage = '';
  final HouseholdService service = HouseholdService(HouseholdRepositoryImpl());
  final List<ColumnConfig> stockColumns = [
    ColumnConfig(name: 'Name', isEllipsis: true),
    ColumnConfig(name: 'Value', textAlign: TextAlign.end, isBold: true, isEllipsis: true),
    ColumnConfig(name: 'Percentage', textAlign: TextAlign.end, isBold: true, isEllipsis: true),
  ];

  late List<History> HouseholdHistory=[];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchHouseholdAssetDetails(String householdGuid) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      List<Asset> fetchedAssets =
          await service.getAssetsByhouseholdGuid(householdGuid);
      print('Fetched assets for householdGuid $householdGuid: $fetchedAssets');

      setState(() {
        stockAssets = fetchedAssets;
        if (fetchedAssets.isEmpty) {
          errorMessage = "No stock holdings found.";
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = "Error fetching stock holdings: $e";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchAccounts(String householdGuid) async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      List<Account> fetchedAccounts =
          await widget.accountsService.getAllAccountsByHouseholdId(householdGuid);
      print('Fetched accounts for householdGuid $householdGuid: $fetchedAccounts');

      setState(() {
        accounts = fetchedAccounts;
        if (fetchedAccounts.isEmpty) {
          hasError = true;
        }
      });
    } catch (e) {
      setState(() {
        hasError = true;
        print('Error fetching accounts: $e');
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

bool hasDataLoadedInitially = false; // New flag

Future<void> _fetchHistory(String householdGuid) async {
  setState(() {
    isLoading = true;
    hasError = false;
  });

  try {
    List<History> fetchedHistory =
        await service.getHistoryByhouseholdGuid(householdGuid);
    print('Fetched History for householdGuid $householdGuid: $fetchedHistory');

    setState(() {
      HouseholdHistory = fetchedHistory;
      hasError = false; // No error even if data is empty
    });
  } catch (e) {
    setState(() {
      hasError = true;
      print('Error fetching History: $e');
    });
  } finally {
    setState(() {
      isLoading = false;
      hasDataLoadedInitially = true; // Set to true after first load completes
    });
  }
}



  @override
  Widget build(BuildContext context) {
    final chartData = _generateChartData();
    final provider = Provider.of<ScreenIndexProvider>(context); // Access provider's state
    final HouseholdAmount=NumberFormat('#,##0', 'en_US').format(widget.household.amount);
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: provider.isExpanded(widget.household.id) ? Colors.white : AppTheme.primaryColor,
      ),
      child: ExpansionTile(
        title: SummaryCard(
          title: widget.household.householdName,
          totalAmount: '\$$HouseholdAmount',
          isExpanded: provider.isExpanded(widget.household.id),
        ),
        trailing: Icon(
          provider.isExpanded(widget.household.id) ? Icons.keyboard_arrow_up_outlined : Icons.keyboard_arrow_down_sharp,
          color: provider.isExpanded(widget.household.id) ? AppTheme.primaryColor : Colors.white,
          size: 40.0,
        ),
        onExpansionChanged: (expanded) {
          provider.setExpanded(widget.household.id, expanded); // Update provider  
          if (provider.isExpanded(widget.household.id)) {
                fetchHouseholdAssetDetails(widget.household.id);
                _fetchAccounts(widget.household.id);
                _fetchHistory(widget.household.id);
           }
        },
        children: [
          if (provider.isExpanded(widget.household.id)) ...[
          SizedBox(
                  height: 440.0,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : hasError
                          ? const Center(
                              child: Text(
                                "Failed to load history data. Please try again.",
                                style: TextStyle(fontSize: 16.0, color: Colors.black),
                              ),
                            )
                          : HouseholdHistory.isNotEmpty
                              ? HistoryGraph(householdHistory: HouseholdHistory)
                              : hasDataLoadedInitially
                                  ? const Center(
                                      child: Text(
                                        "No History data found",
                                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                                      ),
                                    )
                                  : const SizedBox.shrink(), // Show nothing until data is loaded
                ),
            if (chartData.chartValues.isNotEmpty && !isLoading)
              ChartContainer(chartData: chartData),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage.isNotEmpty)
              Text(errorMessage)
            else
              SizedBox(
                height: 300,
                child: ReusableTable(
                  tableData: stockAssets.map((account) {
                    return {
                      'Name': account.name,
                      'Value': account.value,
                      'Percentage': account.percentage,
                    };
                  }).toList(),
                  columns: stockColumns,
                  colors: List<Color>.generate(
                    stockAssets.length,
                    (index) => Colors.primaries[index % Colors.primaries.length],
                  ),
                ),
              ),
            const SummaryCard(title: "Accounts Summary", totalAmount: '', isExpanded: false),
            if (isLoading)
              const CircularProgressIndicator()
            else if (hasError && !isLoading)
              const Text('No fetching accounts.')
            else if (accounts.isNotEmpty && !isLoading)
              AccountList(accounts: accounts)
            else if (!isLoading)
              const Text('No accounts available.')
          ],
        ],
      ),
    );
  }

  ChartData _generateChartData() {
    if (stockAssets.isEmpty) {
      return ChartData(
        chartValues: [],
        chartLabels: [],
        chartColors: [], // Ensure empty chart colors to prevent errors
      );
    } 
    List<double> values = [];
    List<String> labels = [];

    for (var stock in stockAssets) {
      values.add(stock.percentage);
      labels.add(stock.name);
    }

    return ChartData(
      chartValues: values,
      chartLabels: labels,
      chartColors: List<Color>.generate(
        values.length,
        (index) => Colors.primaries[index % Colors.primaries.length],
      ),
    );
  }
}
