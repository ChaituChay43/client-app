import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/models/other/account_data.dart';
import 'package:amplify/models/other/balance_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class BalanceCard extends StatelessWidget {
  final Account account;

  const BalanceCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
     final HouseholdAmount=formatNumberWithCommas(account.totalBalance);
    final String totalBalance = HouseholdAmount;
    final BalanceDetails today = account.today;
    final BalanceDetails mtd = account.mtd;
    final BalanceDetails qtd = account.qtd;
    final BalanceDetails tyd = account.ytd;

     final todayValue=formatNumberWithCommas(today.value);
      final mtdValue=formatNumberWithCommas(mtd.value);
       final qtdValue=formatNumberWithCommas(qtd.value);
    final tydValue=formatNumberWithCommas(tyd.value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
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
              const Text(
                'Total Balance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  SvgPicture.asset(AssetPaths.accountDetailsMoney),
                  const SizedBox(width: 10.0),
                  Text(
                    '\$$totalBalance',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
              
                child: balanceCard('Today', '\$$todayValue', '${(today.percentage * 100).toStringAsFixed(2)}%'),
    
              ),
            ),
            SizedBox(width: 8.0,),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: balanceCard('MTD', '\$$mtdValue', '${(mtd.percentage * 100).toStringAsFixed(2)}%'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                   padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: balanceCard('QTD', '\$$qtdValue', '${(qtd.percentage * 100).toStringAsFixed(2)}%'),
              ),
            ),
             SizedBox(width: 8.0,),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: balanceCard('YTD', '\$$tydValue', '${(tyd.percentage * 100).toStringAsFixed(2)}%'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget balanceCard(String title, String amount, String percentage) {
    return Container(
      width: 150.0,
      padding: const EdgeInsets.all(10),
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
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                amount,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10.0),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color(0xFFEBF7ED),
                ),
                child: Text(
                  percentage,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF077D55),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
String formatNumberWithCommas(value) {
  return NumberFormat('#,##0', 'en_US').format(value);
}