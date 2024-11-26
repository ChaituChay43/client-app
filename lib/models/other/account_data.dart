import 'package:amplify/models/other/balance_details.dart';

class Custodian {
  final String id;
  final String name;

  Custodian({required this.id, required this.name});

  factory Custodian.fromJson(Map<String, dynamic> json) {
    return Custodian(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'Custodian(id: $id, name: $name)';
}

class TaxStatus {
  final String id;
  final String name;

  TaxStatus({required this.id, required this.name});

  factory TaxStatus.fromJson(Map<String, dynamic> json) {
    return TaxStatus(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'TaxStatus(id: $id, name: $name)';
}

class Account {
  final String householdId;
  final String id;
  final String accountName;
  final Custodian custodian;
  final String accountNumber;
  final double totalBalance;
  final TaxStatus taxStatus;
  final String type;
  final DateTime? createdDate;
  final BalanceDetails today;
  final BalanceDetails mtd; // Month to Date
  final BalanceDetails qtd; // Quarter to Date
  final BalanceDetails ytd; // Year to Date

  Account({
    required this.householdId,
    required this.id,
    required this.accountName,
    required this.custodian,
    required this.accountNumber,
    required this.totalBalance,
    required this.taxStatus,
    required this.type,
    required this.createdDate,
    required this.today,
    required this.mtd,
    required this.qtd,
    required this.ytd,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    // Extract `returns` and map each named entry to the corresponding BalanceDetails instance
    BalanceDetails today = BalanceDetails(value: 0, percentage: 0);
    BalanceDetails mtd = BalanceDetails(value: 0, percentage: 0);
    BalanceDetails qtd = BalanceDetails(value: 0, percentage: 0);
    BalanceDetails ytd = BalanceDetails(value: 0, percentage: 0);

    if (json['returns'] is List) {
      for (var returnItem in json['returns']) {
        final name = returnItem['name'];
        final value = (returnItem['value'] as num?)?.toDouble() ?? 0.0;
        final percentage = (returnItem['percentage'] as num?)?.toDouble() ?? 0.0;

        if (name == "today") {
          today = BalanceDetails(value: value, percentage: percentage);
        } else if (name == "MTD") {
          mtd = BalanceDetails(value: value, percentage: percentage);
        } else if (name == "QTD") {
          qtd = BalanceDetails(value: value, percentage: percentage);
        } else if (name == "YTD") {
          ytd = BalanceDetails(value: value, percentage: percentage);
        }
      }
    }

    return Account(
      householdId: json['householdId']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      accountName: json['accountName']?.toString() ?? '',
      custodian: json['custodian'] != null
          ? Custodian.fromJson(json['custodian'] as Map<String, dynamic>)
          : Custodian(id: '', name: ''),
      accountNumber: json['accountNumber']?.toString() ?? '',
      totalBalance: (json['totalBalance'] as num?)?.toDouble() ?? 0.0,
      taxStatus: json['taxStatus'] != null
          ? TaxStatus.fromJson(json['taxStatus'] as Map<String, dynamic>)
          : TaxStatus(id: '', name: ''),
      type: json['type']?.toString() ?? '',
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate']) // Parse the createdDate
          : null,
      today: today,
      mtd: mtd,
      qtd: qtd,
      ytd: ytd,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'householdId': householdId,
      'id': id,
      'accountName': accountName,
      'custodian': custodian.toJson(),
      'accountNumber': accountNumber,
      'totalBalance': totalBalance,
      'taxStatus': taxStatus.toJson(),
      'type': type,
      'createdDate': createdDate,
      'today': today.toJson(),
      'mtd': mtd.toJson(),
      'qtd': qtd.toJson(),
      'ytd': ytd.toJson(),
    };
  }

  @override
  String toString() {
    return 'Account(householdId: $householdId, id: $id, accountName: $accountName, '
           'custodian: $custodian, accountNumber: $accountNumber, totalBalance: $totalBalance, '
           'taxStatus: $taxStatus, type: $type, createdDate: $createdDate, '
           'today: $today, mtd: $mtd, qtd: $qtd, ytd: $ytd)';
  }
}
