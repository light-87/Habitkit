import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../utils/constants.dart';
import 'habit_grid.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;
  final VoidCallback onComplete;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onTap,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isCompletedToday = habit.isCompletedOn(DateTime.now());
    final habitColor = AppColors.fromHex(habit.color);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMD,
        vertical: AppConstants.spacingSM,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                children: [
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: habitColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                    ),
                    child: Center(
                      child: Text(
                        habit.icon,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMD),

                  // Name and Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          habit.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        if (habit.description.isNotEmpty)
                          Text(
                            habit.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),

                  // Complete Button
                  GestureDetector(
                    onTap: onComplete,
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isCompletedToday
                            ? habitColor
                            : habitColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                      ),
                      child: Icon(
                        Icons.check,
                        color: isCompletedToday ? Colors.white : habitColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppConstants.spacingMD),

              // Grid Visualization (compact year view)
              SizedBox(
                height: 130,
                child: HabitGrid(
                  habit: habit,
                  months: 7,
                  showLabels: true,
                ),
              ),

              // Stats Row
              if (habit.currentStreak > 0 || habit.hasOrOptions)
                Padding(
                  padding: const EdgeInsets.only(top: AppConstants.spacingSM),
                  child: Row(
                    children: [
                      if (habit.currentStreak > 0) ...[
                        const Icon(Icons.local_fire_department,
                            size: 16, color: AppColors.warning),
                        const SizedBox(width: 4),
                        Text(
                          '${habit.currentStreak} day streak',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],

                      if (habit.hasOrOptions && habit.orOptions != null) ...[
                        const SizedBox(width: AppConstants.spacingMD),
                        _buildOrOptionStats(),
                      ],
                    ],
                  ),
                ),

              // Tags
              if (habit.tags.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: AppConstants.spacingSM),
                  child: Wrap(
                    spacing: AppConstants.spacingSM,
                    children: habit.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              labelStyle:
                                  Theme.of(context).textTheme.bodySmall,
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppConstants.spacingSM,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrOptionStats() {
    final stats = habit.orOptionStats;
    final option1Count = stats['option1'] ?? 0;
    final option2Count = stats['option2'] ?? 0;

    return Row(
      children: [
        // Option 1
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingSM,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.fromHex(habit.orOptions!.option1.color)
                .withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          ),
          child: Text(
            '${habit.orOptions!.option1.icon ?? ''} $option1Count',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(width: 4),
        // Option 2
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingSM,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: AppColors.fromHex(habit.orOptions!.option2.color)
                .withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.radiusSM),
          ),
          child: Text(
            '${habit.orOptions!.option2.icon ?? ''} $option2Count',
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
