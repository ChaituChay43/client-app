import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/util/context_handler.dart';
import 'package:amplify/views/components/platform/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AmplifyAppBar {
  AppBar getAppBar({required BuildContext context, VoidCallback? onMenuTap}) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return AppBar(
      backgroundColor:
          isDarkMode ? AppTheme.primaryColorDark : AppTheme.primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: onMenuTap,
      ),
      title: FutureBuilder(
        future: ContextHandler.getInstance().getLogoUrl(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.data != null && snapshot.data != '')
                ? const AppLogoWidget(width: 130, height: 32)
                : Row(
                    children: [
                      SizedBox(
                          width: 32,
                          height: 32,
                          child: SvgPicture.asset(
                              AssetPaths.amplifyOnlyLogo,
                              colorFilter: ColorFilter.mode(
                                  isDarkMode
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  BlendMode.srcIn))),
                      const SizedBox(width: 8),
                      SizedBox(
                          width: 100,
                          height: 32,
                          child: SvgPicture.asset(
                              AssetPaths.amplifyOnlyName,
                              colorFilter: ColorFilter.mode(
                                  isDarkMode
                                      ? AppTheme.primaryColor
                                      : Colors.white,
                                  BlendMode.srcIn))),
                    ],
                  );
          }
          return const SizedBox.shrink();
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            // Handle profile button press
          },
        ),
      ],
    );
  }
}
