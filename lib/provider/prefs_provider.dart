import 'package:flutter/cupertino.dart';

import '../data/preferences/shared_preferences.dart';

class PrefsProvider extends ChangeNotifier {
  PrefsHelper prefsHelper;

  PrefsProvider({required this.prefsHelper}) {
    _getDailyPrefs();
  }

  bool _isDailyNotifEnabled = false;
  bool get isDailyNotifEnabled => _isDailyNotifEnabled;

  void _getDailyPrefs() async {
    _isDailyNotifEnabled = await prefsHelper.isDailyNotifEnabled;
    notifyListeners();
  }

  void enableDailyNotif(bool value) {
    prefsHelper.setDailyNotif(value);
    _getDailyPrefs();
  }
}