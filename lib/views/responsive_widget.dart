import 'package:amplify/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget Function(BuildContext context, BoxConstraints constraints)
      mobileBody;
  final Widget? Function(BuildContext context, BoxConstraints constraints)?
      tabletBody;
  final Widget? Function(BuildContext context, BoxConstraints constraints)?
      desktopBody;

  const ResponsiveWidget(
      {super.key, required this.mobileBody, this.tabletBody, this.desktopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < AppConstants.maxMobileWidth) {
          return mobileBody(context, constraints);
        } else if (constraints.maxWidth < AppConstants.maxTabWidth) {
          return (tabletBody != null)
              ? (tabletBody!(context, constraints) ??
                  mobileBody(context, constraints))
              : mobileBody(context, constraints);
        } else {
          return (desktopBody != null)
              ? (desktopBody!(context, constraints) ??
                  ((tabletBody != null)
                      ? tabletBody!(context, constraints) ??
                          mobileBody(context, constraints)
                      : mobileBody(context, constraints)))
              : ((tabletBody != null)
                  ? tabletBody!(context, constraints) ??
                      mobileBody(context, constraints)
                  : mobileBody(context, constraints));
        }
      },
    );
  }
}
