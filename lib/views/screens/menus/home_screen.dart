import 'package:amplify/constants/app_constants.dart';
import 'package:amplify/data/services/storage_service.dart';
import 'package:amplify/views/components/web_view_loader.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageService().getString(StorageService.accessToken),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle the error case
          return Center(
            child: Text('Error loading token: ${snapshot.error}'),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return WebViewLoader(
            url: AppConstants.portalUrl,
            headers: {
              'Authorization': 'Bearer ${snapshot.data}',
            },
          );
        } else {
          //TODO Need to replace with failure design.
          return const Center(
            child: Text('Token not found or invalid'),
          );
        }
      },
    );
  }
}

