import 'package:amplify/data/providers/screen_index_provider.dart';
import 'package:amplify/views/components/home/dashboard/balance_card.dart';
import 'package:amplify/views/components/home/dashboard/profile_card.dart';
import 'package:amplify/views/components/utilities/account_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  _AccountDetailsState createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ScreenIndexProvider>(
        builder: (context, provider, child) {
          final accounts = provider.accounts;
          final selectedAccount = provider.selectedAccount;
          final isLoading = provider.isLoading; // Track loading state from the provider

          return accounts.isEmpty && selectedAccount == null
              ? const Center(child: Text("Loading accounts..."))
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  if (constraints.maxWidth > 600) {
                                    // Desktop or large screen layout
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (selectedAccount != null && !isLoading)
                                                ProfileCard(account: selectedAccount),
                                              const SizedBox(height: 20),
                                              if (selectedAccount != null && !isLoading)
                                                BalanceCard(account: selectedAccount),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    // Mobile layout
                                    return Column(
                                      children: [
                                        if (selectedAccount != null && !isLoading)
                                          ProfileCard(account: selectedAccount),
                                        const SizedBox(height: 10),
                                        if (selectedAccount != null && !isLoading)
                                          BalanceCard(account: selectedAccount),
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator()), // Show loader when changing accounts
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AccountHeader(
                        accountName: selectedAccount?.accountName ?? '',
                        accountNames: accounts,
                        onItemSelected: (selectedName) => onAccountSelected(selectedName, provider),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void onAccountSelected(String selectedName, ScreenIndexProvider provider) async {
    provider.setLoading(true); // Start loading
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate data fetch
    final foundAccount = provider.accounts.firstWhere(
      (account) => account.accountName == selectedName,
      orElse: () => provider.accounts.first,
    );
    provider.updateSelectedAccountId(foundAccount.id);
    provider.setLoading(false); // Stop loading
  }
}
