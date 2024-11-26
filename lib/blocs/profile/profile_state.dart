import 'package:amplify/models/response/profile_res.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

// Initial state when the Profile is not yet loaded
class ProfileInitial extends ProfileState {}

// Loading state when the profile is being fetched
class ProfileLoading extends ProfileState {}

// Success state containing the loaded profile data
class ProfileSuccess extends ProfileState {
  final ProfileRes profileRes;

  const ProfileSuccess({required this.profileRes});

  @override
  List<Object> get props => [profileRes]; // Include profileRes in props for comparison
}

// Failure state with the associated HTTP code
class ProfileFailed extends ProfileState {
  final int httpCode;

  const ProfileFailed({required this.httpCode});

  @override
  List<Object> get props => [httpCode]; // Include httpCode in props for comparison
}
