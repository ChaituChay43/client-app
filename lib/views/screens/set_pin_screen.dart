import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/constants/app_strings.dart';
import 'package:amplify/constants/asset_paths.dart';
import 'package:amplify/views/components/app_logo_widget.dart';
import 'package:amplify/views/components/multi_value_listenable_builder.dart';
import 'package:amplify/views/components/pin_widget.dart';
import 'package:amplify/views/screens/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth/auth_bloc.dart';

class SetPinScreen extends BaseScreen {
  final ValueNotifier<String> pinOne = ValueNotifier('');
  final ValueNotifier<String> pinTwo = ValueNotifier('');

  SetPinScreen({super.key});

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
            const AppLogoWidget(
              width: 120,
              height: 120,
            ),
            const Spacer(),
            Text(
              AppStrings.setUp4DigitPin,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(AppStrings.enter4DigitPin),
            const SizedBox(height: 10),
            PinWidget(
              onValueUpdated: (value) {
                pinOne.value = value;
              },
            ),
            const SizedBox(height: 20),
            const Text(AppStrings.reEnter4DigitPin),
            const SizedBox(height: 10),
            PinWidget(
              onValueUpdated: (value) {
                pinTwo.value = value;
              },
            ),
            const SizedBox(height: 10),
            MultiValueListenableBuilder(
                valueListenable: [pinTwo, pinOne],
                builder: (BuildContext context, value, Widget? child) {
                  return ((pinOne.value.length == 4) &&
                          pinOne.value == pinTwo.value)
                      ? const SizedBox.shrink()
                      : ((pinOne.value.length == 4) &&
                              (pinTwo.value.length == 4))
                          ? Text(
                              AppStrings.pinNotMatching,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.redAccent),
                            )
                          : const SizedBox.shrink();
                }),
            const SizedBox(height: 20),
            MultiValueListenableBuilder(
              valueListenable: [pinOne, pinTwo],
              builder: (BuildContext context, value, Widget? child) {
                return ElevatedButton(
                  onPressed: (((pinOne.value.length) == 4) &&
                          (pinOne.value == pinTwo.value))
                      ? () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SetPin(pin: pinOne.value));
                        }
                      : null,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(AppStrings.continueString),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
