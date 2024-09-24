import 'package:amplify/blocs/auth/auth_state.dart';
import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/theme/app_theme.dart';
import 'package:amplify/util/auth_helper.dart';
import 'package:amplify/views/components/app_logo_widget.dart';
import 'package:amplify/views/components/multi_value_listenable_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../constants/asset_paths.dart';
import 'base_screen.dart';

class LoginScreen extends BaseScreen {
  final ValueNotifier<String?> email = ValueNotifier(null);
  final ValueNotifier<String?> password = ValueNotifier(null);

  LoginScreen({super.key});

  @override
  Widget? getTabletBody(BuildContext context, BoxConstraints constraints) {
    try {
      return Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
              opacity: 0.4,
              child: Image.asset(AssetPaths.loginBg, fit: BoxFit.cover)),
          Center(
            child: SizedBox(
                width: constraints.maxWidth * 0.5,
                height: (constraints.maxWidth * 0.7),
                child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getMobileBody(context, constraints),
                    ))),
          ),
        ],
      );
    } catch (e) {
      return getMobileBody(context, constraints);
    }
  }

  @override
  Widget? getDesktopBody(BuildContext context, BoxConstraints constraints) {
    try {
      return Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
              opacity: 0.4,
              child: Image.asset(AssetPaths.loginBg, fit: BoxFit.cover)),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
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
        ],
      );
    } catch (e) {
      return getMobileBody(context, constraints);
    }
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
              visible: false,
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
              visible: false,
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
            BlocListener<AuthBloc, AuthState>(
              listener: (BuildContext context, AuthState state) {
                if (state is LoginPopUp) {
                  _showLoginDialog(context, constraints, state.loginPopUrl);
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: const SizedBox.shrink(),
            ),
            MultiValueListenableBuilder(
              valueListenable: [email, password],
              builder: (BuildContext context, value, Widget? child) {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    return ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context)
                            .add(const LoggedIn());
                      },
                      child: (state is LoginLoading)
                          ? SizedBox(
                              width: 100,
                              child: Center(
                                child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white.withAlpha(100))),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(AppStrings.login),
                            ),
                    );
                  },
                );
              },
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
                        //TODO Need navigate Privacy Policy URL
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

  Future<void> _showLoginDialog(BuildContext context,
      BoxConstraints constraints, Uri? loginPopUrl) async {
    final ValueNotifier<bool> loading = ValueNotifier(false);
    final ValueNotifier<bool> pageLoadingIndicator = ValueNotifier(true);
    WebViewController controller = WebViewController();
    controller.setNavigationDelegate(NavigationDelegate(
      onUrlChange: (url) {
        pageLoadingIndicator.value = true;
        if (url.url?.startsWith(AuthHelper.redirectUri) ?? false) {
          loading.value = true;
          BlocProvider.of<AuthBloc>(context)
              .add(OnOAuthSuccess(oAuthUrl: url.url!));
        }
      },
      onPageFinished: (String url) {
        pageLoadingIndicator.value =
            false; // Hide loader when the page finishes loading
      },
    ));
    controller.loadRequest(loginPopUrl ?? Uri());
    Color bgColor = Theme.of(context).scaffoldBackgroundColor;
    return showDialog<void>(
      context: context,
      useSafeArea: true,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: constraints.maxWidth * 0.9, // 90% of screen width
            height: constraints.maxHeight * 0.8, // 80% of screen hei
            child: Stack(
              fit: StackFit.loose,
              children: [
                Positioned(
                  top: 18,
                  right: 18,
                  bottom: 18,
                  left: 18,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    child: Container(
                      color: bgColor,
                      child: ValueListenableBuilder(
                        valueListenable: loading,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return value
                              ? Container(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: const Center(
                                      child: SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator())),
                                )
                              : Stack(
                                  children: [
                                    WebViewWidget(controller: controller),
                                    ValueListenableBuilder(
                                      builder: (BuildContext context, value,
                                          Widget? child) {
                                        return pageLoadingIndicator.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(), // Loader
                                              )
                                            : const SizedBox.shrink();
                                      },
                                      valueListenable: pageLoadingIndicator,
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppTheme.primaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(AssetPaths.closeIcon,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
