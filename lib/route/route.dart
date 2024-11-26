import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../views/Pages/dashboard_screen.dart' deferred as home;
import '../views/Pages/login/login_screen.dart' deferred as login;
import '../views/Pages/pin/pin_check_screen.dart' deferred as check_pin;
import '../views/Pages/pin/set_pin_screen.dart' deferred as set_pin;
import '../views/Pages/all_set_screen.dart' deferred as all_set;
import '../views/Pages/splash_screen.dart';

// Define all route paths
class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String setPin = '/setPin';
  static const String checkPin = '/pinCheck';
  static const String allSetScreen = '/allSet';
}

// Function to get the app routes
GoRouter getAppRoute() {
  return GoRouter(
    routes: [
      // Splash screen route
      GoRoute(
        path: Routes.root,
        builder: (context, state) => const SplashScreen(),
      ),
      // Login screen route with deferred loading
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
      // Home screen route with deferred loading
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
      // Set PIN screen route with deferred loading
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
      // Check PIN screen route with deferred loading
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
      // All Set screen route with deferred loading
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
      // Handle undefined routes
      GoRoute(
        path: '/404',
        builder: (context, state) => const Center(child: Text('Page not found')),
      ),
    ],
  );
}

// Deferred loader widget for asynchronous page loading
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
          return widget.loadingWidget; // Show loading widget while loading
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error occurred, please try again later.'));
        } else if (snapshot.hasData) {
          return widget.builder(context, snapshot.data!); // Render loaded widget
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
