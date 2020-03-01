import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_status_atcoder/locator.dart';
import 'package:tracker_status_atcoder/settings.dart';
import 'package:tracker_status_atcoder/themes.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_screen.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        return ChangeNotifierProvider<Settings>.value(
          value: Settings(snapshot.data),
          child: TrackerStatusAtCoderApp(),
        );
      },
    );
  }
}

class TrackerStatusAtCoderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<Settings>(context).isDarkMode
          ? setDarkTheme
          : setLightTheme,
      home: HomeScreen(),
      routes: {
        UserDetails.id: (context) => UserDetails(),
      },
    );
  }
}
