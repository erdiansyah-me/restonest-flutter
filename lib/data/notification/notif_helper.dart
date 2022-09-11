import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restonest/common/navigation.dart';
import 'package:restonest/data/api/api_service.dart';
import 'package:restonest/data/model/restaurants.dart';
import 'package:rxdart/rxdart.dart';

final notifSubject = BehaviorSubject<String>();

class NotifHelper {
  static NotifHelper? _instance;

  NotifHelper._internal() {
    _instance = this;
  }

  factory NotifHelper() => _instance ?? NotifHelper._internal();

  Future<void> initNotif(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('ic_notif');

    var iosInitializationSettings = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestSoundPermission: false,
      requestBadgePermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notif payload$payload');
      }
      notifSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotif(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var channelId = '1';
    var channelName = 'restorand_01';
    var channelDesc = 'RestoNest Random Channel';

    var restoList = await ApiService().allRestaurants();
    var restoRandList = restoList.restaurants.toList();

    var randIndex = Random().nextInt(restoRandList.length);
    var randResto = restoRandList[randIndex];

    var androidNotifDetail = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );
    var iosNotifDetail = const IOSNotificationDetails();
    var platformNotifDetail = NotificationDetails(
      android: androidNotifDetail,
      iOS: iosNotifDetail,
    );

    var notifTitle = '<b>Random Restaurant</b>';
    var bodyNotif = randResto.name;

    await flutterLocalNotificationsPlugin.show(
        0, notifTitle, bodyNotif, platformNotifDetail,
        payload: json.encode(randResto.toJson()));
  }

  void configureNotifSubject(String route) {
    notifSubject.stream.listen(
      (payload) {
        var data = Restaurant.fromJson(json.decode(payload));
        var restaurant = data.id;
        Navigation.intentWithData(route, restaurant);
      });
  }
}
