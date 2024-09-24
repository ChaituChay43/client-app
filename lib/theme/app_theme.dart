import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF08548A);
  static const Color primaryColorDark = Color(0xFF001C35);
  static const Color darkTextColor = Color(0xFFDEEEFD);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    elevatedButtonTheme: elevatedDarkBtnTheme,
    primaryColor: primaryColor,
    textButtonTheme: textDarkBtnTheme,

    outlinedButtonTheme: outlinedDarkBtnTheme,
    iconTheme: const IconThemeData(color: Color(0xFFC9E7F5)),
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    elevatedButtonTheme: elevatedDarkBtnTheme,
    primaryColor: primaryColor,
    textButtonTheme: textDarkBtnTheme,
    iconTheme: const IconThemeData(color: Colors.white),
    outlinedButtonTheme: outlinedDarkBtnTheme,
    cardTheme: const CardTheme(
      color: AppTheme.primaryColorDark,
    ),
    scaffoldBackgroundColor: const Color(0xFF0F1924),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: darkTextColor.withOpacity(0.70),
        fontSize: 14,
      ),
      headlineMedium: const TextStyle(
        color: darkTextColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  static get elevatedDarkBtnTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return primaryColor.withAlpha(30); // Disabled color
              }
              return primaryColor; // Enabled color
            },
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) {
                return primaryColorDark.withOpacity(0.80);
              }
              if (states.contains(WidgetState.pressed)) {
                return primaryColor;
              }
              return null;
            },
          ),
        ),
      );

  static get textDarkBtnTheme => TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(primaryColor),
          overlayColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return primaryColorDark.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF0F1924).withOpacity(0.1);
              }
              return null;
            },
          ),
        ),
      );

  static get outlinedDarkBtnTheme => OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(primaryColor),
          side: WidgetStateProperty.all(const BorderSide(color: primaryColor)),
          overlayColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return primaryColorDark.withOpacity(0.1);
              }
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFF0F1924).withOpacity(0.1);
              }
              return null;
            },
          ),
        ),
      );
}
