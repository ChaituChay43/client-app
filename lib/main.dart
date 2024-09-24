import 'package:amplify/route/route.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/views/helpers/bloc_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:url_strategy/url_strategy.dart';

import 'blocs/theme_bloc.dart';

void main() async {
  setPathUrlStrategy();
  await GetStorage.init();
  runApp(MyApp(router: getAppRoute()));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return BlocInitializer(
      router: router,
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'Amplify App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeAnimationCurve: Curves.easeInCirc,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
