class DropDownType {
  final int value;
  final String name;
  final bool selected;

  DropDownType({
    required this.value,
    required this.name,
    required this.selected,
  });

  // Factory method to create DropDownType from JSON (Map)
  factory DropDownType.fromJson(Map<String, dynamic> json) {
    return DropDownType(
      value: json['value'] ?? 0,
      name: json['name'] ?? '',
      selected: json['selected'] ?? false,
    );
  }

  // Method to convert DropDownType to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'name': name,
      'selected': selected,
    };
  }
}
