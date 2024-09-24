import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DoughnutChartWithHover extends StatefulWidget {
  @override
  _DoughnutChartWithHoverState createState() => _DoughnutChartWithHoverState();
}

class _DoughnutChartWithHoverState extends State<DoughnutChartWithHover> {
  int _hoveredIndex = -1; // Index of the hovered segment
  final List<double> _values = [48.3, 27.0, 18.1, 6.5];
  final List<String> _labels = ['Domestic Equities', 'International Equities', 'Fixed Income', 'Cash'];
   static const Color darkBlue = Color(0xFF0E3D66);  // #0E3D66
  static const Color mediumBlue = Color(0xFF08548A); // #08548A
  static const Color lightBlue = Color(0xFF1195D6);  // #1195D6
  static const Color green = Color(0xFF43C478); 
    final List<Color> _colors = [darkBlue,green,lightBlue, mediumBlue,];

  @override
  Widget build(BuildContext context) {
    return  Center(
        child: SizedBox(
          width: 250,
          height: 250,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  startDegreeOffset: 270, 
                  centerSpaceRadius: 70,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions || pieTouchResponse == null || pieTouchResponse.touchedSection == null) {
                          _hoveredIndex = -1;
                          return;
                        }
                        _hoveredIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                
                  ),
                  sections: _getSections(),
                ),
              ),
              _hoveredIndex == -1
                  ? Text(
                     ""
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _labels[_hoveredIndex],
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\$${_values[_hoveredIndex].toStringAsFixed(2)}k',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(${_values[_hoveredIndex]}%)',
                          style: TextStyle(fontSize: 8, color: Colors.grey),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      );
  }

  // Function to generate pie chart sections with hover effects
  List<PieChartSectionData> _getSections() {
    return List.generate(_values.length, (i) {
      final isHovered = i == _hoveredIndex;
      final radius = isHovered ? 60.0 : 50.0;

      return PieChartSectionData(
        color: _colors[i].withOpacity(isHovered ? 1 : 1), // Disabled color effect
        value: _values[i],
        radius: radius,
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: _colors[i],
        ),
        badgeWidget: isHovered
            ? Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _colors[i],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _colors[i].withOpacity(0.3), // Add shadow on hover
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              )
            : null,
      );
    });
  }
}


