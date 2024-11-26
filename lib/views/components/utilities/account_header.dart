import 'package:amplify/data/providers/screen_index_provider.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/views/components/utilities/Dashboard_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountHeader extends StatelessWidget {
  final String accountName;
  final List<Account> accountNames;
  final void Function(String) onItemSelected;

  const AccountHeader({
    super.key,
    required this.accountName,
    required this.accountNames,
    required this.onItemSelected,
  });

  // Method to get a flat list of account names
  List<String> _getAccountNames(List<Account> accounts) {
    return accounts.map((account) => account.accountName).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Create a flat list of account names
    List<String> flatAccountNames = _getAccountNames(accountNames);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: Text(accountName[0]),
          ),
          const SizedBox(width: 10.0),
          // Use Expanded to ensure the account name doesn't overflow and shows ellipses if necessary
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Tooltip(
                    message: accountName, // Show the full account name as a tooltip
                    child: Text(
                      accountName,
                      overflow: TextOverflow.ellipsis, // Apply ellipses for overflow
                      maxLines: 1, // Limit to one line
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.blue),
                onPressed: () {
                  final navigationProvider =
                      Provider.of<ScreenIndexProvider>(context, listen: false);
                  if (navigationProvider.selectedIndex > 0) {
                    navigationProvider.updateIndex(navigationProvider.selectedIndex - 1);
                  }
                },
              ),
              const SizedBox(width: 5.0),
              IconButton(
                icon: const Icon(Icons.arrow_forward, color: Colors.blue),
                onPressed: () {
                  final navigationProvider =
                      Provider.of<ScreenIndexProvider>(context, listen: false);
                  if (navigationProvider.selectedIndex > 0) {
                    navigationProvider.updateIndex(navigationProvider.selectedIndex + 1);
                  }
                },
              ),
            ],
          ),
          DropdownIconButton(
            icon: const Icon(Icons.filter_alt_rounded, color: Colors.blue, size: 25.0),
            items: flatAccountNames, 
            onSelected: onItemSelected,
          ),
        ],
      ),
    );
  }
}
