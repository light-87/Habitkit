import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/habit.dart';
import '../providers/habit_provider.dart';
import '../widgets/habit_grid.dart';
import '../utils/constants.dart';
import '../utils/date_utils.dart' as app_date_utils;

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;

  const HabitDetailScreen({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final habitColor = AppColors.fromHex(habit.color);

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              _showOptionsMenu(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.spacingLG),
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: habitColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMD),
                ),
                child: Center(
                  child: Text(
                    habit.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.spacingMD),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    if (habit.description.isNotEmpty)
                      Text(
                        habit.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingXL),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard(
                context,
                '${habit.currentStreak}',
                'Current Streak',
                Icons.local_fire_department,
                AppColors.warning,
              ),
              _buildStatCard(
                context,
                '${habit.longestStreak}',
                'Best Streak',
                Icons.emoji_events,
                AppColors.primary,
              ),
              _buildStatCard(
                context,
                '${habit.totalCompletions}',
                'Total',
                Icons.check_circle,
                AppColors.success,
              ),
            ],
          ),

          const SizedBox(height: AppConstants.spacingXL),

          // OR Options Stats (if enabled)
          if (habit.hasOrOptions && habit.orOptions != null) ...[
            Text(
              'Options Breakdown',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingMD),
            _buildOrOptionsStats(context),
            const SizedBox(height: AppConstants.spacingXL),
          ],

          // Grid Visualization
          Text(
            'History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: AppConstants.spacingMD),
          SizedBox(
            height: 130,
            child: HabitGrid(
              habit: habit,
              months: 6,
              showLabels: true,
              onTileTap: (date) {
                _showDayOptions(context, date);
              },
            ),
          ),

          const SizedBox(height: AppConstants.spacingXL),

          // Delete Button
          OutlinedButton(
            onPressed: () {
              _confirmDelete(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
            ),
            child: const Text('Delete Habit'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMD),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: AppConstants.spacingSM),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildOrOptionsStats(BuildContext context) {
    final stats = habit.orOptionStats;
    final option1Count = stats['option1'] ?? 0;
    final option2Count = stats['option2'] ?? 0;
    final total = stats['total'] ?? 1;

    final option1Percentage = ((option1Count / total) * 100).round();
    final option2Percentage = ((option2Count / total) * 100).round();

    return Column(
      children: [
        // Option 1
        Row(
          children: [
            Text(
              habit.orOptions!.option1.icon ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: AppConstants.spacingSM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.orOptions!.option1.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  LinearProgressIndicator(
                    value: option1Count / total,
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.fromHex(habit.orOptions!.option1.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.spacingMD),
            Text(
              '$option1Count ($option1Percentage%)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(height: AppConstants.spacingMD),

        // Option 2
        Row(
          children: [
            Text(
              habit.orOptions!.option2.icon ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: AppConstants.spacingSM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.orOptions!.option2.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  LinearProgressIndicator(
                    value: option2Count / total,
                    backgroundColor: AppColors.divider,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.fromHex(habit.orOptions!.option2.color),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.spacingMD),
            Text(
              '$option2Count ($option2Percentage%)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }

  void _showDayOptions(BuildContext context, DateTime date) {
    final habitProvider = context.read<HabitProvider>();
    final isCompleted = habit.isCompletedOn(date);

    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              app_date_utils.DateUtils.formatDate(date),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingLG),
            if (isCompleted)
              ListTile(
                leading: const Icon(Icons.close),
                title: const Text('Remove completion'),
                onTap: () {
                  habitProvider.uncompleteHabit(
                    habitId: habit.id,
                    date: date,
                  );
                  Navigator.pop(context);
                },
              )
            else
              ListTile(
                leading: const Icon(Icons.check),
                title: const Text('Mark as complete'),
                onTap: () {
                  habitProvider.completeHabit(
                    habitId: habit.id,
                    date: date,
                  );
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () {
              context.read<HabitProvider>().archiveHabit(habit.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: Text('Are you sure you want to delete "${habit.name}"? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<HabitProvider>().deleteHabit(habit.id);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
