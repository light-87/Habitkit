import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/premium_provider.dart';
import 'premium_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final premiumProvider = context.watch<PremiumProvider>();

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
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 48), // Balance the close button
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  // Premium Banner
                  if (!premiumProvider.isPremium)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PremiumScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Colors.teal, Colors.purple],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.grid_3x3,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(text: 'Subscribe to '),
                                        TextSpan(
                                          text: 'Habit',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: 'Kit',
                                          style: TextStyle(color: Colors.purple),
                                        ),
                                        TextSpan(text: ' Pro'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Unlimited habits, import/export data, ...',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // App Section
                  _buildSectionHeader('App'),
                  const SizedBox(height: 8),
                  _buildSettingsGroup(context, [
                    _buildSettingsTile(
                      icon: Icons.settings,
                      iconColor: Colors.pink,
                      title: 'General',
                      onTap: () {
                        // TODO: Navigate to general settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('General settings - Coming soon')),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.notifications,
                      iconColor: Colors.cyan,
                      title: 'Daily Check-In Reminders',
                      onTap: () {
                        // TODO: Navigate to reminders settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reminders settings - Coming soon')),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.palette,
                      iconColor: Colors.orange,
                      title: 'Theme',
                      onTap: () {
                        // TODO: Navigate to theme settings
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Theme settings - Coming soon')),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.archive,
                      iconColor: Colors.teal,
                      title: 'Archived Habits',
                      onTap: () {
                        if (!premiumProvider.canAccessArchivedHabits) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumScreen(),
                            ),
                          );
                        } else {
                          // TODO: Navigate to archived habits
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Archived habits - Coming soon')),
                          );
                        }
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.import_export,
                      iconColor: Colors.indigo,
                      title: 'Data Import/Export',
                      onTap: () {
                        if (!premiumProvider.canExportData) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PremiumScreen(),
                            ),
                          );
                        } else {
                          // TODO: Navigate to import/export
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Import/Export - Coming soon')),
                          );
                        }
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.reorder,
                      iconColor: Colors.red,
                      title: 'Reorder Habits',
                      onTap: () {
                        // TODO: Navigate to reorder habits
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Reorder habits - Coming soon')),
                        );
                      },
                      showDivider: false,
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Help Section
                  _buildSectionHeader('Help'),
                  const SizedBox(height: 8),
                  _buildSettingsGroup(context, [
                    _buildSettingsTile(
                      icon: Icons.school,
                      iconColor: Colors.orange,
                      title: 'Show Onboarding',
                      onTap: () {
                        // TODO: Show onboarding
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Onboarding - Coming soon')),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.article,
                      iconColor: Colors.blue,
                      title: "Show What's New",
                      onTap: () {
                        // TODO: Show what's new
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("What's new - Coming soon")),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.feedback,
                      iconColor: Colors.black,
                      title: 'Send feedback',
                      onTap: () {
                        // TODO: Send feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Feedback - Coming soon')),
                        );
                      },
                      showDivider: false,
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // About Section
                  _buildSectionHeader('About'),
                  const SizedBox(height: 8),
                  _buildSettingsGroup(context, [
                    _buildSettingsTile(
                      icon: Icons.language,
                      iconColor: Colors.teal,
                      title: 'Website',
                      onTap: () {
                        // TODO: Open website
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Website - Coming soon')),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      icon: Icons.close,
                      iconColor: Colors.blue,
                      title: 'Follow on X',
                      onTap: () {
                        // TODO: Open X/Twitter
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Follow on X - Coming soon')),
                        );
                      },
                      showDivider: false,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey[700],
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(BuildContext context, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 80,
            endIndent: 16,
            color: Colors.grey[200],
          ),
      ],
    );
  }
}
