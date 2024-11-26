class AppState {
  final String clientId; // Currently selected client ID

  AppState({required this.clientId});

  factory AppState.initial() {
    return AppState(clientId: ''); // Initial state with empty clientId
  }
}
