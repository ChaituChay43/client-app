import 'package:amplify/blocs/auth/auth_bloc.dart';
import 'package:amplify/blocs/profile/profile_bloc.dart';
import 'package:amplify/blocs/route/route_bloc.dart';
import 'package:amplify/blocs/theme_bloc.dart';
import 'package:amplify/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BlocInitializer extends StatelessWidget {
  final Widget child;
  final GoRouter router;

  const BlocInitializer({super.key, required this.child, required this.router});

  @override
  Widget build(BuildContext context) {
    RouteBloc routeBloc = RouteBloc(NavigationService(router));
    return MultiBlocProvider(providers: [
      BlocProvider<RouteBloc>(
        create: (BuildContext context) => routeBloc,
      ),
      BlocProvider<AuthBloc>(
        create: (BuildContext context) => AuthBloc(routeBloc),
      ),
      BlocProvider<ThemeBloc>(
        create: (BuildContext context) => ThemeBloc(),
      ),
      BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc(),
      ),
    ], child: child);
  }
}
