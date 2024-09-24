import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/screens/dashboard_screen.dart' deferred as home;
import '../views/screens/login_screen.dart' deferred as login;
import '../views/screens/pin_check_screen.dart' deferred as check_pin;
import '../views/screens/set_pin_screen.dart' deferred as set_pin;
import '../views/screens/all_set_screen.dart' deferred as all_set;
import '../views/screens/splash_screen.dart';

class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String setPin = '/setPin';
  static const String checkPin = '/pinCheck';
  static const String allSetScreen = '/allSet';
}

GoRouter getAppRoute() {
  return GoRouter(
    routes: [
      GoRoute(
        path: Routes.root,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => DeferredLoader(
          loader: () async {
            await login.loadLibrary();
            return login.LoginScreen();
          },
          builder: (context, loginScreen) => loginScreen,
        ),
      ),
      GoRoute(
        path: Routes.home,
        builder: (context, state) => DeferredLoader(
          loader: () async {
            await home.loadLibrary();
            return home.DashboardScreen();
          },
          builder: (context, homeScreen) => homeScreen,
        ),
      ),
      GoRoute(
        path: Routes.setPin,
        builder: (context, state) => DeferredLoader(
          loader: () async {
            await set_pin.loadLibrary();
            return set_pin.SetPinScreen();
          },
          builder: (context, setPinScreen) => setPinScreen,
        ),
      ),
      GoRoute(
        path: Routes.checkPin,
        builder: (context, state) => DeferredLoader(
          loader: () async {
            await check_pin.loadLibrary();
            return check_pin.PinCheckScreen();
          },
          builder: (context, checkPinScreen) => checkPinScreen,
        ),
      ),
      GoRoute(
        path: Routes.allSetScreen,
        builder: (context, state) => DeferredLoader(
          loader: () async {
            await all_set.loadLibrary();
            return all_set.AllSetScreen();
          },
          builder: (context, allSetScreen) => allSetScreen,
        ),
      ),
      // Add more routes as needed
    ],
  );
}

class DeferredLoader extends StatefulWidget {
  final Future<Widget> Function() loader;
  final Widget Function(BuildContext, Widget) builder;
  final Widget loadingWidget;

  const DeferredLoader({
    required this.loader,
    required this.builder,
    this.loadingWidget = const Center(child: CircularProgressIndicator()),
    super.key,
  });

  @override
  _DeferredLoaderState createState() => _DeferredLoaderState();
}

class _DeferredLoaderState extends State<DeferredLoader> {
  late Future<Widget> _loaderFuture;

  @override
  void initState() {
    super.initState();
    _loaderFuture = widget.loader();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _loaderFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget;
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data!);
        } else {
          //TODO ERROR PAGE
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
