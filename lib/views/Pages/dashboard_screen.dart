import 'package:amplify/views/components/platform/app_bar.dart';
import 'package:amplify/views/components/sidemenu/left_menu.dart';
import 'package:amplify/views/Pages/base_screen.dart';
import 'package:amplify/views/Pages/home/home_screen.dart';
import 'package:amplify/views/Pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends BaseScreen {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<MenuItem> _selectedMenuItem = ValueNotifier(MenuItem.home);

  DashboardScreen({super.key});

  @override
  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    return ValueListenableBuilder(
      valueListenable: _selectedMenuItem,
      builder: (BuildContext context, MenuItem value, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          body: Row(
            children: [
              LeftMenu(
                isForMobile: false, // Correct parameter name
                selectedMenu: _selectedMenuItem.value,
                onMenuClick: (menuItem) {
                  _handleMenuClick(context, menuItem);
                },
              ),
              Expanded(child: _homeBody(context, constraints)),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget getMobileBody(BuildContext context, BoxConstraints constraints) {
    return ValueListenableBuilder(
      valueListenable: _selectedMenuItem,
      builder: (BuildContext context, MenuItem value, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          drawer: LeftMenu(
            isForMobile: true, // Correct parameter name
            selectedMenu: _selectedMenuItem.value,
            onMenuClick: (menuItem) {
              _scaffoldKey.currentState?.closeDrawer();
              _handleMenuClick(context, menuItem);
            },
          ),
          appBar: AmplifyAppBar().getAppBar(
            context: context,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          body: _homeBody(context, constraints),
        );
      },
    );
  }

  Widget _homeBody(BuildContext context, BoxConstraints constraints) {
    return _getMenuScreen(context);
  }

  Widget _getMenuScreen(BuildContext context) {
    switch (_selectedMenuItem.value) {
      case MenuItem.home:
        return const HomeScreen();
      case MenuItem.profile:
        return const ProfileScreen();
      case MenuItem.logout:
        return const HomeScreen(); // Redirect to Home or handle logout
    }
  }

  void _handleMenuClick(BuildContext context, MenuItem menuItem) {
    if (menuItem == MenuItem.logout) {
      _doLogout(context);
    } else {
      _selectedMenuItem.value = menuItem; // Update the selected menu item
    }
  }

  void _doLogout(BuildContext context) {
    // Add your logout logic here (e.g., clearing tokens, notifying the server, etc.)
    // Then navigate to the login screen
    Navigator.of(context).pushReplacementNamed('/login'); // Ensure this route is defined
  }
}
