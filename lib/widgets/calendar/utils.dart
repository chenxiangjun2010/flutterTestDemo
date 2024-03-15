/// @Description:
/// @Author: 歪脖子
/// @Date: 2023-11-03 20:28

part of widgets.calendar;

enum _ViewType { year, month, day }

abstract class _Utils {
  /// 每个月对应的天数
  static const _daysInMonth = [31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  /// 最大行数
  static const int maxRowCount = 7;

  /// 是否是同一年
  static bool isSomeYear([DateTime? a, DateTime? b]) {
    if (a == null || b == null) return false;
    if (a.year != b.year) return false;
    return true;
  }

  /// 是否是同一月
  static bool isSomeMonth([DateTime? a, DateTime? b]) {
    if (a == null || b == null) return false;
    if (a.year != b.year) return false;
    if (a.month != b.month) return false;
    return true;
  }

  /// 是否是同一天
  static bool isSomeDay([DateTime? a, DateTime? b]) {
    if (a == null || b == null) return false;
    if (a.year != b.year) return false;
    if (a.month != b.month) return false;
    if (a.day != b.day) return false;
    return true;
  }

  /// 两个时间之间相差的月数
  static int monthDelta(DateTime start, DateTime end) {
    return (end.year - start.year) * 12 + end.month - start.month;
  }

  /// 根据年月获取月的天数
  static int getDaysInMonth({
    required int year,
    required int month,
  }) {
    if (month == DateTime.february) {
      if ((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)) return 29;
      return 28;
    }
    return _daysInMonth[month - 1];
  }

  /// 计算这个月的第一天是星期几（0是星期日 1是星期一...）
  /// 以及每个月前面空出来的天数
  static int computeFirstDayOffset({
    required int year,
    required int month,
    required MaterialLocalizations localizations,
  }) {
    // 基于0的一周中的某一天，0表示星期一
    final weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 基于0的一周中的某一天，0表示星期日
    final firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // 重新计算为星期一
    final firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }
}
