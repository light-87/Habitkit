import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_date_utils;

class HabitGrid extends StatelessWidget {
  final Habit habit;
  final int months;
  final bool showLabels;
  final Function(DateTime)? onTileTap;

  const HabitGrid({
    super.key,
    required this.habit,
    this.months = 7,
    this.showLabels = true,
    this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return _GitHubStyleGrid(
      habit: habit,
      months: months,
      showLabels: showLabels,
      onTileTap: onTileTap,
    );
  }
}

class _GitHubStyleGrid extends StatelessWidget {
  final Habit habit;
  final int months;
  final bool showLabels;
  final Function(DateTime)? onTileTap;

  const _GitHubStyleGrid({
    required this.habit,
    required this.months,
    required this.showLabels,
    this.onTileTap,
  });

  // Generate grid data: 7 rows (days of week) × N columns (weeks)
  List<List<DateTime?>> _generateGridData() {
    final now = DateTime.now();

    // Start from N months ago
    final startMonth = DateTime(now.year, now.month - months + 1, 1);

    // Get the first Monday before or on the start date
    DateTime current = startMonth;
    while (current.weekday != DateTime.monday) {
      current = current.subtract(const Duration(days: 1));
    }

    final endDate = now;

    // Build grid: 7 rows (Mon-Sun) and multiple columns (weeks)
    final grid = <List<DateTime?>>[];

    // Initialize 7 rows (one for each day of week)
    for (int i = 0; i < 7; i++) {
      grid.add([]);
    }

    // Fill in the dates
    DateTime date = current;
    while (date.isBefore(endDate) || date.isAtSameMomentAs(endDate)) {
      // Add dates for one week
      for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
        final currentDate = date.add(Duration(days: dayOfWeek));

        // Only add dates that are within our range
        if (currentDate.isBefore(startMonth)) {
          grid[dayOfWeek].add(null);
        } else if (currentDate.isAfter(endDate)) {
          grid[dayOfWeek].add(null);
        } else {
          grid[dayOfWeek].add(currentDate);
        }
      }

      date = date.add(const Duration(days: 7)); // Move to next week
    }

    return grid;
  }

  // Get month labels with their starting column positions
  List<MapEntry<int, String>> _getMonthLabels(List<List<DateTime?>> grid) {
    final labels = <MapEntry<int, String>>[];
    String? lastMonth;

    if (grid.isEmpty || grid[0].isEmpty) return labels;

    // Check each column (week)
    for (int col = 0; col < grid[0].length; col++) {
      // Find the first non-null date in this column
      DateTime? date;
      for (int row = 0; row < grid.length; row++) {
        if (grid[row][col] != null) {
          date = grid[row][col];
          break;
        }
      }

      if (date != null) {
        final monthName = app_date_utils.DateUtils.getMonthName(date, short: true);

        // Add label if this is a new month
        if (monthName != lastMonth) {
          labels.add(MapEntry(col, monthName));
          lastMonth = monthName;
        }
      }
    }

    return labels;
  }

  @override
  Widget build(BuildContext context) {
    final grid = _generateGridData();
    final monthLabels = _getMonthLabels(grid);

    if (grid.isEmpty || grid[0].isEmpty) {
      return const SizedBox.shrink();
    }

    final weekCount = grid[0].length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Month labels
          if (showLabels) ...[
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 4),
              child: SizedBox(
                height: 16,
                child: Row(
                  children: List.generate(weekCount, (colIndex) {
                    // Find if there's a month label for this column
                    final label = monthLabels.firstWhere(
                      (entry) => entry.key == colIndex,
                      orElse: () => const MapEntry(-1, ''),
                    );

                    if (label.key == colIndex) {
                      return SizedBox(
                        width: AppConstants.gridTileSize + AppConstants.gridTileGap,
                        child: Text(
                          label.value,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      width: AppConstants.gridTileSize + AppConstants.gridTileGap,
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 2),
          ],

          // Grid
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Weekday labels (Mon, Wed, Fri)
              if (showLabels)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildWeekdayLabel(''),  // Mon - no label
                      _buildWeekdayLabel(''),  // Tue - no label
                      _buildWeekdayLabel('Wed'),
                      _buildWeekdayLabel(''),  // Thu - no label
                      _buildWeekdayLabel('Fri'),
                      _buildWeekdayLabel(''),  // Sat - no label
                      _buildWeekdayLabel(''),  // Sun - no label
                    ],
                  ),
                ),

              // Grid tiles
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(7, (rowIndex) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(weekCount, (colIndex) {
                      final date = grid[rowIndex][colIndex];

                      return _GridTile(
                        date: date,
                        habit: habit,
                        onTap: date != null && onTileTap != null
                            ? () => onTileTap!(date)
                            : null,
                      );
                    }),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayLabel(String label) {
    return Container(
      height: AppConstants.gridTileSize + AppConstants.gridTileGap,
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 9,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  final DateTime? date;
  final Habit habit;
  final VoidCallback? onTap;

  const _GridTile({
    required this.date,
    required this.habit,
    this.onTap,
  });

  Color _getTileColor() {
    // Empty cell
    if (date == null) {
      return Colors.transparent;
    }

    // Get base color for the habit
    final habitColor = AppColors.fromHex(habit.color);
    final completion = habit.getCompletionForDate(date!);

    // Not completed - show very light tint
    if (completion == null) {
      return habitColor.withOpacity(0.15);
    }

    // Completed - determine color based on habit type

    // OR Options habits: Use option-specific colors
    if (habit.hasOrOptions && habit.orOptions != null) {
      if (completion.selectedOption == 'option1') {
        return AppColors.fromHex(habit.orOptions!.option1.color);
      } else if (completion.selectedOption == 'option2') {
        return AppColors.fromHex(habit.orOptions!.option2.color);
      } else if (completion.selectedOption == 'both') {
        // For 'both', use option1 color (could be gradient in future)
        return AppColors.fromHex(habit.orOptions!.option1.color);
      }
    }

    // Normal habit: Use full habit color
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
        margin: EdgeInsets.all(AppConstants.gridTileGap / 2),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(2.5),
        ),
      ),
    );
  }
}
