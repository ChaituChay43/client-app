class StockAsset {
  final String householdId;
  final String accountId;
  final String accountName;
  final String symbol;
  final String name;
  final double value;
  final double percentage;

  StockAsset({
    required this.householdId,
    required this.accountId,
    required this.accountName,
    required this.symbol,
    required this.name,
    required this.value,
    required this.percentage,
  });

  factory StockAsset.fromJson(Map<String, dynamic> json) {
    return StockAsset(
      householdId: json['householdId'] ?? '',
      accountId: json['accountId'] ?? '',
      accountName: json['accountName'] ?? '',
      symbol: json['symbol'] ?? '',
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
      'householdId': householdId,
      'accountId': accountId,
      'accountName': accountName,
      'symbol': symbol,
      'name': name,
      'value': value,
      'percentage': percentage,
    };
  }

  static List<StockAsset> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StockAsset.fromJson(json as Map<String, dynamic>)).toList();
  }

  // toString method for readable output
  @override
  String toString() {
    return 'StockAsset(householdId: $householdId, accountId: $accountId, accountName: $accountName, symbol: $symbol, name: $name, value: \$${value.toStringAsFixed(2)}, percentage: ${percentage.toStringAsFixed(2)}%)';
  }
}
