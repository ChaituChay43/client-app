import 'package:amplify/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinWidget extends StatefulWidget {
  final Function(String) onValueUpdated;

  const PinWidget({super.key, required this.onValueUpdated});

  @override
  State<PinWidget> createState() => _PinWidgetState();
}

class _PinWidgetState extends State<PinWidget> {
  late final TextEditingController pinController;

  @override
  void initState() {
    super.initState();
    pinController = TextEditingController();

    /// In case you need an SMS autofill feature
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bool isDarkMode = themeData.brightness == Brightness.dark;
    var focusedBorderColor =
        isDarkMode ? themeData.primaryColor : themeData.primaryColorDark;
    var fillColor = isDarkMode
        ? AppTheme.darkTextColor
        : AppTheme.primaryColorDark.withAlpha(180);
    var borderColor = isDarkMode
        ? AppTheme.darkTextColor
        : AppTheme.primaryColorDark.withAlpha(180);

    final defaultPinTheme = PinTheme(
      width: 46,
      height: 46,
      textStyle: TextStyle(
        fontSize: 22,
        color: isDarkMode ? themeData.primaryColorDark : AppTheme.darkTextColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Pinput(
            controller: pinController,
            defaultPinTheme: defaultPinTheme,
            separatorBuilder: (index) => const SizedBox(width: 16),
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            onCompleted: (pin) {
              debugPrint('onCompleted: $pin');
              widget.onValueUpdated(pin);
            },
            onChanged: (value) {
              debugPrint('onChanged: $value');
              widget.onValueUpdated(value);
            },
            obscureText: true,
            obscuringCharacter: '*',
            cursor: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 9),
                  width: 22,
                  height: 1,
                  color: focusedBorderColor,
                ),
              ],
            ),
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: focusedBorderColor),
              ),
            ),
            submittedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                color: fillColor,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            errorPinTheme: defaultPinTheme.copyBorderWith(
              border: Border.all(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
