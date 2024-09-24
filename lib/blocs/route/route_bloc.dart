import 'package:amplify/data/services/navigation_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final NavigationService _navigationService;

  RouteBloc(this._navigationService) : super(const RouteInit()) {
    on<Goto>((event, emit) async {
      _navigationService.go(event.path);
    });

    on<Push>((event, emit) {
      _navigationService.push(event.path);
    });

    on<Pop>((event, emit) {
      _navigationService.pop();
    });
  }
}

abstract class RouteEvent extends Equatable {
  final String path;

  const RouteEvent({required this.path});

  @override
  List<Object> get props => [];
}

class DoRoute extends RouteEvent {
  const DoRoute({required super.path});
}

class Goto extends RouteEvent {
  const Goto({required super.path});
}

class Push extends RouteEvent {
  const Push({required super.path});
}

class Pop extends RouteEvent {
  const Pop({required super.path});
}

abstract class RouteState extends Equatable {
  const RouteState();

  @override
  List<Object> get props => [];
}

class RouteInit extends RouteState {
  const RouteInit();
}
