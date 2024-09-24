import 'package:amplify/blocs/auth/auth_bloc.dart';
import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/views/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _checkForSession(context);
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
    )));
  }

  Widget getMobileBody(BuildContext context, BoxConstraints constraints);

  Widget? getTabletBody(BuildContext context, BoxConstraints constraints) {
    return null;
  }

  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    return null;
  }

  void initScreen(BuildContext context) {}

  void _checkForSession(BuildContext context) {
    if (sessionCheckReq(context)) {
      BlocProvider.of<AuthBloc>(context).add(AuthCheck());
    }
  }

  bool sessionCheckReq(BuildContext context) {
    return false;
  }
}
