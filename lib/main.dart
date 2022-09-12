import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restonest/common/navigation.dart';
import 'package:restonest/common/styles.dart';
import 'package:restonest/data/notification/background_service.dart';
import 'package:restonest/data/notification/notif_helper.dart';
import 'package:restonest/data/preferences/shared_preferences.dart';
import 'package:restonest/presentation/detail_page.dart';
import 'package:restonest/presentation/favorite_page.dart';
import 'package:restonest/presentation/home_page.dart';
import 'package:restonest/presentation/search_page.dart';
import 'package:restonest/presentation/settings_page.dart';
import 'package:restonest/provider/database_provider.dart';
import 'package:restonest/provider/detail_provider.dart';
import 'package:restonest/provider/prefs_provider.dart';
import 'package:restonest/provider/restaurants_provider.dart';
import 'package:restonest/provider/schedule_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/api/api_service.dart';
import 'data/db/db_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotifHelper notifHelper = NotifHelper();
  final BackgroundService backgroundService = BackgroundService();

  backgroundService.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notifHelper.initNotif(flutterLocalNotificationsPlugin);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantsProvider>(
          create: (_) => RestaurantsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(dbHelper: DbHelper()),
        ),
        ChangeNotifierProvider<DetailProvider>(
          create: (_) => DetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ScheduleProvider>(
            create: (_) => ScheduleProvider()),
        ChangeNotifierProvider<PrefsProvider>(
            create: (_) => PrefsProvider(
                prefsHelper:
                    PrefsHelper(sharedPrefs: SharedPreferences.getInstance()))),
      ],
      child: MaterialApp(
        title: 'RESTONEST',
        theme: ThemeData(
          primarySwatch: createMaterialColor(themeColor),
        ),
        navigatorKey: navigatorGlobalKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          DetailPage.routeName: (context) => const DetailPage(),
          SettingsPage.routeName: (context) => const SettingsPage(),
          FavoritePage.routeName: (context) => const FavoritePage(),
        },
      ),
    );
  }
}
