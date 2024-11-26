import 'package:amplify/data/providers/screen_index_provider.dart';
import 'package:amplify/models/request/oauth_query_params.dart';
import 'package:amplify/views/Pages/home/dashbord/account_details.dart';
import 'package:amplify/views/Pages/home/addaper/addepar.dart';
import 'package:amplify/views/Pages/home/household/household_screen.dart';
import 'package:amplify/views/Pages/home/money/money_screen.dart';
import 'package:amplify/views/components/platform/mobile_url_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pkce/pkce.dart';
import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';

class WebUrlLoader extends StatefulWidget {
  final String url;
  final Map<String, String> headers;

  const WebUrlLoader({super.key, required this.url, required this.headers});

  @override
  _WebUrlLoaderState createState() => _WebUrlLoaderState();
}

class _WebUrlLoaderState extends State<WebUrlLoader> {
 Widget getScreen(BuildContext context, int index) {
  // Debugging prints
  print('Selected Index: $index');
  print('widget.url: ${widget.url}');
  print('widget.headers: ${widget.headers}');

  // Ensure the index is within valid bounds (0 to 3)
  if (index < 0 || index > 3) {
    index = 0;  // Default to the first screen (HouseholdScreen) if out of bounds
  }

  switch (index) {
    case 0:
      return const HouseholdScreen();
    case 1:
      return const AccountDetails();
    case 2:
      // Ensure MoneyContent isn't receiving an unexpected null or bad value
      return const MoneyContent(); 
    case 3:
    default:
      // Ensure Addepar and MobileUrlLoader handle null values for URL and headers gracefully
      return kIsWeb
          ? Addepar(url: widget.url.isNotEmpty ? widget.url : 'https://default.url', 
                    headers: widget.headers.isNotEmpty ? widget.headers : {})
          : MobileUrlLoader(url: widget.url.isNotEmpty ? widget.url : 'https://default.url', 
                            headers: widget.headers.isNotEmpty ? widget.headers : {});
  }
}

  @override
  Widget build(BuildContext context) {
    // Access the current index from the NavigationProvider
    final navigationProvider = Provider.of<ScreenIndexProvider>(context);

    // Check if navigationProvider.selectedIndex is null or invalid
    final selectedIndex = navigationProvider.selectedIndex ?? 0;  // Default to 0 if null

    print('NavigationProvider selectedIndex: $selectedIndex'); // Debugging print

    return Scaffold(
      body: getScreen(context, selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(context, navigationProvider),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, ScreenIndexProvider navigationProvider) {
    return Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
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
          currentIndex: navigationProvider.selectedIndex ?? 0,  // Default to 0 if null
          onTap: (index) {
            if (index >= 0 && index <= 3) {
              navigationProvider.updateIndex(index); // Update selected index using the provider
            } else {
              navigationProvider.updateIndex(0); // Default to first screen if out of bounds
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: "",
              tooltip: "Household",
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AssetPaths.householdIcon,
                  height: 30.0,
                  color: navigationProvider.selectedIndex == 0
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
                ),
              ),
              activeIcon: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  AssetPaths.householdSelectedIcon,
                  height: 30.0,
                  color: navigationProvider.selectedIndex == 0
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
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
                  color: navigationProvider.selectedIndex == 1
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
                ),
              ),
              activeIcon: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  AssetPaths.dashboardIconSelected,
                  height: 30.0,
                  color: navigationProvider.selectedIndex == 1
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
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
                  color: navigationProvider.selectedIndex == 2
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
                ),
              ),
              activeIcon: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  AssetPaths.moneyIconSelected,
                  height: 30.0,
                  color: navigationProvider.selectedIndex == 2
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
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
                  color: navigationProvider.selectedIndex == 3
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
                ),
              ),
              activeIcon: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: SvgPicture.string(
                  '''
                  <svg class="dn-ns db" style="max-width: 32px;" xmlns="http://www.w3.org/2000/svg" width="37" height="24" fill="none" viewBox="0 0 45 30">
                    <path fill="currentColor" d="M19.747.056L.947 30.944H15.67L34.47.056H19.746z"></path>
                    <path fill="currentColor" d="M46.744 30.944H32.022L23.197 16.44h14.728l8.82 14.503z"></path>
                  </svg>
                  ''',
                  color: navigationProvider.selectedIndex == 3
                      ? AppTheme.primaryColor
                      : const Color(0xFFC9E7F5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
