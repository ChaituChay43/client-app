import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileUrlLoader extends StatefulWidget {
  final String url;
  final Map<String, String> headers;

  const MobileUrlLoader({super.key, required this.url, required this.headers});

  @override
  _MobileUrlLoaderState createState() => _MobileUrlLoaderState();
}

class _MobileUrlLoaderState extends State<MobileUrlLoader> {
  late final WebViewController controller;
  final ValueNotifier<bool> isLoading =
      ValueNotifier(true); // Initially show the loader

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          isLoading.value = true; // Show loader when the page starts loading
        },
        onPageFinished: (String url) {
          isLoading.value = false; // Hide loader when the page finishes loading
        },
      ))
      ..loadRequest(Uri.parse(widget.url), headers: widget.headers);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: controller),
        ValueListenableBuilder(
          builder: (BuildContext context, value, Widget? child) {
            return isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(), // Loader
                  )
                : const SizedBox.shrink();
          },
          valueListenable: isLoading,
        ),
      ],
    );
  }
}
