import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/views/components/Dashboard_dropdown.dart';
import 'package:amplify/views/components/asset_chart.dart';
import 'package:amplify/views/components/table_component.dart';
import 'package:flutter/material.dart';


class MoneyContent extends StatefulWidget {
  const MoneyContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MoneyContentState createState() => _MoneyContentState();
}

class _MoneyContentState extends State<MoneyContent> {
  final List<String> _dropdownItems = [
    'Household',
    'Option 1',
    'Option 2',
    'Option 3',
  ];

    final List<String> _assetdropdownItems = [
    'View by asset class',
    'Option 4',
    'Option 5',
    'Option 6',
  ];

  String _selectedItem = 'Household'; 

  // ignore: unused_field
   String _selectedAsset = 'View by Asset class';

  final List<Map<String, dynamic>> tableData = [
    {"Symbol": "AAPL", "Name": "Apple Inct.tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt", "Value": '\$145123,1.09', "%": 1.2},
    {"Symbol": "TSLA", "Name": "Tesla Inc.", "Value": '\$145,2321.09', "%": -2.4},
    {"Symbol": "GOOGL", "Name": "Alphabet Inc.", "Value":'\$108,1223.09', "%": 3.5},
    {"Symbol": "AMZN", "Name": "Amazon Inc.", "Value": '\$1005,232.09', "%": 0.9},
    {"Symbol": "MSFT", "Name": "Microsoft Corp.", "Value": '\$11023,21.09', "%": 1.8},
     {"Symbol": "GOOGL", "Name": "Alphabet Inc.", "Value": '\$127932,4.09', "%": 3.5},
    {"Symbol": "AMZN", "Name": "Amazon Inc.", "Value": '\$1298,5.09', "%": 0.9},
    {"Symbol": "MSFT", "Name": "Microsoft Corp.", "Value": '\$1204882,5.09', "%": 1.8},
  ];

   final List<Map<String, dynamic>> assettableData = [
    { "Name": "Domestic Equities.", "Value": '\$469,730.00', "%": 48.3},
    { "Name": "Cash & Equivalents.", "Value": '\$262,500.00', "%": 27.0},
    { "Name": "Fixed Income.", "Value":'\$176,300.00', "%": 18.1},
    {"Name": "International Equities.", "Value": '\$63,500.00', "%": 6.5},
  ];

  final List<ColumnConfig> columns = [
    ColumnConfig(name: 'Symbol',  isBold: true, backgroundColor: Colors.lightBlueAccent.withOpacity(0.3)),
    ColumnConfig(name: 'Name' , ),
    ColumnConfig(name: 'Value',  textAlign: TextAlign.end, isBold: true, ),
    ColumnConfig(name: '%',  textAlign: TextAlign.end, isBold: true),
  ];
 final List<ColumnConfig> assetcolumns = [
    ColumnConfig(name: 'Name',  textAlign:TextAlign.start,isChange:true),
    ColumnConfig(name: 'Value',  textAlign: TextAlign.start, isBold: true),
    ColumnConfig(name: '%',  textAlign: TextAlign.start, isBold: true),
  ];
   

  void _onItemSelected(String value) {
    setState(() {
      _selectedItem = value;
    });
  }

  void _onAssetItemSelected(String value) {
    setState(() {
      _selectedAsset= value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
              Card(
                elevation: 5.0,
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 650, 
                  ),
                  color:Colors.white,
                  child: Column(
                  
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: LayoutBuilder(
                        builder: (context, constraints) {
                        // Switch between Row and Column based on container width
                        bool isWideScreen = constraints.maxWidth > 400; // Adjust threshold as needed

                       return isWideScreen? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Asset Class Chart',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                  color:  Color(0xFFECECEC)
                                ),
                                          
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        ' $_selectedAsset',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    DropdownIconButton(
                                      icon: const Icon(Icons.keyboard_arrow_down_sharp,color:AppTheme.primaryColor,),
                                      items: _assetdropdownItems,
                                      onSelected: _onAssetItemSelected,
                                      maxHeight: 150.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ):Column(
                            children:[
                              const Text(
                                'Asset Class Chart',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                                      
                              SizedBox(height: 10.0,),
                                                        Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                border: Border.all(color: Colors.grey, width: 1.0),
                                 color:  Color(0xFFECECEC)
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,  
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ' $_selectedAsset',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DropdownIconButton(
                                     icon: const Icon(Icons.keyboard_arrow_down_sharp,color:AppTheme.primaryColor,),
                                    items: _assetdropdownItems,
                                    onSelected: _onAssetItemSelected,
                                    maxHeight: 150.0,
                                  ),
                                ],
                              ),
                            )

                            ],
                          );}
                        ),
                      ),
                    Container(      
                        child: DoughnutChartWithHover(), // Chart is wrapped inside an Expanded widget
                    ),
                



                     Expanded(
                       child: ReusableTable(
                         tableData: assettableData,
                         columns: assetcolumns,
                       ),
                     ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Card(
                elevation: 10.0,
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 450, 
                  ),
                  color:Colors.white,
                  
                  child: Column(
                  
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Holdings',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                 borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                                  border: Border.all(color: Colors.grey, width: 1.0),
                                   color:  Color(0xFFECECEC)
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      ' $_selectedItem',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DropdownIconButton(
                                    icon: const Icon(Icons.keyboard_arrow_down_sharp,color:AppTheme.primaryColor,),
                                    items: _dropdownItems, 
                                    onSelected: _onItemSelected,
                                    maxHeight: 150.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                     Expanded(
                       child: ReusableTable(
                         tableData: tableData,
                         columns: columns,
                       ),
                     ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      
    );
  }
}
