import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'HabitKit';
  static const String appVersion = '1.0.0';

  // Free tier limits
  static const int freeHabitLimit = 5;

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingSM = 8.0;
  static const double spacingMD = 16.0;
  static const double spacingLG = 24.0;
  static const double spacingXL = 32.0;

  // Border Radius
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;

  // Grid
  static const double gridTileSize = 12.0;
  static const double gridTileGap = 3.0;

  // Animation Duration
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}

class AppColors {
  // Brand Colors
  static const primary = Color(0xFF8B5CF6); // Purple
  static const primaryLight = Color(0xFFA78BFA);
  static const primaryDark = Color(0xFF7C3AED);

  // Background
  static const background = Color(0xFFF5F5F5);
  static const cardBackground = Colors.white;
  static const scaffoldBackground = Color(0xFFF9FAFB);

  // Text
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  // UI Elements
  static const divider = Color(0xFFE5E7EB);
  static const border = Color(0xFFD1D5DB);

  // Status Colors
  static const success = Color(0xFF10B981);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);
  static const info = Color(0xFF3B82F6);

  // Habit Colors (21 colors matching HabitKit)
  static const List<Color> habitColors = [
    Color(0xFFEF4444), // Red
    Color(0xFFF97316), // Orange
    Color(0xFFF59E0B), // Amber
    Color(0xFFEAB308), // Yellow
    Color(0xFF84CC16), // Lime
    Color(0xFF22C55E), // Green
    Color(0xFF10B981), // Emerald
    Color(0xFF14B8A6), // Teal
    Color(0xFF06B6D4), // Cyan
    Color(0xFF0EA5E9), // Sky
    Color(0xFF3B82F6), // Blue
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple (default)
    Color(0xFFA855F7), // Violet
    Color(0xFFD946EF), // Fuchsia
    Color(0xFFEC4899), // Pink
    Color(0xFFF43F5E), // Rose
    Color(0xFF64748B), // Slate
    Color(0xFF6B7280), // Gray
    Color(0xFF78716C), // Stone
    Color(0xFF57534E), // Brown
  ];

  // Helper to get color from hex string
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // Helper to convert color to hex string
  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).substring(2).toUpperCase()}';
  }

  // Get grid tile color based on completion
  static Color getGridTileColor(bool isCompleted, {double intensity = 1.0}) {
    if (!isCompleted) {
      return const Color(0xFFE5E7EB); // Light gray for empty
    }
    return primary.withOpacity(0.3 + (0.7 * intensity));
  }
}

// Habit Icons (emojis for now, can be replaced with custom icons)
class HabitIcons {
  static const List<String> icons = [
    '💪', // Gym/Fitness
    '📚', // Study/Read
    '🏃', // Running
    '🧘', // Yoga/Meditation
    '💧', // Water
    '🍎', // Healthy eating
    '🎨', // Creative
    '✍️', // Writing
    '🎵', // Music
    '🎮', // Gaming
    '📱', // Phone/Tech
    '💼', // Work
    '🏠', // Home
    '🧹', // Cleaning
    '🛏️', // Sleep
    '☕', // Coffee
    '🚶', // Walking
    '🚴', // Cycling
    '🏊', // Swimming
    '🎯', // Goals
    '📖', // Reading
    '🖥️', // Computer
    '🎬', // Movies
    '🎸', // Guitar
    '🏋️', // Weightlifting
    '🥗', // Salad/Diet
    '🍵', // Tea
    '🌱', // Plant/Growth
    '⭐', // Star
    '🔥', // Fire/Streak
    '💡', // Ideas
    '🎓', // Education
    '💰', // Money/Finance
    '❤️', // Health/Love
    '🌙', // Night/Sleep
    '☀️', // Morning/Day
    '🎉', // Celebration
    '🏆', // Achievement
    '📝', // Notes
    '🔔', // Reminder
  ];

  static String getRandomIcon() {
    return icons[DateTime.now().millisecondsSinceEpoch % icons.length];
  }
}
