// ignore_for_file: deprecated_member_use

import 'package:amplify/domain/model/oauth_query_params.dart';
import 'package:amplify/views/screens/menus/addepar.dart';
import 'package:flutter/material.dart';
import 'package:pkce/pkce.dart';
import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/views/screens/menus/dashboard_content.dart';
import 'package:amplify/views/screens/menus/household_screen.dart';
import 'package:amplify/views/screens/menus/money_screen.dart';
import 'package:flutter_svg/svg.dart';

class WebUrlLoader extends StatefulWidget {
  final String url;
  final Map<String, String> headers;

  const WebUrlLoader({super.key, required this.url, required this.headers});

  @override
  // ignore: library_private_types_in_public_api
  _WebUrlLoaderState createState() => _WebUrlLoaderState();
}

class _WebUrlLoaderState extends State<WebUrlLoader> {
  @override
  void initState() {
    super.initState();
      _screens = <Widget>[
      HouseholdScreen(),
     const  DashboardContent(),
     const  MoneyContent(),
      Addepar(
        url: widget.url, 
        headers: widget.headers, 
      ),
    ];
  }
 int _selectedIndex = 0;

  late List<Widget> _screens ;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10.0,right:10.0,bottom:10.0),  
        decoration: BoxDecoration(
          color: AppTheme.primaryColor, 
          borderRadius: BorderRadius.circular(30.0), 
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), 
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3), 
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0), 
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: Colors.transparent, 
            elevation: 0, 
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: "",
                tooltip: "HouseHold",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AssetPaths.householdIcon, 
                    height: 30.0,
                    color: _selectedIndex == 0 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
                activeIcon: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    AssetPaths.householdSelectedIcon, 
                    height: 30.0,
                    color: _selectedIndex == 0 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                tooltip: "Dashboard",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AssetPaths.dashboardIcon,
                    height: 30.0,
                    color: _selectedIndex == 1 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
                activeIcon: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    AssetPaths.dashboardIconSelected,
                    height: 30.0,
                    color: _selectedIndex == 1 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: "",
                tooltip: "Money",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AssetPaths.moneyIcon,
                    height: 30.0,
                    color: _selectedIndex == 2 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
                activeIcon: CircleAvatar(
                  radius: 25.0,
                  backgroundColor: Colors.white,
                  child: SvgPicture.asset(
                    AssetPaths.moneyIconSelected,
                    height: 30.0,
                    color: _selectedIndex == 2 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
              ),
               BottomNavigationBarItem(
                label: "",
                tooltip: "Addepar",
                icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.string(
                    '''
<svg class="dn-ns db" style="max-width: 32px;" xmlns="http://www.w3.org/2000/svg" width="20" height="12" fill="none" viewBox="0 0 45 30">
  <path fill="currentColor" d="M19.747.056L.947 30.944H15.67L34.47.056H19.746z"></path>
  <path fill="currentColor" d="M46.744 30.944H32.022L23.197 16.44h14.728l8.82 14.503z"></path>
</svg>

''',
                       color: _selectedIndex == 3 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  )
                ),
                activeIcon: CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  child: SvgPicture.string(
                    ''' 
                    <svg class="dn-ns db" style="max-width: 32px;" xmlns="http://www.w3.org/2000/svg" width="37" height="24" fill="none" viewBox="0 0 45 30 ">
<path fill="currentColor" d="M19.747.056L.947 30.944H15.67L34.47.056H19.746z">
</path><path fill="currentColor" d="M46.744 30.944H32.022L23.197 16.44h14.728l8.82 14.503z"></path></svg>

                    ''',
                   
                    color: _selectedIndex == 3 ? AppTheme.primaryColor : const Color(0xFFC9E7F5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generateUrl() {
    final params = OAuthQueryParams(
      targetName: 'oauth2.authorize',
      responseType: 'code',
      scope: 'session',
      clientId: 'iverson',
      state: '{}',
      codeChallenge: PkcePair.generate().codeChallenge,
      redirectUri: 'https://amppf.addepar.com/oauth2/cb',
      firm: 'amppf',
    );
    var baseUrl = 'https://id.addepar.com/login';
    final continueParam = params.toJson();
    final url = '$baseUrl?continue=$continueParam&firm=${params.firm}';
    return url;
  }
}
