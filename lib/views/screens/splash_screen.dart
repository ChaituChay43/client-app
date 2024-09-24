import 'package:amplify/blocs/auth/auth_bloc.dart';
import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/views/components/app_logo_widget.dart';
import 'package:amplify/views/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends BaseScreen {
  const SplashScreen({super.key});

  @override
  void initScreen(BuildContext context) {
    super.initScreen(context);
    BlocProvider.of<AuthBloc>(context).add(AppStarted());
  }

  @override
  Widget getMobileBody(BuildContext context, BoxConstraints constraints) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.welcomeTo,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const AppLogoWidget(),
          ],
        ),
      ),
    );
  }
}
