import 'package:amplify/blocs/base_bloc.dart';
import 'package:amplify/blocs/route/route_bloc.dart';
import 'package:amplify/data/repositories/auth_repository.dart';
import 'package:amplify/data/repositories/profile_repository.dart';
import 'package:amplify/data/services/storage_service.dart';
import 'package:amplify/route/route.dart';
import 'package:amplify/util/auth_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository = AuthRepository();
  final ProfileRepository _profileRepository = ProfileRepository();

  AuthBloc(RouteBloc roteBloc) : super(AuthInitial(), roteBloc) {
    on<AppStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: kIsWeb ? 1 : 3));
      emit(AuthInit());
      if (await _authRepository.isLoggedIn()) {
        routeBloc.add(const Goto(path: Routes.home));
      } else {
        routeBloc.add(const Goto(path: Routes.login));
      }
    });

    on<AuthCheck>((event, emit) async {
      if (!await _authRepository.authCheck()) {
        routeBloc.add(const Goto(path: Routes.login));
      }
    });

    on<SetPin>((event, emit) async {
      emit(LoginLoading());
      _authRepository.setLoginPin(event.pin);
      routeBloc.add(const Goto(path: Routes.home));
    });

    on<CheckPin>((event, emit) async {
      emit(LoginLoading());
      if (await _authRepository.checkPin(event.pin)) {
        routeBloc.add(const Goto(path: Routes.home));
      } else {
        emit(ErrorLoginPin());
      }
    });

    on<ResetPin>((event, emit) async {
      emit(LoginLoading());
      _authRepository.clearLoginDetails();
      emit(AuthInit());
      routeBloc.add(const Goto(path: Routes.login));
    });

    on<LoggedIn>((event, emit) async {
      emit(LoginLoading());
      if (kIsWeb) {
        try {
          var isLoggedIn = await AuthHelper.authWrapper();
          if (await AuthHelper.isTokenExpired()) {
            bool isRefreshed = await AuthHelper.handleRefresh();
            debugPrint(isRefreshed.toString());
          }
          _researchWatchlistAPI(event, emit);
          if (isLoggedIn) {
            await _authRepository.updateLoginStatus("", null);
            await _profileRepository.fetchProfile();
            emit(const LoginSuccess(loginRes: null));
            routeBloc.add(const Goto(path: Routes.home));
          }
        } catch (e) {
          emit(LoginFailure(error: e.toString()));
        }
      } else {
        Uri loginPopUri = AuthHelper.getLoginPopUrl();
        emit(LoginPopUp(loginPopUrl: loginPopUri));
      }
    });

    on<OnOAuthSuccess>((event, emit) async {
      emit(OAuthLoginLoading());
      bool isLoggedIn = await AuthHelper.doMobileUrlParse(event.oAuthUrl);
      if (await AuthHelper.isTokenExpired()) {
        bool isRefreshed = await AuthHelper.handleRefresh();
        debugPrint(isRefreshed.toString());
      }
      if (isLoggedIn) {
        await _authRepository.updateLoginStatus("", null);
        await _profileRepository.fetchProfile();
        emit(const LoginSuccess(loginRes: null));
        routeBloc.add(const Goto(path: Routes.home));
      }
    });

    on<LoggedOut>((event, emit) async {
      emit(LoginLoading());
      await _authRepository.clearLoginDetails();
      routeBloc.add(const Goto(path: Routes.login));
      emit(AuthUnauthenticated());
    });
  }

  //TODO Need to move this to service layer
  void _researchWatchlistAPI(LoggedIn event, emit) async {
    var testUrl = Uri(
        scheme: 'https',
        host: "api-test.amplifyplatform.com",
        path: "/v1/profile/settings/researchWatchlist");
    var testRes = await http.get(testUrl, headers: {
      'Authorization':
          'Bearer ${StorageService().getString(StorageService.accessToken)}',
    });
    debugPrint(testRes.body);
  }
}
