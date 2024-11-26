import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/blocs/auth/auth_state.dart';
import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/data/api_services/storage_service.dart';
import 'package:amplify/util/util.dart';
import 'package:amplify/views/components/platform/app_logo_widget.dart';
import 'package:amplify/views/components/platform/multi_value_listenable_builder.dart';
import 'package:amplify/views/components/pin/pin_widget.dart';
import 'package:amplify/views/Pages/base_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth/auth_bloc.dart';

class PinCheckScreen extends BaseScreen {
  final ValueNotifier<String> enteredPin = ValueNotifier('');

  PinCheckScreen({super.key});

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
                height: (constraints.maxWidth * 0.75),
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
                      height: 520,
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
            const AppLogoWidget(width: 120, height: 120,),
            const Spacer(),
            Text(
              AppStrings.setUp4DigitPin,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Visibility(
                visible: false, child: Text(AppStrings.enterPinForRegisterID)),
            const SizedBox(height: 10),
            FutureBuilder(
              future: StorageService().getString(StorageService.registeredMail),
              builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    snapshot.data ?? '',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(height: 20),
            const Text(AppStrings.enterPinForRegisterID),
            const SizedBox(height: 10),
            PinWidget(
              onValueUpdated: (value) async {
                enteredPin.value = value;
              },
            ),
            const SizedBox(height: 10),
            MultiValueListenableBuilder(
                valueListenable: [enteredPin],
                builder: (BuildContext context, value, Widget? child) {
                  _checkForPins(context);
                  return const SizedBox.shrink();
                }),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (BuildContext context, state) {
                if (state.runtimeType == ErrorLoginPin) {
                  return ValueListenableBuilder(
                    valueListenable: enteredPin,
                    builder:
                        (BuildContext context, String value, Widget? child) {
                      return enteredPin.value.length == 4
                          ? Text(
                              AppStrings.pinNotMatching,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.redAccent),
                            )
                          : const SizedBox.shrink();
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  const TextSpan(text: ''),
                  TextSpan(
                    text: AppStrings.resetPin,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        BlocProvider.of<AuthBloc>(context).add(ResetPin());
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _checkForPins(BuildContext context) async {
    if (enteredPin.value.length == 4) {
      BlocProvider.of<AuthBloc>(context)
          .add(CheckPin(pin: calculateSHA256(enteredPin.value)));
    }
  }
}
