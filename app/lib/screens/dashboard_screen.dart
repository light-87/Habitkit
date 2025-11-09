import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/habit_provider.dart';
import '../providers/premium_provider.dart';
import '../widgets/habit_card.dart';
import '../utils/constants.dart';
import 'add_habit_screen.dart';
import 'habit_detail_screen.dart';
import 'statistics_screen.dart';
import 'settings_screen.dart';
import 'premium_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumProvider = context.watch<PremiumProvider>();

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.displaySmall,
            children: const [
              TextSpan(text: 'Habit'),
              TextSpan(
                text: 'Kit',
                style: TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        actions: [
          // PRO badge button
          if (!premiumProvider.isPremium)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PremiumScreen(),
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  side: const BorderSide(color: Colors.black, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'PRO',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          // Stats button
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () {
              if (!premiumProvider.canViewStatistics) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PremiumScreen(),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatisticsScreen(),
                  ),
                );
              }
            },
          ),
          // Add button
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddHabitScreen(),
                ),
              );
              // TODO: Navigate to stats screen
            },
          ),
          // Settings button
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to settings screen
            },
          ),
        ],
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final habits = habitProvider.habits;

          if (habits.isEmpty) {
            return _buildEmptyState(context);
          }

          return RefreshIndicator(
            onRefresh: () async {
              await habitProvider.loadHabits();
            },
            child: ListView(
              padding: const EdgeInsets.only(
                top: AppConstants.spacingMD,
                bottom: 100, // Space for FAB
              ),
              children: [
                // Stats Card
                _buildStatsCard(context, habitProvider.stats),

                // Tags Filter
                if (habitProvider.allTags.isNotEmpty)
                  _buildTagsFilter(context, habitProvider),

                const SizedBox(height: AppConstants.spacingMD),

                // Habits List
                ...habits.map((habit) => HabitCard(
                      habit: habit,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HabitDetailScreen(habit: habit),
                          ),
                        );
                      },
                      onComplete: () {
                        if (habit.hasOrOptions && habit.orOptions != null) {
                          // Show OR options picker
                          _showOrOptionsPicker(context, habit.id);
                        } else {
                          // Toggle completion directly
                          habitProvider.toggleCompletion(habitId: habit.id);
                        }
                      },
                    )),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: _buildViewModeSwitcher(context),
    );
  }

  Widget _buildViewModeSwitcher(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 80,
        vertical: 20,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildViewModeButton(
              icon: Icons.grid_view,
              isSelected: true,
              onTap: () {},
            ),
            _buildViewModeButton(
              icon: Icons.check_box_outlined,
              isSelected: false,
              onTap: () {},
            ),
            _buildViewModeButton(
              icon: Icons.list,
              isSelected: false,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewModeButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? AppColors.primary : Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🌱',
            style: const TextStyle(fontSize: 64),
          ),
          const SizedBox(height: AppConstants.spacingLG),
          Text(
            'No habits yet',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppConstants.spacingSM),
          Text(
            'Tap the button below to create your first habit',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(BuildContext context, Map<String, dynamic> stats) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMD,
        vertical: AppConstants.spacingSM,
      ),
      padding: const EdgeInsets.all(AppConstants.spacingLG),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLG),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            '${stats['completedToday']}/${stats['totalHabits']}',
            'Completed Today',
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          _buildStatItem(
            context,
            '${stats['totalCompletions']}',
            'Total',
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          _buildStatItem(
            context,
            '${(stats['averageStreak'] as double).toStringAsFixed(1)}',
            'Avg Streak',
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
        ),
      ],
    );
  }

  Widget _buildTagsFilter(BuildContext context, HabitProvider provider) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingMD,
        ),
        children: [
          // All filter
          Padding(
            padding: const EdgeInsets.only(right: AppConstants.spacingSM),
            child: FilterChip(
              label: const Text('All'),
              selected: provider.selectedTag == null,
              onSelected: (_) => provider.setSelectedTag(null),
            ),
          ),

          // Tag filters
          ...provider.allTags.map((tag) => Padding(
                padding: const EdgeInsets.only(right: AppConstants.spacingSM),
                child: FilterChip(
                  label: Text(tag),
                  selected: provider.selectedTag == tag,
                  onSelected: (_) => provider.setSelectedTag(tag),
                ),
              )),
        ],
      ),
    );
  }

  void _showOrOptionsPicker(BuildContext context, String habitId) {
    final habitProvider = context.read<HabitProvider>();
    final habit = habitProvider.getHabitById(habitId);

    if (habit == null || !habit.hasOrOptions || habit.orOptions == null) {
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusXL),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(AppConstants.spacingLG),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'How did you ${habit.name}?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.spacingLG),

            // Option 1
            _buildOrOptionButton(
              context,
              habit.orOptions!.option1.icon ?? '',
              habit.orOptions!.option1.name,
              AppColors.fromHex(habit.orOptions!.option1.color),
              () {
                habitProvider.toggleCompletion(
                  habitId: habitId,
                  selectedOption: 'option1',
                );
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: AppConstants.spacingMD),

            // Option 2
            _buildOrOptionButton(
              context,
              habit.orOptions!.option2.icon ?? '',
              habit.orOptions!.option2.name,
              AppColors.fromHex(habit.orOptions!.option2.color),
              () {
                habitProvider.toggleCompletion(
                  habitId: habitId,
                  selectedOption: 'option2',
                );
                Navigator.pop(context);
              },
            ),

            const SizedBox(height: AppConstants.spacingMD),

            // Both button (optional)
            TextButton(
              onPressed: () {
                habitProvider.toggleCompletion(
                  habitId: habitId,
                  selectedOption: 'both',
                );
                Navigator.pop(context);
              },
              child: const Text('Both'),
            ),

            const SizedBox(height: AppConstants.spacingSM),
          ],
        ),
      ),
    );
  }

  Widget _buildOrOptionButton(
    BuildContext context,
    String icon,
    String name,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusMD),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppConstants.spacingLG),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMD),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon.isNotEmpty) ...[
              Text(icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppConstants.spacingMD),
            ],
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
