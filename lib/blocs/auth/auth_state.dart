import 'package:amplify/domain/model/login_res.dart';
import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthInit extends AuthState {}

class LoginLoading extends AuthState {}

class OAuthLoginLoading extends AuthState {}

class LoginPopUp extends AuthState {
  final Uri? loginPopUrl;
  const LoginPopUp({required this.loginPopUrl});
}

class ErrorLoginPin extends AuthState {}

class LoginSuccess extends AuthState {
  final LoginRes? loginRes;

  const LoginSuccess({required this.loginRes});
}

class LoginFailure extends AuthState {
  final String error;

  const LoginFailure({required this.error});
}

class AuthUnauthenticated extends AuthState {}
