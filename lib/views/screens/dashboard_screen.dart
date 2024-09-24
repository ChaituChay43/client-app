import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/views/components/app_bar.dart';
import 'package:amplify/views/components/left_menu.dart';
import 'package:amplify/views/screens/base_screen.dart';
import 'package:amplify/views/screens/menus/home_screen.dart';
import 'package:amplify/views/screens/menus/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';

class DashboardScreen extends BaseScreen {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ValueNotifier<MenuItem> _selectedMenuItem =
      ValueNotifier(MenuItem.home);

  DashboardScreen({super.key});

  @override
  bool sessionCheckReq(BuildContext context) {
    return true;
  }

  @override
  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    return ValueListenableBuilder(
      valueListenable: _selectedMenuItem,
      builder: (BuildContext context, MenuItem value, Widget? child) {
        return Scaffold(
          key: _scaffoldKey,
          body: Row(children: [
            LeftMenu(
              isFOrMobile: false,
              selectedMenu: _selectedMenuItem.value,
              onMenuClick: (menuItem) {
                _selectedMenuItem.value = menuItem;
              },
            ),
            Expanded(child: _homeBody(context, constraints))
          ]),
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
            isFOrMobile: true,
            selectedMenu: _selectedMenuItem.value,
            onMenuClick: (menuItem) {
              _scaffoldKey.currentState?.closeDrawer();
              _selectedMenuItem.value = menuItem;
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
        _doLogout(context);
        return Container();
    }
  }

  void _doLogout(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(LoggedOut());
  }
}



