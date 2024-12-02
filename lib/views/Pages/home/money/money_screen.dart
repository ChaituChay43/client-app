import 'package:amplify/views/components/utilities/account_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:amplify/data/providers/screen_index_provider.dart'; 
import 'package:amplify/models/response/Asset.dart';
import 'package:amplify/models/response/StockAsset.dart';
import 'package:amplify/data/repositories/moneyRepository/moneyRepositoryImpl.dart';
import 'package:amplify/domain/services/MoneyService.dart';
import 'package:amplify/views/components/home/money/table_component.dart';
import 'package:amplify/views/components/home/money/asset_chart.dart';
class MoneyContent extends StatefulWidget {
  const MoneyContent({super.key});

  @override
  _MoneyContentState createState() => _MoneyContentState();
}

class _MoneyContentState extends State<MoneyContent> {
  late List<StockAsset> stockholdings = [];
  bool isLoading = true;
  String errorMessage = '';
  late List<Asset> stockAssets;

  final MoneyService service = MoneyService(MoneyRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final accountId = Provider.of<ScreenIndexProvider>(context, listen: false).selectedAccountId;
    if (accountId == null) {
      setState(() {
        errorMessage = "No account selected.";
        isLoading = false;
      });
      return;
    }

    fetchAccountAssets(accountId);
    fetchAccountHoldings(accountId);
  }

  Future<void> fetchAccountAssets(String accountId) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      stockAssets = await service.getAssets(accountId);
      if (stockAssets.isEmpty) {
        errorMessage = "No stock assets found.";
      }
    } catch (e) {
      errorMessage = "Error fetching stock assets: $e";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchAccountHoldings(String accountId) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      stockholdings = await service.getHoldings(accountId);
      if (stockholdings.isEmpty) {
        errorMessage = "No stock holdings found.";
      }
    } catch (e) {
      errorMessage = "Error fetching stock holdings: $e";
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final List<ColumnConfig> stockColumns = [
    ColumnConfig(name: 'Symbol', isBold: true, backgroundColor: Colors.lightBlueAccent.withOpacity(0.3), isEllipsis: true),
    ColumnConfig(name: 'Name', isEllipsis: true),
    ColumnConfig(name: 'Value', textAlign: TextAlign.end,  isEllipsis: true),
    ColumnConfig(name: 'Percentage', textAlign: TextAlign.end,  isEllipsis: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ScreenIndexProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AccountHeader(
                  accountName: provider.selectedAccount?.accountName ?? '',
                  accountNames: provider.accounts,
                  onItemSelected: (selectedName) => onAccountSelected(selectedName, provider),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0), // Adjust based on `AccountHeader` height
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                        ? Center(child: Text(errorMessage))
                        : ListView(
                            children: [
                              _buildAssetClassSection(),
                              const SizedBox(height: 20.0),
                              _buildHoldingsSection(),
                            ],
                          ),
              ),
            ],
          );
        },
      ),
    );
  }

  void onAccountSelected(String selectedName, ScreenIndexProvider provider) {
      provider.setLoading(true); // Start loading
    Future.delayed(const Duration(milliseconds: 500)); // Simulate data fetch
    final foundAccount = provider.accounts.firstWhere(
      (account) => account.accountName == selectedName,
      orElse: () => provider.accounts.first,
    );
    provider.updateSelectedAccountId(foundAccount.id);
    provider.setLoading(false); // Stop loading
    _fetchData();
  }
 
  Widget _buildAssetClassSection() {
    List<double> values = stockAssets.map((asset) => asset.percentage).toList();
    List<String> labels = stockAssets.map((asset) => asset.value.toString()).toList();
    List<Color> colors = List.generate(values.length, (index) => Colors.primaries[index % Colors.primaries.length]);

    return Card(
      elevation: 5.0,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 450),
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Asset Class Chart',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: DoughnutChartWithHover(
                values: values,
                labels: labels,
                colors: colors,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoldingsSection() {
    return Card(
      elevation: 10.0,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 450),
        color: Colors.white,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Holdings',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ReusableTable(
                tableData: stockholdings.map((holding) {
                  return {
                    'Symbol': holding.symbol,
                    'Name': holding.name,
                    'Value': holding.value.toString(),
                    'Percentage': holding.percentage.toString(),
                  };
                }).toList(),
                columns: stockColumns,
                colors: [Colors.lightBlueAccent.withOpacity(0.3)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
