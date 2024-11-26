// lib/widgets/theme_toggle_switch.dart
import 'package:amplify/blocs/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleSwitch extends StatelessWidget {
  ThemeToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return Switch(
          value: themeMode == ThemeMode.dark,
          thumbIcon: thumbIcon,
          onChanged: (value) {
            context.read<ThemeBloc>().add(ThemeEvent.toggleTheme);
          },
        );
      },
    );
  }

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.nights_stay_outlined);
      }
      return const Icon(Icons.nights_stay_rounded);
    },
  );
}
