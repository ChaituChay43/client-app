import 'package:amplify/views/components/home/money/asset_chart.dart';
import 'package:flutter/material.dart';

class ChartContainer extends StatelessWidget {
  final ChartData chartData;

  const ChartContainer({Key? key, required this.chartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: Column(
        children: [
          DoughnutChartWithHover(
            values: chartData.chartValues,
            labels: chartData.chartLabels,
            colors: chartData.chartColors,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  List<double> chartValues;
  List<String> chartLabels;
  List<Color> chartColors;

  ChartData({
    required this.chartValues,
    required this.chartLabels,
    required this.chartColors,
  });
}