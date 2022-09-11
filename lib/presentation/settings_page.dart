import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restonest/provider/prefs_provider.dart';
import 'package:restonest/provider/schedule_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings_page';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Consumer<PrefsProvider>(
        builder: (context, provider, child) {
          return ListView(
            children: [
              Consumer<ScheduleProvider>(
                builder: (context, scheduled, _) {
                  return SwitchListTile.adaptive(
                    title: const Text('Notifications'),
                    value: provider.isDailyNotifEnabled, 
                    onChanged: (value) async {
                      scheduled.scheduledNotif(value);
                      provider.enableDailyNotif(value);
                    });
                }
              )
            ],
          );
        }
      ),
    );
  }
}
