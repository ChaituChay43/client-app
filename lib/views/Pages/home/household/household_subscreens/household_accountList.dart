import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/views/components/home/household/account_card_widget.dart';
import 'package:amplify/data/providers/screen_index_provider.dart';

class AccountList extends StatelessWidget {
  final List<Account> accounts;

  const AccountList({super.key, required this.accounts});

  @override
  Widget build(BuildContext context) {
    // Get the selected accountId from the provider
    final selectedAccountId = Provider.of<ScreenIndexProvider>(context).selectedAccount?.id;

    if (accounts.isEmpty) {
      return const Center(child: Text('No accounts available.'));
    }

    return Column(
      children: accounts.map((account) {
        // Check if this account is selected
        bool isSelected = account.id == selectedAccountId;
         final HouseholdAmount=NumberFormat('#,##0', 'en_US').format(account.totalBalance);

        return Column(
          children: [
            AccountCard(
              accountId: account.id,
              title: account.accountName,
              subtitle: account.custodian.name,
              amount: HouseholdAmount.toString(),
              onTap: (id) {
                final navigationProvider = Provider.of<ScreenIndexProvider>(context, listen: false);
                navigationProvider.updateSelectedAccountId(id);
                navigationProvider.updateIndex(1);
              },
              // Pass the selection state to the AccountCard
              isSelected: isSelected, // Highlight if selected
            ),
            const Divider(
              endIndent: 20.0,
              thickness: 1.0,
              indent: 20.0,
            ),
          ],
        );
      }).toList(),
    );
  }
}
