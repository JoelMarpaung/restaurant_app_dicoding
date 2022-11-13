import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/setting_provider.dart';

class SettingListPage extends StatelessWidget {
  const SettingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(context),
              _dailyReminder(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.blueGrey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settingTitle,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 10),
              Text(
                secondarySettingTitle,
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _dailyReminder(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dailyReminderTitle, style: Theme.of(context).textTheme.subtitle1,),
                Switch.adaptive(
                  value: provider.isDailyReminderActive,
                  onChanged: (value) async {
                    provider.enableDailyReminder(value);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
