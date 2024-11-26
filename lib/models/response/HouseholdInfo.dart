// models/household.dart
import 'asset.dart';
import 'history.dart';

class Household {
  final String householdGuid;
  final String householdName;
  final String amount;
  final List<Asset> assets;
  final List<History> history;

  Household({
    required this.householdGuid,
    required this.householdName,
    required this.amount,
    required this.assets,
    required this.history,
  });

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      householdGuid: json['householdGuid'],
      householdName: json['householdName'],
      amount: json['amount'],
      assets: List<Asset>.from(json['assets'].map((x) => Asset.fromJson(x))),
      history: List<History>.from(json['history'].map((x) => History.fromJson(x))),
    );
  }
}
