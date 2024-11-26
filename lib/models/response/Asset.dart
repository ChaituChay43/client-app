class Asset {
  final String accountId;
  final String householdId;
  final String accountName;
  final String name;
  final double value;
  final double percentage;

  Asset({
    required this.accountId,
    required this.householdId,
    required this.accountName,
    required this.name,
    required this.value,
    required this.percentage,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      accountId: json['accountId'] ?? '',
      householdId: json['householdId'] ?? '',
      accountName: json['accountName'] ?? '',
      name: json['name'] ?? '',
      value: json['value'] is String
          ? double.tryParse(json['value']) ?? 0.0
          : (json['value'] ?? 0.0).toDouble(),
      percentage: json['percentage'] is String
          ? double.tryParse(json['percentage']) ?? 0.0
          : (json['percentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accountId': accountId,
      'householdId': householdId,
      'accountName': accountName,
      'name': name,
      'value': value,
      'percentage': percentage,
    };
  }

  static List<Asset> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Asset.fromJson(json as Map<String, dynamic>)).toList();
  }

  // toString method for readable output
  @override
  String toString() {
    return 'Asset(accountId: $accountId, householdId: $householdId, accountName: $accountName, name: $name, value: \$${value.toStringAsFixed(2)}, percentage: ${percentage.toStringAsFixed(2)}%)';
  }
}
