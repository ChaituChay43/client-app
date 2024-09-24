import 'package:amplify/blocs/route/route_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  final RouteBloc routeBloc;

  BaseBloc(super.initialState, this.routeBloc);
}
