import 'package:amplify/views/components/platform/mobile_url_loader.dart';
import 'package:amplify/views/components/platform/web_url_loader.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class WebViewLoader extends StatelessWidget {
  final String url;
  final Map<String, String> headers;

  const WebViewLoader({super.key, required this.url, this.headers = const {}});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return WebUrlLoader(url: url, headers: headers);
    } else {
      return MobileUrlLoader(url: url, headers: headers);
    }
  }
}
