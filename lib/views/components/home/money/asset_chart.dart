import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DoughnutChartWithHover extends StatefulWidget {
  final List<double> values; // Data values for the chart
  final List<String> labels; // Labels for the chart
  final List<Color> colors; // Colors for the chart segments

  const DoughnutChartWithHover({
    super.key,
    required this.values,
    required this.labels,
    required this.colors,
  });

  @override
  _DoughnutChartWithHoverState createState() => _DoughnutChartWithHoverState();
}

class _DoughnutChartWithHoverState extends State<DoughnutChartWithHover> {
  int _hoveredIndex = -1; // Index of the hovered segment

  @override
  Widget build(BuildContext context) {
    return Center(
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
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        _hoveredIndex = -1;
                        return;
                      }
                      _hoveredIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                sections: _getSections(),
              ),
            ),
            _hoveredIndex == -1
                ? const Text("")
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.labels[_hoveredIndex],
                        style: const TextStyle(
                            fontSize: 9, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$${widget.values[_hoveredIndex].toStringAsFixed(2)}k',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${widget.values[_hoveredIndex]}%)',
                        style: const TextStyle(
                            fontSize: 8, color: Colors.grey),
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
    return List.generate(widget.values.length, (i) {
      final isHovered = i == _hoveredIndex;
      final radius = isHovered ? 60.0 : 50.0;
      final minimumValue = widget.values[i] < 2.0 ? 2.0 : widget.values[i]; // Ensure minimum section size

      return PieChartSectionData(
        color: widget.colors[i].withOpacity(isHovered ? 1 : 1),
        value: minimumValue, // Apply the minimum size threshold for small values
        radius: radius,
        title: '', // Remove titles from sections
        titleStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: widget.colors[i],
        ),
        badgeWidget: isHovered
            ? Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: widget.colors[i],
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.colors[i].withOpacity(0.3), // Add shadow on hover
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
