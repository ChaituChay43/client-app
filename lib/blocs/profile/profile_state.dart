import 'package:amplify/domain/model/profile_res.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final ProfileRes profileRes;

  const ProfileSuccess({required this.profileRes});
}

class ProfileFailed extends ProfileState {
  final int httpCode;

  const ProfileFailed({required this.httpCode});
}
