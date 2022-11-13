import 'package:flutter/foundation.dart';

import '../database/preferences_helper.dart';

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

  void enableDailyReminder(bool value) {
    preferencesHelper.setDailyReminder(value);
    _getDailyReminderPreferences();
  }
}
