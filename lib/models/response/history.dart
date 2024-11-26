class History {
  final DateTime monthStart;
  final double netFlows;
  final double emv;
  final double netGain;

  History({
    required this.monthStart,
    required this.netFlows,
    required this.emv,
    required this.netGain,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      monthStart: DateTime.parse(json['monthStart']),
      netFlows: json['netFlows'].toDouble(),
      emv: json['emv'].toDouble(),
      netGain: json['netGain'].toDouble(),
    );
  }

  @override
  String toString() {
    return 'History(monthStart: $monthStart, netFlows: $netFlows, emv: $emv, netGain: $netGain)';
  }
}
