import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/route/route.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/views/components/platform/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LeftMenu extends StatelessWidget {
  final bool isForMobile; // Correct parameter name
  final MenuItem selectedMenu;
  final Function(MenuItem) onMenuClick;

  const LeftMenu({
    super.key,
    required this.isForMobile,
    this.selectedMenu = MenuItem.home,
    required this.onMenuClick,
  });

  @override
  Widget build(BuildContext context) {
    return isForMobile
        ? Drawer(
            backgroundColor: const Color(0xFF08548A),
            child: _mainDrawerView(context),
          )
        : Container(
            color: const Color(0xFF08548A),
            width: 280,
            child: _mainDrawerView(context),
          );
  }

  Widget _buildListTile(BuildContext context, MenuData menuData) {
    ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: selectedMenu == menuData.menuItem
          ? BoxDecoration(
              color: isDarkMode ? Colors.white.withAlpha(50) : Colors.white,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ],
            )
          : null,
      child: _itemListTile(context, menuData),
    );
  }

  Widget _mainDrawerView(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            children: _getLeftMenuData(context),
          ),
        ),
        // ThemeToggleSwitch(), // Uncomment if you have a theme toggle
      ],
    );
  }

  List<Widget> _getLeftMenuData(BuildContext context) {
    List<Widget> listItems = [];
    listItems.add(const Padding(
      padding: EdgeInsets.all(16.0),
      child: DrawerHeader(
        child: AppLogoWidget(),
      ),
    ));

    for (var element in MenuItem.values) {
      listItems.add(_buildListTile(context, _getMenuData(element)));
    }
    return listItems;
  }

  MenuData _getMenuData(MenuItem element) {
    switch (element) {
      case MenuItem.home:
        return MenuData(
          iconPath: AssetPaths.homeIcon,
          selectedIconPath: AssetPaths.homeIconSelected,
          name: AppStrings.home,
          menuItem: element,
        );
      case MenuItem.profile:
        return MenuData(
          selectedIconPath: AssetPaths.profileIconSelected,
          iconPath: AssetPaths.profileIcon,
          name: AppStrings.profile,
          menuItem: element,
        );
      case MenuItem.logout:
        return MenuData(
          selectedIconPath: AssetPaths.logoutIcon,
          iconPath: AssetPaths.logoutIcon,
          name: AppStrings.logout,
          menuItem: element,
        );
    }
  }

  Widget _itemListTile(BuildContext context, MenuData menuData) {
    final theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: SvgPicture.asset(
          selectedMenu == menuData.menuItem
              ? menuData.selectedIconPath
              : menuData.iconPath,
          colorFilter: ColorFilter.mode(
            (selectedMenu == menuData.menuItem && !isDarkMode)
                ? AppTheme.primaryColor
                : theme.iconTheme.color!,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          menuData.name,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: selectedMenu == menuData.menuItem
                ? FontWeight.bold
                : FontWeight.normal,
            color: (selectedMenu == menuData.menuItem && !isDarkMode)
                ? const Color(0xFF08548A)
                : const Color(0xFFC9E7F5),
          ),
        ),
      ),
      onTap: () {
        if (menuData.menuItem == MenuItem.logout) {
          _doLogout(context);
        } else {
          onMenuClick(menuData.menuItem);
        }
      },
    );
  }

 void _doLogout(BuildContext context) {
  // Add your logout logic here (e.g., clearing tokens, notifying the server, etc.)
  // Then navigate to the login screen using GoRouter
  context.go(Routes.login); // Use GoRouter to navigate
  }
}

class MenuData {
  final String iconPath;
  final String selectedIconPath;
  final String name;
  final MenuItem menuItem;

  MenuData({
    required this.selectedIconPath,
    required this.iconPath,
    required this.name,
    required this.menuItem,
  });
}

enum MenuItem { home, profile, logout }
