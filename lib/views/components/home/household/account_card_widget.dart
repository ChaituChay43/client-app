import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String accountId;
  final String title;
  final String subtitle;
  final String amount;
  final Function(String) onTap;
  final bool isSelected; // New property to check if selected

  const AccountCard({
    super.key,
    required this.accountId,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.onTap,
    required this.isSelected, // New property
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Material(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white, 
        borderRadius: BorderRadius.circular(15.0),
        child: InkWell(
          onTap: () => onTap(accountId),
          borderRadius: BorderRadius.circular(15.0),
          splashColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.grey.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(15.0),
            width: double.infinity, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isWideScreen = constraints.maxWidth > 400;
      
                return isWideScreen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start, 
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, 
                              children: [
                                Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 5, 5, 5),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  subtitle,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '\$$amount',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 5, 5, 5),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '\$$amount',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 5, 5, 5),
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
