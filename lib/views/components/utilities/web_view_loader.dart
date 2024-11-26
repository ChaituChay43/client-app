import 'package:amplify/views/components/platform/web_url_loader.dart';
import 'package:flutter/material.dart';

class WebViewLoader extends StatelessWidget {
  final String? url; // Allow nullability to handle initial value checks
  final Map<String, String> headers;

  const WebViewLoader({super.key, required this.url, this.headers = const {}});

  @override
  Widget build(BuildContext context) {
    // Check for null URL
    if (url == null || url!.isEmpty) {
      return const Center(
        child: Text(
          'No valid URL provided.',
          style: TextStyle(color: Colors.red, fontSize: 16.0),
        ),
      );
    }

    // Print debug info for verification
    print("Loading URL: $url");

    // Proceed with a valid URL
    return WebUrlLoader(url: url!, headers: headers);
  }
}
