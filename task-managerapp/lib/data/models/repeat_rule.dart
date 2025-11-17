import 'dart:convert';

enum RepeatType { none, daily, customDays }

class RepeatRule {
  final RepeatType type;
  // 0 = Monday ... 6 = Sunday
  final List<int> daysOfWeek;

  RepeatRule({
    required this.type,
    this.daysOfWeek = const [],
  });

  String get daysJson => jsonEncode(daysOfWeek);

  bool appliesTo(DateTime date) {
    if (type == RepeatType.none) return false;
    if (type == RepeatType.daily) return true;
    if (type == RepeatType.customDays) {
      final weekdayIndex = (date.weekday + 6) % 7; // Monday = 0
      return daysOfWeek.contains(weekdayIndex);
    }
    return false;
  }

  static RepeatRule? fromDb(Map<String, dynamic> map) {
    final int? typeIndex = map['repeat_type'] as int?;
    if (typeIndex == null) return null;
    final type = RepeatType.values[typeIndex];
    final String? daysStr = map['repeat_days'] as String?;
    final List<int> days = daysStr == null
        ? []
        : (jsonDecode(daysStr) as List).map((e) => e as int).toList();
    return RepeatRule(type: type, daysOfWeek: days);
  }
}
