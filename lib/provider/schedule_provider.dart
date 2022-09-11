import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:restonest/data/notification/background_service.dart';
import 'package:restonest/data/notification/datetime_helper.dart';

class ScheduleProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNotif(bool value) async{
    _isScheduled = value;
    if(_isScheduled) {
      print('Notification Scheduled');
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
      print('Notification off');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}