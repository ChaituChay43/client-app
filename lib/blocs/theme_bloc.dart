import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ThemeEvent { toggleTheme }

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.dark) {
    on<ThemeEvent>((event, emit) {
      if (event == ThemeEvent.toggleTheme) {
        emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
      }
    });
  }
}
