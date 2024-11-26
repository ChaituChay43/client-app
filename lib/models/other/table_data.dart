import 'package:amplify/views/components/home/money/table_component.dart';
import 'package:flutter/material.dart';

class TableDataProvider with ChangeNotifier {
    final List<ColumnConfig> assetColumns = [
    ColumnConfig(name: 'Name', textAlign: TextAlign.start, isChange: true, isEllipsis: true),
    ColumnConfig(name: 'Value', textAlign: TextAlign.start, isBold: true, isEllipsis: true),
    ColumnConfig(name: 'percentage', textAlign: TextAlign.start, isBold: true),
  ];
   List<Map<String, Object>> filteredAssetData = [
    {
      "Name": "Cash & Equivalents",
      "Value": "\$4,754,648.00",
      "percentage": 46.6
    },
    {
      "Name": "Domestic Equities",
      "Value": "\$3,834,723.39",
      "percentage": 37.6
    },
    {
      "Name": "To Be Classified",
      "Value": "\$836,316.81",
      "percentage": 8.2
    },
    {
      "Name": "Fixed Income",
      "Value": "\$534,826.08",
      "percentage": 5.2
    },
    {
      "Name": "International Equities",
      "Value": "\$135,784.32",
      "percentage": 1.3
    },
    {
      "Name": "Real Estate Securities",
      "Value": "\$77,365.61",
      "percentage": 0.8
    },
    {
      "Name": "Alternative Investments",
      "Value": "\$26,445.05",
      "percentage": 0.3
    },
    {
      "Name": "Unclassified",
      "Value": "\$10,024.32",
      "percentage": 0.1
    }
  ];
}
