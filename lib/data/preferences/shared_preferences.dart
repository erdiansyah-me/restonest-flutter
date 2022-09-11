import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  final Future<SharedPreferences> sharedPrefs;

  PrefsHelper({required this.sharedPrefs});

  static const dailyNotif = 'DAILY_NOTIF';

  Future<bool> get isDailyNotifEnabled async {
    final prefs = await sharedPrefs;
    return prefs.getBool(dailyNotif) ?? false;
  }

  void setDailyNotif(bool value) async {
    final prefs = await sharedPrefs;
    prefs.setBool(dailyNotif, value);
  }
}