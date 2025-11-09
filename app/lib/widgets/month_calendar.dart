import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_date_utils;

class MonthCalendar extends StatefulWidget {
  final Habit habit;
  final Function(DateTime)? onDayTap;

  const MonthCalendar({
    super.key,
    required this.habit,
    this.onDayTap,
  });

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime.now();
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<DateTime?> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0);

    final daysInMonth = <DateTime?>[];

    // Add empty cells for days before the first day of the month
    // weekday: 1 = Monday, 7 = Sunday
    final firstWeekday = firstDayOfMonth.weekday;
    for (int i = 1; i < firstWeekday; i++) {
      daysInMonth.add(null);
    }

    // Add all days in the month
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      daysInMonth.add(DateTime(_currentMonth.year, _currentMonth.month, day));
    }

    return daysInMonth;
  }

  @override
  Widget build(BuildContext context) {
    final days = _getDaysInMonth();
    final habitColor = AppColors.fromHex(widget.habit.color);

    return Column(
      children: [
        // Month/Year header with navigation
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingMD,
            vertical: AppConstants.spacingSM,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month and Year
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: AppConstants.spacingSM),
                  Text(
                    app_date_utils.DateUtils.formatDate(
                      _currentMonth,
                      format: 'MMM yyyy',
                    ),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),

              // Navigation buttons
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _previousMonth,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: AppConstants.spacingMD),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _nextMonth,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: AppConstants.spacingSM),

        // Calendar grid
        Container(
          padding: const EdgeInsets.all(AppConstants.spacingMD),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusLG),
            border: Border.all(color: AppColors.divider),
          ),
          child: Column(
            children: [
              // Weekday headers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map((day) => Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                            ),
                          ),
                        ))
                    .toList(),
              ),

              const SizedBox(height: AppConstants.spacingSM),

              // Calendar days grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final date = days[index];

                  if (date == null) {
                    // Empty cell for padding
                    return const SizedBox.shrink();
                  }

                  final isCompleted = widget.habit.isCompletedOn(date);
                  final isToday = app_date_utils.DateUtils.isToday(date);
                  final isFutureDate = date.isAfter(DateTime.now());

                  return GestureDetector(
                    onTap: () => widget.onDayTap?.call(date),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? habitColor.withOpacity(0.1)
                            : null,
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusSM),
                        border: isToday
                            ? Border.all(color: habitColor, width: 2)
                            : null,
                      ),
                      child: Stack(
                        children: [
                          // Day number
                          Center(
                            child: Text(
                              '${date.day}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: isFutureDate
                                        ? AppColors.textTertiary
                                        : isToday
                                            ? habitColor
                                            : AppColors.textPrimary,
                                    fontWeight: isToday
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                            ),
                          ),

                          // Completion dot
                          if (isCompleted)
                            Positioned(
                              bottom: 4,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: habitColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
