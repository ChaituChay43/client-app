import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final Uri location;
  const ErrorPage({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    // Auth.handleAuth(location);
    return Scaffold(
      body: Center(
        child: Text('Page not found: $location'),
      ),
    );
  }
}
