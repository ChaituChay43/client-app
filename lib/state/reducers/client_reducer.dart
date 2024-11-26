import '../../data/app_state.dart';
import '../actions/client_actions.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is SetClientIdAction) {
    return AppState(clientId: action.clientId);
  }
  return state;
}
