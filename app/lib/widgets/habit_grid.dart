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
    // Get dates for the grid
    final dates = app_date_utils.DateUtils.getGridDates(months: months);

    // Group by weeks
    final weeks = <List<DateTime>>[];
    for (int i = 0; i < dates.length; i += 7) {
      final end = (i + 7 < dates.length) ? i + 7 : dates.length;
      weeks.add(dates.sublist(i, end));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Day labels (Mon, Tue, etc.)
          if (showLabels)
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                right: AppConstants.spacingSM,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                    .map((day) => SizedBox(
                          height: AppConstants.gridTileSize +
                              AppConstants.gridTileGap,
                          child: Center(
                            child: Text(
                              day,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 10),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),

          // Grid tiles
          ...weeks.map((week) {
            final monthName = app_date_utils.DateUtils.getMonthName(week.first);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Month label
                if (showLabels)
                  SizedBox(
                    height: 20,
                    child: Text(
                      week.first.day <= 7 ? monthName : '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 10),
                    ),
                  ),
                // Week column
                Column(
                  children: week.map((date) {
                    return _GridTile(
                      date: date,
                      habit: habit,
                      onTap: () => onTileTap?.call(date),
                    );
                  }).toList(),
                ),
              ],
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

    if (completion == null) {
      return const Color(0xFFE5E7EB); // Empty tile
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

    // Regular habit: Use habit color with intensity
    final habitColor = AppColors.fromHex(habit.color);
    final intensity = (completion.count / 3).clamp(0.0, 1.0);
    return habitColor.withOpacity(0.3 + (0.7 * intensity));
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
