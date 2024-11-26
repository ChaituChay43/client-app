import 'dart:async';

import 'package:amplify/blocs/profile/profile_event.dart';
import 'package:amplify/blocs/profile/profile_state.dart';
import 'package:amplify/data/repositories/profile_repository.dart';
import 'package:amplify/data/api_services/base_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepository = ProfileRepository();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>(fetchProfile);
  }

  FutureOr<void> fetchProfile(
      FetchProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      emit(ProfileSuccess(profileRes: await _profileRepository.fetchProfile()));
    } catch (e) {
      if (e is ApiException) {
        emit(ProfileFailed(httpCode: e.statusCode));
      }
      emit(const ProfileFailed(httpCode: 520));
    }
  }
}
