import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';

import '../database/preferences_helper.dart';
import '../notifications/background_service.dart';
import '../notifications/date_time_helper.dart';

class SettingProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  SettingProvider({required this.preferencesHelper}) {
    _getDailyReminderPreferences();
  }

  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  void _getDailyReminderPreferences() async {
    _isDailyReminderActive = await preferencesHelper.isDailyReminderActive;
    notifyListeners();
  }

  Future<bool> enableDailyReminder(bool value) async {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
    if (!_isDailyReminderActive) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
