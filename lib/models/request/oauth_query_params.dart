class OAuthQueryParams {
  final String targetName;
  final String responseType;
  final String scope;
  final String clientId;
  final String state;
  final String codeChallenge;
  final String redirectUri;
  final String firm;

  OAuthQueryParams({
    required this.targetName,
    required this.responseType,
    required this.scope,
    required this.clientId,
    required this.state,
    required this.codeChallenge,
    required this.redirectUri,
    required this.firm,
  });

  // Convert to a Map to easily generate the JSON string
  Map<String, dynamic> toMap() {
    return {
      'targetName': targetName,
      'queryParams': {
        'response_type': responseType,
        'scope': scope,
        'client_id': clientId,
        'state': state,
        'code_challenge': codeChallenge,
        'redirect_uri': redirectUri,
        'firm': firm,
      },
    };
  }

  // Convert to JSON string
  String toJson() {
    return Uri.encodeComponent(toMap().toString());
  }
}
