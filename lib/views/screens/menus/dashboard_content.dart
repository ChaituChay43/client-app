import 'dart:ui';
import 'package:amplify/views/components/Dashboard_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Tablet or Desktop layout
            return _getHomeContent(
              context,
              constraints,
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: 4,
                mainAxisExtent: 100,
                crossAxisCount: 3,
              ),
            );
          } else {
            // Mobile layout
            return _getHomeContent(
              context,
              constraints,
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 10,
                mainAxisSpacing: 0,
                childAspectRatio: 1,
                mainAxisExtent: 100,
                crossAxisCount: 1,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _getHomeContent(
      BuildContext context, BoxConstraints constraints, sliverGridDelegate) {
    return SingleChildScrollView(
      child: Padding(
        
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Information Section
             Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Container(
            padding:const  EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
              
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Banner Bruce & Romanoff, Natasha',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                  Container(
                    child: CircleAvatar(
                      child: DropdownIconButton(
                          icon: Icon(Icons.filter_alt_rounded,color:Colors.white,size: 25.0,),  
                          items: ["Rocky Balboa", "Balboa Adrian", "Michael", "Sophia"],  
                          onSelected: (String selected) {
                            print("You selected: $selected");
                          },
                        ),
                      backgroundColor: Colors.blue, 
                      maxRadius: 20.0,

                    ),
                  ),
              ],
            ),
          ),
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                 LayoutBuilder(
                      builder: (context, constraints) {
                        bool isWideScreen = constraints.maxWidth > 450; // Adjust threshold as needed

                        return isWideScreen
                            ?Row(
                  
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text('Phone', ),
                                  const SizedBox(width: 10.0,),
                                  const Text('(819) 918-1004' ,style: TextStyle(fontWeight:FontWeight.bold),),
                                  const SizedBox(width: 10.0,),
                                  GestureDetector(
                                    onTap: () {
                                      // Add phone call logic here
                                    },
                                    child: CircleAvatar(child: const Icon(Icons.phone_in_talk_outlined, color: Colors.white, size: 10.0,),  backgroundColor: Colors.blue, maxRadius: 10.0,),
                                  ),
                                ],
                              ),
                                                
                              Row(
                                children: [
                                  const Text('Security Token', ),
                                  const SizedBox(width: 110.0,),
                                
                                ],
                              ),
                                                
                            ],
                          ):
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Row(
                                children: [
                                  const Text('Phone', ),
                                  const SizedBox(width: 10.0,),
                                  const Text('(819) 918-1004' ,style: TextStyle(fontWeight:FontWeight.bold),),
                                  const SizedBox(width: 10.0,),
                                  GestureDetector(
                                    onTap: () {
                                      // Add phone call logic here
                                    },
                                    child: CircleAvatar(child: const Icon(Icons.phone_in_talk_outlined, color: Colors.white, size: 10.0,),  backgroundColor: Colors.blue, maxRadius: 10.0,),
                                  ),
                                ],
                              ),
                              SizedBox(height:10.0),               
                             Row(
                                children: [
                                  const Text('Security Token', ),
                                  const SizedBox(width: 10.0,),
                                  const Text('' ,style: TextStyle(fontWeight:FontWeight.bold),),
                                  const SizedBox(width: 10.0,),
                                  GestureDetector(
                                    onTap: () {
                                      // Add phone call logic here
                                    },
                                    child: CircleAvatar(child: const Icon(Icons.security, color: Colors.white, size: 10.0,),  backgroundColor: Colors.blue, maxRadius: 10.0,),
                                  ),
                                ],
                              ),
                                
                            ],
                          );
                          }
                          ),
                const SizedBox(height: 30.0,),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        bool isWideScreen = constraints.maxWidth > 450; // Adjust threshold as needed

                        return isWideScreen
                            ?Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Row(
                      children: [
                        const Text('Email',),
                         const SizedBox(width: 10.0,),
                       
                        const Text(
                          'rhodyno@amppf...',
                           style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                       
                         const SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: () {
                            // Add email logic here
                          },
                          child: CircleAvatar(child: const Icon(Icons.email, color: Colors.white,size: 10.0,),backgroundColor: Colors.blue, maxRadius: 10.0,),
                        ),
                      ],
                    ),
                                       
                    const Row(
                      children: [
                        Text('Client Since', ),
                         SizedBox(width: 10.0,),
                        Text(
                          '10/8/2023',
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                         SizedBox(width: 10.0,),
                       Text('(0 years)',style: TextStyle(fontSize: 10.0,fontWeight:FontWeight.bold),),
                      
                      ],
                    ),
                  
                        
                                         
                  ],
                ):
                Column(
                  children: [
                      Row(
                      children: [
                        const Text('Email',),
                         const SizedBox(width: 10.0,),
                       
                        const Text(
                          'rhodyno@amppf...',
                           style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                       
                         const SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: () {
                            // Add email logic here
                          },
                          child: const CircleAvatar(child: Icon(Icons.email, color: Colors.white,size: 10.0,),backgroundColor: Colors.blue, maxRadius: 10.0,),
                        ),
                      ],
                    ),
                    SizedBox(height:10.0),                 
                    const Row(
                      children: [
                        Text('Client Since', ),
                         SizedBox(width: 10.0,),
                        Text(
                          '10/8/2023',
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                         SizedBox(width: 10.0,),
                       Text('(0 years)',style: TextStyle(fontSize: 10.0,fontWeight:FontWeight.bold),),
                      
                      ],
                    ),
                  
                        
                                         
                  ],
                );}),
                SizedBox(height: 10.0,),
                 const Divider(
                endIndent: 2.0 ,
                thickness: 1.0,
                indent: 2.0,
              ),
               SizedBox(height: 10.0,),
                Container(
                  padding: EdgeInsets.only(left: 20.0,bottom: 20.0),   
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Align(
                        alignment: Alignment.topRight,
                       child: IconButton(
                            icon: Icon(Icons.notifications),  
                            color: const Color.fromARGB(255, 240, 4, 4),           
                            iconSize: 20.0,              
                            onPressed: () {              
                            },
                          )
                      ),
                      Text('Investment Profile'),
                      LayoutBuilder(
                      builder: (context, constraints) {
                        bool isWideScreen = constraints.maxWidth > 650; // Adjust threshold as needed

                        return isWideScreen
                            ?Row(
                                                    children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                                  Text('Capital Appreciation'),
                                                                  SizedBox(width: 100.0),
                                                                  CircleAvatar(child: Text('97',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),maxRadius: 15.0,backgroundColor: Colors.red,),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20.0,),
                                                          Container(
                                                                child: SvgPicture.string(
                                                                      '''
                                                              <svg viewBox="0 0 250 9" xmlns="http://www.w3.org/2000/svg" width="225" height="9">
                                                                <rect width="33" height="9" x="0" fill="#16A163" tabindex="0" />
                                                                <rect width="33" height="9" x="41.6" fill="#43C478" tabindex="0" />
                                                                <rect width="33" height="9" x="83.2" fill="#88DBA8" tabindex="0" />
                                                                <rect width="33" height="9" x="124.8" fill="#FC9162" tabindex="0" />
                                                                <rect width="33" height="9" x="166.4" fill="#E86427" tabindex="0" />
                                                                <rect width="33" height="9" x="208" fill="#FA5343" tabindex="0" />
                                                              </svg>        
                                                              
                                                                    ''',
                                                                    
                                                                    ),
                                                              ),
                                                      ],
                                                    ),
                                                    SizedBox(width:50.0),
                                                   Column(
                                                     children: [
                                                       Row(
                                                          children: [
                                                                      Text('Growth'),
                                                                      SizedBox(width: 180.0),
                                                                      CircleAvatar(child: Text('63',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),maxRadius: 15.0,backgroundColor:  Color(0xFFE86427),),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20.0,),
                                                       Container(
                                                                child: SvgPicture.string(
                                                                      '''
                                                              <svg viewBox="0 0 250 9" xmlns="http://www.w3.org/2000/svg" width="225" height="9">
                                                                <rect width="33" height="9" x="0" fill="#16A163" tabindex="0" />
                                                                <rect width="33" height="9" x="41.6" fill="#43C478" tabindex="0" />
                                                                <rect width="33" height="9" x="83.2" fill="#88DBA8" tabindex="0" />
                                                                <rect width="33" height="9" x="124.8" fill="#FC9162" tabindex="0" />
                                                                <rect width="33" height="9" x="166.4" fill="#E86427" tabindex="0" />
                                                                <rect width="33" height="9" x="208" fill="#FA5343" tabindex="0" />
                                                              </svg>        
                                                              
                                                                    ''',
                                                                    
                                                                    ),
                                                              ),
                                                     ],
                                                   ),
                                                    
                                                  ]):
                      Column( children: [
                        Column(
  crossAxisAlignment: CrossAxisAlignment.start,  // Aligns all children to the start (left)
  children: [
    const Row(
      children: [
        Text('Capital Appreciation'),
        SizedBox(width: 100.0),
        CircleAvatar(
          maxRadius: 15.0,
          backgroundColor: Colors.red,
          child: Text(
            '97',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    const SizedBox(height: 20.0),
    Align(
      alignment: Alignment.centerLeft, // Aligns the SVG to the left
      child: Container(
        child: SvgPicture.string(
          '''
            <svg viewBox="0 0 250 9" xmlns="http://www.w3.org/2000/svg" width="225" height="9">
              <rect width="33" height="9" x="0" fill="#16A163" tabindex="0" />
              <rect width="33" height="9" x="41.6" fill="#43C478" tabindex="0" />
              <rect width="33" height="9" x="83.2" fill="#88DBA8" tabindex="0" />
              <rect width="33" height="9" x="124.8" fill="#FC9162" tabindex="0" />
              <rect width="33" height="9" x="166.4" fill="#E86427" tabindex="0" />
              <rect width="33" height="9" x="208" fill="#FA5343" tabindex="0" />
            </svg>  
          ''',
        ),
      ),
    ),
    SizedBox(height:15.0)
  ],
),

                               
                       Column(
                         children: [
                           const Row(
                              children: [
                                Text('Growth'),
                                SizedBox(width: 185.0),
                                CircleAvatar(child: Text('63',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),maxRadius: 15.0,backgroundColor:  Color(0xFFE86427),),
                              ],
                            ),
                            const SizedBox(height: 20.0,),
                             Align(
                              alignment: Alignment.centerLeft, // Aligns the SVG to the left
                              child: Container(
                                child: SvgPicture.string(
                                  '''
                                    <svg viewBox="0 0 250 9" xmlns="http://www.w3.org/2000/svg" width="225" height="9">
                                      <rect width="33" height="9" x="0" fill="#16A163" tabindex="0" />
                                      <rect width="33" height="9" x="41.6" fill="#43C478" tabindex="0" />
                                      <rect width="33" height="9" x="83.2" fill="#88DBA8" tabindex="0" />
                                      <rect width="33" height="9" x="124.8" fill="#FC9162" tabindex="0" />
                                      <rect width="33" height="9" x="166.4" fill="#E86427" tabindex="0" />
                                      <rect width="33" height="9" x="208" fill="#FA5343" tabindex="0" />
                                    </svg>  
                                  ''',
                                ),
                              ),
                            ),
                         ],
                       ),
                        
                      ]);
      }),
              ]),
                )
             
              ],
            ),
          ),
          
         
        ],
      ),
    ),
            const SizedBox(height: 16.0),
            // Other Cards Row
    Container(
  child: LayoutBuilder(
    builder: (context, constraints) {
      bool isWideScreen = constraints.maxWidth > 700; // Adjust threshold as needed

      return isWideScreen
          ? const IntrinsicHeight(
              child: Row(
                children: [
                  // Total Net Worth Section
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Net Worth', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                Text('\$11,098,851.73', style: TextStyle(fontSize: 24.0, color: Color(0xFF077D55), fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Assets', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$11,098,851.73', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Liabilities', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$0.00', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Income & Expenses Section
                  Expanded(
                    child: Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Income & Expenses', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                Text('\$666,666.67', style: TextStyle(fontSize: 24.0, color: Color(0xFF077D55), fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Monthly Income', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$666,666.67', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Monthly Expenses', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$5,000.00', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Net Worth', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                              Text('\$11,098,851.73', style: TextStyle(fontSize: 24.0, color: Color(0xFF077D55), fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Assets', style: TextStyle(fontSize: 14.0)),
                                    SizedBox(height: 4.0),
                                    Text('\$11,098,851.73', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Liabilities', style: TextStyle(fontSize: 14.0)),
                                    SizedBox(height: 4.0),
                                    Text('\$0.00', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                      elevation: 4.0,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Income & Expenses', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                Text('\$666,666.67', style: TextStyle(fontSize: 24.0, color: Color(0xFF077D55), fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Monthly Income', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$666,666.67', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Monthly Expenses', style: TextStyle(fontSize: 14.0)),
                                      SizedBox(height: 4.0),
                                      Text('\$5,000.00', style: TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
    },
  ),
)


          ],
        ),
      ),
    );
  }
}


