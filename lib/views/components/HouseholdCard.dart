import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback onTap;

  const AccountCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Material( // Material widget to provide a surface for ripple effect
        color: Colors.white, // Ensure Material has a visible background color
        borderRadius: BorderRadius.circular(15.0), // Apply border radius to Material
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0), // Ensure the ripple respects the rounded corners
          splashColor: Colors.grey.withOpacity(0.1), // Customize ripple color
          highlightColor: Colors.grey.withOpacity(0.1), // Customize highlight color
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0), // Border radius for container
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 400;

                return isWideScreen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            amount,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                subtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            amount,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
