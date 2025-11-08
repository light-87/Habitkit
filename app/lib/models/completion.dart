import 'package:hive/hive.dart';

part 'completion.g.dart';

@HiveType(typeId: 3)
class Completion extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  int count; // For multiple completions per day

  @HiveField(3)
  String? selectedOption; // "option1", "option2", "both", or null

  Completion({
    required this.id,
    required this.date,
    this.count = 1,
    this.selectedOption,
  });

  // Get date without time (for comparison)
  DateTime get dateOnly {
    return DateTime(date.year, date.month, date.day);
  }

  // Check if this completion is for today
  bool get isToday {
    final now = DateTime.now();
    return dateOnly == DateTime(now.year, now.month, now.day);
  }

  // Increment count
  void increment() {
    count++;
  }

  // Decrement count
  void decrement() {
    if (count > 0) count--;
  }

  // Copy with
  Completion copyWith({
    String? id,
    DateTime? date,
    int? count,
    String? selectedOption,
  }) {
    return Completion(
      id: id ?? this.id,
      date: date ?? this.date,
      count: count ?? this.count,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'count': count,
      'selectedOption': selectedOption,
    };
  }

  // From JSON
  factory Completion.fromJson(Map<String, dynamic> json) {
    return Completion(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      count: json['count'] as int? ?? 1,
      selectedOption: json['selectedOption'] as String?,
    );
  }
}
