// In balance_details.dart
class BalanceDetails {
  final double value;
  final double percentage;

  BalanceDetails({required this.value, required this.percentage});

  factory BalanceDetails.fromJson(Map<String, dynamic> json) {
    return BalanceDetails(
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'percentage': percentage,
    };
  }

  @override
  String toString() => 'BalanceDetails(value: $value, percentage: $percentage)';
}
