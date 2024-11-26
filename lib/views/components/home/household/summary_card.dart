import 'package:amplify/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String? totalAmount; // Nullable type
  final bool isExpanded; // Add isExpanded as a parameter

  const SummaryCard({
    super.key,
    required this.title,
    required this.totalAmount,
    required this.isExpanded,  // Ensure isExpanded is passed in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: isExpanded ? Colors.white : AppTheme.primaryColor, // Change color based on isExpanded
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1, // Limit to a single line
            overflow: TextOverflow.ellipsis, // Show ellipses if it exceeds
            style: TextStyle(
              color: isExpanded ?  AppTheme.primaryColor: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10), // Conditional check
          if (totalAmount != null && totalAmount!.isNotEmpty)
          
            Text(
              totalAmount!,
              style: TextStyle(
                color: isExpanded ?  AppTheme.primaryColor: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }
}
