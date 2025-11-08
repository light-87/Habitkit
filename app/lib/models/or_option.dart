import 'package:hive/hive.dart';

part 'or_option.g.dart';

@HiveType(typeId: 1)
class OrOption extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String color; // Hex color string like "#8B5CF6"

  @HiveField(2)
  String? icon; // Optional emoji or icon name

  OrOption({
    required this.name,
    required this.color,
    this.icon,
  });

  // Copy with method for easy updates
  OrOption copyWith({
    String? name,
    String? color,
    String? icon,
  }) {
    return OrOption(
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  // To JSON for export
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'color': color,
      'icon': icon,
    };
  }

  // From JSON for import
  factory OrOption.fromJson(Map<String, dynamic> json) {
    return OrOption(
      name: json['name'] as String,
      color: json['color'] as String,
      icon: json['icon'] as String?,
    );
  }
}

@HiveType(typeId: 2)
class OrOptions extends HiveObject {
  @HiveField(0)
  OrOption option1;

  @HiveField(1)
  OrOption option2;

  OrOptions({
    required this.option1,
    required this.option2,
  });

  // Check if a specific option was selected
  OrOption? getSelectedOption(String? selection) {
    if (selection == 'option1') return option1;
    if (selection == 'option2') return option2;
    return null;
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'option1': option1.toJson(),
      'option2': option2.toJson(),
    };
  }

  // From JSON
  factory OrOptions.fromJson(Map<String, dynamic> json) {
    return OrOptions(
      option1: OrOption.fromJson(json['option1'] as Map<String, dynamic>),
      option2: OrOption.fromJson(json['option2'] as Map<String, dynamic>),
    );
  }
}
