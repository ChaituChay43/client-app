import 'package:amplify/models/other/account_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileCard extends StatelessWidget {
  final Account account;

  const ProfileCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    // Extract account details with fallback values
     final HouseholdAmount=NumberFormat('#,##0', 'en_US').format(account.totalBalance);
    String accountName = account.accountName ?? 'N/A';
    String custodian = account.custodian.name ?? 'N/A';
    String accountNumber = account.accountNumber ?? 'N/A';
    String totalBalance = HouseholdAmount.toString() ?? 'N/A';
    String taxStatus = account.taxStatus.name ?? 'N/A';
    String accountType = account.type ?? 'N/A'; // Dynamic account type
    String openDate = account.createdDate != null
        ? '${account.createdDate!.month}/${account.createdDate!.day}/${account.createdDate!.year}'
        : 'N/A'; // Format the createdDate

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  accountName.isNotEmpty ? accountName[0] : 'N', // First letter of the account name
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              // Tooltip with ellipses for account name
              Expanded(
                child: Tooltip(
                  message: accountName, // Show full account name as tooltip
                  child: Text(
                    accountName,
                    overflow: TextOverflow.ellipsis, // Add ellipses when overflow occurs
                    maxLines: 1, // Limit to one line
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 50,
            runSpacing: 10,
            children: [
              propertyRow('Type', accountType), // Dynamic account type
              propertyRow('Tax Status', taxStatus),
              propertyRow('APM Avail. Cash', '\$$totalBalance'),
              propertyRow('Custodian', custodian),
              propertyRow('Account', accountNumber),
              propertyRow('Open Date', openDate), // Display created date here
            ],
          ),
        ],
      ),
    );
  }

  Widget propertyRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: '),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
