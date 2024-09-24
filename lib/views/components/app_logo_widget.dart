import 'package:amplify/constants/app_constants.dart';
import 'package:amplify/util/context_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/asset_paths.dart';

class AppLogoWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const AppLogoWidget({super.key, this.width = 160, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ContextHandler.getInstance().getLogoUrl(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          String? logoUrl = snapshot.data;
          return SizedBox(
            width: width,
            height: height,
            child: (logoUrl != null && logoUrl != '')
                ? Image.network('${AppConstants.logoPrefix}$logoUrl')
                : SvgPicture.asset(AssetPaths.amplifyLogo),
          );
        } else {
          return SizedBox(
            width: width,
            height: height,
          );
        }
      },
    );
  }
}
