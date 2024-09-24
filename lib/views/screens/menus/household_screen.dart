import 'package:amplify/views/components/HouseholdCard.dart';
import 'package:flutter/material.dart';

class HouseholdScreen extends StatelessWidget {
  final List<Map<String, String>> accountDetails = [
    {
      "title": "Rocky Balboa - Indiv",
      "subtitle": "Manual Account, Indiv, 9004141M",
      "amount": "\$537,200.00"
    },
    {
      "title": "Rocky Balboa - SEP",
      "subtitle": "Manual Account, SEP, 069960M",
      "amount": "\$284,830.00"
    },
    {
      "title": "Rocky Balboa - IRA ROTH",
      "subtitle": "Manual Account, IRA ROTH, 002200M",
      "amount": "\$150,000.00"
    },
    {
      "title": "Rocky Balboa - Checking",
      "subtitle": "Manual Account, Checking, 002301M",
      "amount": "\$50,000.00"
    },
    {
      "title": "Rocky Balboa - Savings",
      "subtitle": "Manual Account, Savings, 002401M",
      "amount": "\$75,000.00"
    },
    {
      "title": "Rocky Balboa - Brokerage",
      "subtitle": "Manual Account, Brokerage, 002501M",
      "amount": "\$125,000.00"
    },
    {
      "title": "Rocky Balboa - 401k",
      "subtitle": "Manual Account, 401k, 002601M",
      "amount": "\$175,000.00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        margin: EdgeInsets.all(10.0),
         decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                   
            ),  boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              offset: Offset(0, 4), // X and Y offset of the shadow
              blurRadius: 4.0, // How much the shadow is blurred
              spreadRadius: 1.0, // How much the shadow spreads
            ),
          ],color: Colors.white,),
      
        child: Column(
          children: [
            // Summary card (not scrollable)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                   
            ),  color: Color(0xFF08548A),),
               
              
            
           
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Accounts Summary",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "\$972,030.00",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Scrollable area containing account cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: accountDetails.asMap().entries.map((entry) {
                    int index = entry.key;
                    var account = entry.value;
        
                    return Column(
                      children: [
                        AccountCard(
                          title: account["title"]!,
                          subtitle: account["subtitle"]!,
                          amount: account["amount"]!,
                          onTap: () {
                            print("${account["title"]} tapped");
                          },
                        ),
                        if (index < accountDetails.length - 1) 
                          const Divider(
                            endIndent: 20.0,
                            thickness: 1.0,
                            indent: 20.0,
                          ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
