import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Addepar extends StatelessWidget {
  final String url;
  final Map<String, String> headers;

  const Addepar({super.key, required this.url, required this.headers});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url),
                    webViewConfiguration: WebViewConfiguration(headers: headers));
              } else {
                throw 'Could not launch $url';
              }
            },
            child: const Text('Launch ADDEPAR'),
          ),
        ],
      ),
    );
  }
}
