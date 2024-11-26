import 'package:redux/redux.dart';
import '../data/app_state.dart';
import 'reducers/client_reducer.dart';

final store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
);
