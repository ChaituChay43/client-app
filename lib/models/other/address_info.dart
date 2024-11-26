class Address {
  String? addrLabel;
  String? addr;
  String? addrCity;
  String? addrSt;
  String? addrZip;

  Address({this.addrLabel, this.addr, this.addrCity, this.addrSt, this.addrZip});

  // A method to create an Address object from dynamic JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addrLabel: json['addrLabel'],
      addr: json['addr'],
      addrCity: json['addrCity'],
      addrSt: json['addrSt'],
      addrZip: json['addrZip'],
    );
  }
}
