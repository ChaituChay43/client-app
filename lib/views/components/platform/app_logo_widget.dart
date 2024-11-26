import 'package:amplify/constants/app_constants.dart';
import 'package:amplify/util/context_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/asset_paths.dart';

class AppLogoWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const AppLogoWidget({super.key, this.width = 160, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ContextHandler.getInstance().getLogoUrl(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while fetching the logo URL
          return SizedBox(
            width: width,
            height: height,
            child: const Center(child: CircularProgressIndicator()), // Loading indicator
          );
        } else if (snapshot.hasError) {
          // Handle the error case
          return SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(AssetPaths.amplifyLogo), // Fallback logo on error
          );
        } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
          // If the logo URL is available
          String logoUrl = snapshot.data!;
          return SizedBox(
            width: width,
            height: height,
            child: Image.network('${AppConstants.logoPrefix}$logoUrl'),
          );
        } else {
          // Fallback if the logo URL is empty or null
          return SizedBox(
            width: width,
            height: height,
            child: SvgPicture.asset(AssetPaths.amplifyLogo), // Fallback logo
          );
        }
      },
    );
  }
}
