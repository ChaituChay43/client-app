import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  const LoggedIn();
}

class SetPin extends AuthEvent {
  final String pin;

  const SetPin({required this.pin});
}

class ResetPin extends AuthEvent {}

class OnOAuthSuccess extends AuthEvent {
  final String oAuthUrl;

  const OnOAuthSuccess({required this.oAuthUrl});
}

class AuthCheck extends AuthEvent {}

class CheckPin extends AuthEvent {
  final String pin;

  const CheckPin({required this.pin});
}

class LoggedOut extends AuthEvent {}
