import 'package:intl/intl.dart';

class DateUtils {
  // Get date without time component
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Check if two dates are the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    return dateOnly(date1) == dateOnly(date2);
  }

  // Check if date is today
  static bool isToday(DateTime date) {
    return isSameDay(date, DateTime.now());
  }

  // Check if date is yesterday
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return isSameDay(date, yesterday);
  }

  // Get weekday name (Mon, Tue, etc.)
  static String getWeekdayName(DateTime date, {bool short = true}) {
    if (short) {
      return DateFormat('E').format(date); // Mon, Tue, Wed
    }
    return DateFormat('EEEE').format(date); // Monday, Tuesday
  }

  // Get month name (Jan, Feb, etc.)
  static String getMonthName(DateTime date, {bool short = true}) {
    if (short) {
      return DateFormat('MMM').format(date); // Jan, Feb
    }
    return DateFormat('MMMM').format(date); // January, February
  }

  // Format date for display
  static String formatDate(DateTime date, {String format = 'MMM dd, yyyy'}) {
    return DateFormat(format).format(date);
  }

  // Get days between two dates
  static int daysBetween(DateTime from, DateTime to) {
    from = dateOnly(from);
    to = dateOnly(to);
    return (to.difference(from).inHours / 24).round();
  }

  // Get list of dates in a range
  static List<DateTime> getDatesInRange(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    DateTime current = dateOnly(start);
    final endDate = dateOnly(end);

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }

    return dates;
  }

  // Get dates for grid visualization (last N months)
  static List<DateTime> getGridDates({int months = 6}) {
    final now = DateTime.now();
    final end = dateOnly(now);

    // Go back to the start of the week
    final startOfWeek = end.subtract(Duration(days: end.weekday - 1));

    // Go back N months
    final start = DateTime(startOfWeek.year, startOfWeek.month - months, startOfWeek.day);

    return getDatesInRange(start, end);
  }

  // Get start of week
  static DateTime getStartOfWeek(DateTime date) {
    final currentDate = dateOnly(date);
    return currentDate.subtract(Duration(days: currentDate.weekday - 1));
  }

  // Get start of month
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  // Get end of month
  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  // Get days in month
  static int getDaysInMonth(DateTime date) {
    return getEndOfMonth(date).day;
  }

  // Check if date is in the last N days
  static bool isInLastDays(DateTime date, int days) {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: days));
    return date.isAfter(cutoff) && date.isBefore(now.add(const Duration(days: 1)));
  }

  // Get relative date string (Today, Yesterday, 2 days ago, etc.)
  static String getRelativeDateString(DateTime date) {
    if (isToday(date)) return 'Today';
    if (isYesterday(date)) return 'Yesterday';

    final daysDiff = daysBetween(dateOnly(date), dateOnly(DateTime.now()));

    if (daysDiff <= 7) {
      return '$daysDiff days ago';
    } else if (daysDiff <= 30) {
      final weeks = (daysDiff / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (daysDiff <= 365) {
      final months = (daysDiff / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      return formatDate(date);
    }
  }
}
