class HouseholdDetail {
  final int iid;
  final String id;
  final String name;
  final double marketValue;
  final double netWorth;
  final int? numAccounts; // Nullable
  final String status;
  final DateTime firstAccountOpened;
  final int rating;
  final String currentStatus;
  final double riskToleranceScore;
  final String blkDiamId;
  final String blkDiamRelId;
  final List<Account> accounts;

  HouseholdDetail({
    required this.iid,
    required this.id,
    required this.name,
    required this.marketValue,
    required this.netWorth,
    this.numAccounts,
    required this.status,
    required this.firstAccountOpened,
    required this.rating,
    required this.currentStatus,
    required this.riskToleranceScore,
    required this.blkDiamId,
    required this.blkDiamRelId,
    required this.accounts,
  });

  factory HouseholdDetail.fromJson(Map<String, dynamic> json) {
    return HouseholdDetail(
      iid: json['_iid'] ?? 0, // Provide default value for null
      id: json['id'] ?? '', // Default to empty string
      name: json['name'] ?? '', // Default to empty string
      marketValue: (json['marketValue'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      netWorth: (json['netWorth'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      numAccounts: json['numAccounts'], // Keep nullable
      status: json['status'] ?? '', // Default to empty string
      firstAccountOpened: DateTime.tryParse(json['firstAccountOpened'] ?? '') ?? DateTime.now(), // Handle parsing
      rating: json['rating'] ?? 0, // Default to 0
      currentStatus: json['currentStatus'] ?? '', // Default to empty string
      riskToleranceScore: (json['riskToleranceScore'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      blkDiamId: json['blkDiamId'] ?? '', // Default to empty string
      blkDiamRelId: json['blkDiamRelId'] ?? '', // Default to empty string
      accounts: (json['accounts'] as List)
          .map((accountJson) => Account.fromJson(accountJson))
          .toList(),
    );
  }

}

class Account {
  final int iid;
  final String id;
  final String name;
  final String number;
  final String custodian;
  final double balance;
  final bool needsRebalance;
  final bool isClosed;
  final bool isSupervised;
  final DateTime startDate;
  final List<Holding> holdings;

  Account({
    required this.iid,
    required this.id,
    required this.name,
    required this.number,
    required this.custodian,
    required this.balance,
    required this.needsRebalance,
    required this.isClosed,
    required this.isSupervised,
    required this.startDate,
    required this.holdings,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      iid: json['iid'] ?? 0, // Default to 0
      id: json['id'] ?? '', // Default to empty string
      name: json['name'] ?? '', // Default to empty string
      number: json['number'] ?? '', // Default to empty string
      custodian: json['custodian'] ?? '', // Default to empty string
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      needsRebalance: json['needsRebalance'] ?? false, // Default to false
      isClosed: json['isClosed'] ?? false, // Default to false
      isSupervised: json['isSupervised'] ?? false, // Default to false
      startDate: DateTime.tryParse(json['startDate'] ?? '') ?? DateTime.now(), // Handle parsing
      holdings: (json['holdings'] as List)
          .map((holdingJson) => Holding.fromJson(holdingJson))
          .toList(),
    );
  }
}

class Holding {
  final String? symbolId; // Nullable
  final String symbolType; // Default to empty string
  final String cusip; // Required
  final int securityId; // Required
  final String name; // Required
  final double units; // Required
  final double marketValue; // Required
  final double costBasis; // Required
  final DateTime firstTradeDate; // Handle parsing
  final double unrealizedLTGain; // Required
  final double unrealizedSTGain; // Required
  final String assetClass; // Required

  Holding({
    this.symbolId,
    required this.symbolType,
    required this.cusip,
    required this.securityId,
    required this.name,
    required this.units,
    required this.marketValue,
    required this.costBasis,
    required this.firstTradeDate,
    required this.unrealizedLTGain,
    required this.unrealizedSTGain,
    required this.assetClass,
  });

  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      symbolId: json['symbolId'], // Nullable
      symbolType: json['symbolType'] ?? '', // Default to empty string
      cusip: json['cusip'] ?? '', // Default to empty string
      securityId: json['securityId'] ?? 0, // Default to 0
      name: json['name'] ?? '', // Default to empty string
      units: (json['units'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      marketValue: (json['marketValue'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      costBasis: (json['costBasis'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      firstTradeDate: DateTime.tryParse(json['firstTradeDate'] ?? '') ?? DateTime.now(), // Handle parsing
      unrealizedLTGain: (json['unrealizedLTGain'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      unrealizedSTGain: (json['unrealizedSTGain'] as num?)?.toDouble() ?? 0.0, // Default to 0.0
      assetClass: json['assetClass'] ?? '', // Default to empty string
    );
  }
}
