import 'package:hive/hive.dart';

class PremiumService {
  static const String _boxName = 'settings';
  static const String _premiumKey = 'isPremium';

  // Singleton pattern
  static final PremiumService _instance = PremiumService._internal();
  factory PremiumService() => _instance;
  PremiumService._internal();

  Box? _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  bool get isPremium {
    return _box?.get(_premiumKey, defaultValue: false) ?? false;
  }

  Future<void> setPremium(bool value) async {
    await _box?.put(_premiumKey, value);
  }

  Future<void> unlockPremium() async {
    await setPremium(true);
  }

  Future<void> resetPremium() async {
    await setPremium(false);
  }

  // Premium feature checks
  bool canCreateMoreHabits(int currentHabitCount) {
    if (isPremium) return true;
    return currentHabitCount < 5; // Free tier limit
  }

  bool canUseMultipleReminders() => isPremium;
  bool canUseWidgets() => isPremium;
  bool canViewStatistics() => isPremium;
  bool canCustomizeDashboard() => isPremium;
  bool canUseCompactList() => isPremium;
  bool canExportData() => isPremium;
  bool canImportData() => isPremium;
  bool canAccessArchivedHabits() => isPremium;
}
