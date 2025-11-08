import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/premium_provider.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Center(
                      child: Text(
                        'Unlock HabitKit Pro',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Features List
                    _buildFeature(
                      icon: Icons.tag,
                      color: Colors.teal,
                      title: 'Unlimited number of habits',
                      subtitle: 'Unlimited possibilities by creating as many habits as you like',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.widgets,
                      color: Colors.blue,
                      title: 'Home Screen Widgets',
                      subtitle: 'Show your favorite habits on your home screen',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.notifications,
                      color: Colors.red,
                      title: 'Multiple Reminders',
                      subtitle: 'Add up to three reminders for the same habit',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.trending_up,
                      color: Colors.orange,
                      title: 'Charts & Statistics',
                      subtitle: 'See charts and statistics about your consistency',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.dashboard_customize,
                      color: Colors.teal,
                      title: 'Dashboard Customization',
                      subtitle: 'Show streaks and goals, show labels and categories',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.list,
                      color: Colors.teal,
                      title: 'Compact List',
                      subtitle: 'Configure the amount of days to display and the visibility of the habit names in the compact list',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.upload,
                      color: Colors.blue,
                      title: 'Export your data',
                      subtitle: 'Generate a file from your habits and completions',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.download,
                      color: Colors.red,
                      title: 'Import your data',
                      subtitle: 'Switching phones? Restore a previously exported backup',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.archive,
                      color: Colors.orange,
                      title: 'Restore archived habits',
                      subtitle: 'Pausing a specific habit? Just archive it and continue later',
                    ),
                    const SizedBox(height: 16),

                    _buildFeature(
                      icon: Icons.star,
                      color: Colors.purple,
                      title: 'Support an Indie Developer',
                      subtitle: 'Your purchase supports an independent app developer',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // For now, just unlock premium (in a real app, this would integrate with payment)
                    await context.read<PremiumProvider>().unlockPremium();
                    if (context.mounted) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Premium unlocked! Thank you for your support!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
