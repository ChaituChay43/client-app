import 'package:amplify/views/responsive_widget.dart';
import 'package:flutter/material.dart';

abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Removed authentication check
    initScreen(context);
    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget(
          mobileBody: (BuildContext context, BoxConstraints constraints) {
            return getMobileBody(context, constraints);
          },
          tabletBody: (BuildContext context, BoxConstraints constraints) {
            return getTabletBody(context, constraints);
          },
          desktopBody: (BuildContext context, BoxConstraints constraints) {
            return getDesktopBody(context, constraints);
          },
        ),
      ),
    );
  }

  Widget getMobileBody(BuildContext context, BoxConstraints constraints);

  Widget? getTabletBody(BuildContext context, BoxConstraints constraints) {
    return null;
  }

  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    return null;
  }

  void initScreen(BuildContext context) {}
}
