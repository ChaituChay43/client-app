import 'package:amplify/models/response/history.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryGraph extends StatefulWidget {
  final List<History> householdHistory;

  const HistoryGraph({
    super.key,
    this.householdHistory = const [],
  });

  @override
  _HistoryGraphState createState() => _HistoryGraphState();
}


class _HistoryGraphState extends State<HistoryGraph> {
  String selectedRange = 'ALL';
  late List<Map<String, dynamic>> data;


  List<FlSpot> chartData = [];
   String? previousMonthStart;

  @override
  @override
void initState() {
    super.initState();
    // Ensure householdHistory is never null
    data = widget.householdHistory.isNotEmpty
        ? widget.householdHistory
            .asMap()
            .entries
            .map((entry) {
              final int index = entry.key;
              final History history = entry.value;

              return {
                'monthStart': index,
                'emv': (history.emv / 1000000).toDouble(),
                'formattedDate': DateFormat("MMM yy").format(history.monthStart),
              };
            })
            .toList()
        : []; // If empty, default to an empty list
    updateChartData('ALL');
  }


  void updateChartData(String range) {
    setState(() {
      selectedRange = range;
      chartData.clear();

      if (range == 'ALL') {
        for (var entry in data) {
          chartData.add(FlSpot(entry['monthStart'].toDouble(), entry['emv']));
        }
      } else if (range == 'YTD') {
        for (var i = 21; i <= 30; i++) {
          chartData.add(FlSpot(i.toDouble(), data[i]['emv']));
        }
      } else if (range == '1Y') {
        for (var i = 18; i <= 30; i++) {
          chartData.add(FlSpot(i.toDouble(), data[i]['emv']));
        }
      }
    });
  }

  @override
 @override
Widget build(BuildContext context) {
  print(' my data is $data');
  return Container(
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Portfolio Balance History",
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 15,
            color: Colors.black,
          ),
        ),
       Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      OutlinedButton(
        onPressed: () => updateChartData('YTD'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0), // Adjust padding to reduce size
          backgroundColor: selectedRange == 'YTD' ? const Color.fromRGBO(16, 58, 117, 1) : Colors.white,
          side: const BorderSide(
            color: Color.fromRGBO(16, 58, 117, 1), // Border color
            width: 2.0, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Optional: to make the button corners rounded
          ),
        ),
        child: Text(
          "YTD",
          style: TextStyle(
            color: selectedRange == 'YTD' ? Colors.white : const Color.fromRGBO(16, 58, 117, 1), // Text color
            fontWeight: FontWeight.bold, // Bold text
            fontSize: 10.0
          ),
        ),
      ),
      const SizedBox(width: 8),
      OutlinedButton(
        onPressed: () => updateChartData('1Y'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0), // Adjust padding to reduce size
          backgroundColor: selectedRange == '1Y' ? const Color.fromRGBO(16, 58, 117, 1) : Colors.white,
          side: const BorderSide(
            color: Color.fromRGBO(16, 58, 117, 1), // Border color
            width: 2.0, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Optional: to make the button corners rounded
          ),
        ),
        child: Text(
          "1Y",
          style: TextStyle(
            color: selectedRange == '1Y' ? Colors.white : const Color.fromRGBO(16, 58, 117, 1), // Text color
            fontWeight: FontWeight.bold, 
            fontSize: 10.0// Bold text
          ),
        ),
      ),
      const SizedBox(width: 8),
      OutlinedButton(
        onPressed: () => updateChartData('ALL'),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0), // Adjust padding to reduce size
          backgroundColor: selectedRange == 'ALL' ? const Color.fromRGBO(16, 58, 117, 1) : Colors.white,
          side: const BorderSide(
            color: Color.fromRGBO(16, 58, 117, 1), // Border color
            width: 2.0, // Border width
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Optional: to make the button corners rounded
          ),
        ),
        child: Text(
          "ALL",
          style: TextStyle(
            color: selectedRange == 'ALL' ? Colors.white : const Color.fromRGBO(16, 58, 117, 1), // Text color
            fontWeight: FontWeight.bold,
            fontSize: 10.0 // Bold text
          ),
        ),
      ),
    ],
  ),
),
Expanded(
  child: Padding(
    padding: const EdgeInsets.only(top: 12.0),
    child: LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: chartData,
            isCurved: false,
            color: const Color.fromRGBO(61, 141, 245, 1.0),
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: const Color.fromRGBO(212, 228, 250, 0.75),
            ),
            dotData: const FlDotData(
              show: false,
            ),
          ),
        ],
        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < data.length) {
                  String currentMonthStart = data[value.toInt()]['monthStart'].toString();
                  String label = data[value.toInt()]['formattedDate'].toString();

                  if (selectedRange == 'ALL') {
                    if (value.toInt() == 0) {
                      return const Text(''); // Skip the first label
                    }
                    if (value.toInt() % 3 != 0) {
                      return const Text(''); // Return an empty Text to skip non-4th labels
                    } else {
                      return Column(
                        children: [
                          const Text("|",style: TextStyle(color:Color(0xFF666666),
                            fontSize: 8.0,)),
                          Text(
                            label,
                            style: const TextStyle(  color: Color(0xFF666666),
                            fontSize: 9.0,),
                          ),
                        ],
                      );
                    }
                  }
                  if (selectedRange == '1Y' || selectedRange == 'YTD') {
                    // Check if the current monthStart is the same as the previous one
                    if (previousMonthStart == currentMonthStart) {
                      return const Text(''); // Return an empty Text to avoid duplication
                    }
                    // Update previousMonthStart to the current one
                    previousMonthStart = currentMonthStart;

                    // Return the current monthStart as Text
                    return Column(
                        children: [
                          const Text("|",style: TextStyle(color:Color(0xFF666666),
                            fontSize: 8.0,)),
                          Text(
                            label,
                            style: const TextStyle(  color: Color(0xFF666666),
                            fontSize: 9.0,),
                          ),
                        ],
                      );
                  }
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              interval: 2.5, // Set the interval size to 2.5
              getTitlesWidget: (value, meta) {
                return Column(
                  children: [
                    Text(
                      '${value.toStringAsFixed(1)}0M', // Append 'M' to the value
                      style: const TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            top: BorderSide(color: Colors.grey, width: 0), // Visible top border
            bottom: BorderSide(color: Colors.transparent, width: 0), // Hide bottom border
            left: BorderSide(color: Colors.transparent, width: 0), // Hide left border
            right: BorderSide(color: Colors.transparent, width: 0), // Hide right border
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return const FlLine(color: Colors.grey, strokeWidth: 0.2); // Make grid lines finer
          },
          getDrawingVerticalLine: (value) {
            return const FlLine(color: Colors.grey, strokeWidth: 0);
          },
        ),
        minX: selectedRange == 'ALL' ? 0 : (selectedRange == 'YTD' ? 21 : 18),
        maxX: selectedRange == 'ALL' ? data.length.toDouble() - 1 : 30,
        minY: 0,
        maxY: 10,
      ),
    ),
  ),
),
      ],
    ),
  );
}

}

