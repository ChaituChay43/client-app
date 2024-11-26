import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/views/components/platform/app_logo_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // GoRouter for navigation
import '../../../constants/asset_paths.dart';
import '../base_screen.dart';

class LoginScreen extends BaseScreen {
  final ValueNotifier<String?> email = ValueNotifier(null);
  final ValueNotifier<String?> password = ValueNotifier(null);

  LoginScreen({super.key});

  @override
  Widget? getTabletBody(BuildContext context, BoxConstraints constraints) {
    return _buildBackground(
      context,
      constraints,
      Center(
        child: SizedBox(
            width: constraints.maxWidth * 0.5,
            height: constraints.maxWidth * 0.7,
            child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getMobileBody(context, constraints),
                ))),
      ),
    );
  }

  @override
  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    return _buildBackground(
      context,
      constraints,
      Row(
        children: [
          Expanded(child: Container()),
          Expanded(
            child: Center(
              child: SizedBox(
                  width: 380,
                  height: 480,
                  child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: _loginContent(context, constraints),
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget getMobileBody(BuildContext context, BoxConstraints constraints) {
    return _loginContent(context, constraints);
  }

  Widget _loginContent(BuildContext context, BoxConstraints constraints) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text(
              AppStrings.login,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const AppLogoWidget(
              width: 160,
              height: 160,
            ),
            const Spacer(),
            const SizedBox(height: 20),
            Visibility(
              visible: false, // Keep hidden if not needed
              child: TextField(
                decoration: const InputDecoration(
                  hintText: AppStrings.email,
                ),
                onChanged: (value) {
                  email.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: false, // Keep hidden if not needed
              child: TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: AppStrings.password,
                ),
                onChanged: (value) {
                  password.value = value;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate directly to the home screen
                context.go('/home'); // Replace this with the correct home route
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(AppStrings.login),
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: AppStrings.byLoggingInAmplifyPlatform),
                  TextSpan(
                    text: AppStrings.termsOfService,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Terms of Service tap
                      },
                  ),
                  const TextSpan(text: ' ${AppStrings.andString} '),
                  TextSpan(
                    text: AppStrings.privacyPolicy,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Navigate to Privacy Policy URL
                      },
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackground(
      BuildContext context, BoxConstraints constraints, Widget child) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.4,
          child: Image.asset(AssetPaths.loginBg, fit: BoxFit.cover),
        ),
        child,
      ],
    );
  }
}
