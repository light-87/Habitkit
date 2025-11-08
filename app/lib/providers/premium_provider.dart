import 'package:flutter/foundation.dart';
import '../services/premium_service.dart';

class PremiumProvider extends ChangeNotifier {
  final PremiumService _premiumService = PremiumService();

  bool get isPremium => _premiumService.isPremium;

  Future<void> unlockPremium() async {
    await _premiumService.unlockPremium();
    notifyListeners();
  }

  Future<void> resetPremium() async {
    await _premiumService.resetPremium();
    notifyListeners();
  }

  bool canCreateMoreHabits(int currentHabitCount) {
    return _premiumService.canCreateMoreHabits(currentHabitCount);
  }

  bool get canUseMultipleReminders => _premiumService.canUseMultipleReminders();
  bool get canUseWidgets => _premiumService.canUseWidgets();
  bool get canViewStatistics => _premiumService.canViewStatistics();
  bool get canCustomizeDashboard => _premiumService.canCustomizeDashboard();
  bool get canUseCompactList => _premiumService.canUseCompactList();
  bool get canExportData => _premiumService.canExportData();
  bool get canImportData => _premiumService.canImportData();
  bool get canAccessArchivedHabits => _premiumService.canAccessArchivedHabits();
}
