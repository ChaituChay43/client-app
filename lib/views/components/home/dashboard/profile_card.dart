import 'package:amplify/models/other/account_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileCard extends StatelessWidget {
  final Account account;

  const ProfileCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    // Extract account details with fallback values
    final householdAmount =
        NumberFormat('#,##0', 'en_US').format(account.totalBalance);
    String accountName = account.accountName ?? 'N/A';
    String custodian = account.custodian.name ?? 'N/A';
    String accountNumber = account.accountNumber ?? 'N/A';
    String totalBalance = householdAmount.toString();
    String taxStatus = account.taxStatus.name ?? 'N/A';
    String accountType = account.type ?? 'N/A';
    String openDate = account.createdDate != null
        ? '${account.createdDate!.month}/${account.createdDate!.day}/${account.createdDate!.year}'
        : 'N/A';

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
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  accountName.isNotEmpty ? accountName[0] : 'N',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Tooltip(
                  message: accountName,
                  child: Text(
                    accountName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              if (isMobile) {
                // Display properties in a Column for mobile
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      propertyRow('Type', accountType, isMobile),
                      propertyRow('Tax Status', taxStatus, isMobile),
                      propertyRow('APM Avail. Cash', '\$$totalBalance', isMobile),
                      propertyRow('Custodian', custodian, isMobile),
                      propertyRow('Account', accountNumber, isMobile),
                      propertyRow('Open Date', openDate, isMobile),
                    ],
                  ),
                );
              } else {
                // Display properties in a Row and wrap if overflow occurs
                return Wrap(
                  spacing: 20.0,
                  runSpacing: 10.0,
                  children: [
                    propertyRow1('Type', accountType, isMobile),
                    propertyRow1('Tax Status', taxStatus, isMobile),
                    propertyRow1('APM Avail Cash', '\$$totalBalance', isMobile),
                    propertyRow1('Custodian', custodian, isMobile),
                    propertyRow1('Account', accountNumber, isMobile),
                    propertyRow1('Open Date', openDate, isMobile),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget propertyRow(String label, String value, bool isMobile) {
    return Row(
      children: [
        Expanded(
          flex:  1 ,  // Use flex only for mobile devices
          child: Tooltip(
            message: label,
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
          ),
        ),
        const Text(':   '),
        Expanded(
          flex: 1 , // Use flex only for mobile devices
          child: Tooltip(
            message: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }
   Widget propertyRow1(String label, String value, bool isMobile) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold),),
        Text(
          value,
         
        ),
      ],
    );
  }
  
}
