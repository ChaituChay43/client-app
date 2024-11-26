import 'package:flutter/material.dart';


class FinanceSectionCard extends StatelessWidget {
  final String title;
  final String mainValue;
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const FinanceSectionCard({
    super.key,
    required this.title,
    required this.mainValue,
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  mainValue,
                  style: const TextStyle(fontSize: 24.0, color: Color(0xFF077D55), fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label1, style: const TextStyle(fontSize: 14.0)),
                      const SizedBox(height: 4.0),
                      Text(
                        value1,
                        style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label2, style: const TextStyle(fontSize: 14.0)),
                      const SizedBox(height: 4.0),
                      Text(
                        value2,
                        style: const TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  // Handle "See More" action here
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "See More",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 7.0),
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 8.0,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: Colors.white,
                        size: 8.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

