class HouseholdInfo {
  double? riskToleranceScore;
  DateTime? firstAccountOpened;
  String? name;
  String? primaryPhone;
  String? primaryEmail;
  String? secToken;
  List<String>? householdTags; // Assuming it's a list of strings
  // ignore: non_constant_identifier_names
  dynamic addresses; // Assuming Address is another class you have

  HouseholdInfo({
    this.name,
    this.firstAccountOpened,
    this.primaryPhone,
    this.primaryEmail,
    this.secToken,
    this.householdTags,
    this.riskToleranceScore,
    // ignore: non_constant_identifier_names
    this.addresses,
  });
}
