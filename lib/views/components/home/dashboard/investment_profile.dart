import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InvestmentProfileItem extends StatelessWidget {
  final String label;
  final double value;
  final Color circleColor;
  final String svgData;

  const InvestmentProfileItem({super.key, 
    required this.label,
    required this.value,
    required this.circleColor,
    required this.svgData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label),
            const SizedBox(width: 100.0),
            CircleAvatar(
              maxRadius: 15.0,
              backgroundColor: circleColor,
              child: Text(
                value.toStringAsFixed(2),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: SvgPicture.string(svgData),
          ),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }
}
