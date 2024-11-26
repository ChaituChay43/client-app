class Household {
  final String id;
  final String householdName;
  final double amount;

  Household({
    required this.id,
    required this.householdName,
    required this.amount,
  });

  factory Household.fromJson(Map<String, dynamic> json) {
    return Household(
      id: json['id'] ?? '',
      householdName: json['householdName'] ?? 'Unknown',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'householdName': householdName,
      'amount': amount, 
    };
  }

  @override
  String toString() {
    return 'Household(id: $id, householdName: $householdName, amount: $amount)';
  }
}
