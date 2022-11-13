import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> preference;

  static const dailyReminder = 'DAILY_REMINDER';
  PreferencesHelper({required this.preference});

  Future<bool> get isDailyReminderActive async {
    final prefs = await preference;
    return prefs.getBool(dailyReminder) ?? false;
  }

  void setDailyReminder(bool value) async {
    final prefs = await preference;
    prefs.setBool(dailyReminder, value);
  }
}
