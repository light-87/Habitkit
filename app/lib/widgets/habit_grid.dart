import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_date_utils;

class HabitGrid extends Widget {
  final Habit habit;
  final int months;
  final bool showLabels;
  final Function(DateTime)? onTileTap;

  const HabitGrid({
    super.key,
    required this.habit,
    this.months = 6,
    this.showLabels = true,
    this.onTileTap,
  });

  @override
  Element createElement() => _HabitGridElement(this);
}

class _HabitGridElement extends ComponentElement {
  _HabitGridElement(HabitGrid super.widget);

  @override
  HabitGrid get widget => super.widget as HabitGrid;

  @override
  Widget build() {
    return _HabitGridWidget(
      habit: widget.habit,
      months: widget.months,
      showLabels: widget.showLabels,
      onTileTap: widget.onTileTap,
    );
  }
}

class _HabitGridWidget extends StatelessWidget {
  final Habit habit;
  final int months;
  final bool showLabels;
  final Function(DateTime)? onTileTap;

  const _HabitGridWidget({
    required this.habit,
    required this.months,
    required this.showLabels,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get dates organized by month and weekday
    final yearViewData = app_date_utils.DateUtils.getYearViewDates(months: months);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month columns
          ...yearViewData.entries.map((monthEntry) {
            final monthName = monthEntry.key;
            final weekdayData = monthEntry.value;

            return Padding(
              padding: const EdgeInsets.only(right: AppConstants.spacingSM),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Weekday rows for this month
                  ...List.generate(7, (index) {
                    final weekday = index + 1; // 1 = Monday, 7 = Sunday
                    final daysInWeekday = weekdayData[weekday] ?? [];

                    return SizedBox(
                      height: AppConstants.gridTileSize +
                          AppConstants.gridTileGap,
                      child: Row(
                        children: daysInWeekday.map((date) {
                          return _GridTile(
                            date: date,
                            habit: habit,
                            onTap: onTileTap != null
                                ? () => onTileTap!(date)
                                : null,
                          );
                        }).toList(),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  final DateTime date;
  final Habit habit;
  final VoidCallback? onTap;

  const _GridTile({
    required this.date,
    required this.habit,
    this.onTap,
  });

  Color _getTileColor() {
    final completion = habit.getCompletionForDate(date);
    final habitColor = AppColors.fromHex(habit.color);

    // If no completion, show very light tint of habit color
    if (completion == null) {
      return habitColor.withOpacity(0.15);
    }

    // OR Options: Use the selected option's color
    if (habit.hasOrOptions && habit.orOptions != null) {
      if (completion.selectedOption == 'option1') {
        return AppColors.fromHex(habit.orOptions!.option1.color);
      } else if (completion.selectedOption == 'option2') {
        return AppColors.fromHex(habit.orOptions!.option2.color);
      } else if (completion.selectedOption == 'both') {
        // Show both colors (gradient or split)
        return AppColors.fromHex(habit.orOptions!.option1.color);
      }
    }

    // Regular habit: Use full habit color for completed days
    return habitColor;
  }

  @override
  Widget build(BuildContext context) {
    final tileColor = _getTileColor();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.gridTileSize,
        height: AppConstants.gridTileSize,
        margin: const EdgeInsets.all(AppConstants.gridTileGap / 2),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(AppConstants.radiusSM / 2),
        ),
      ),
    );
  }
}
