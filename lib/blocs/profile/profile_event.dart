import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends ProfileEvent {}

class FetchProfile extends ProfileEvent {}
