import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';
import 'package:tracker_status_atcoder/routes/router.gr.dart';
import 'package:tracker_status_atcoder/utils/settings.dart';
import 'package:tracker_status_atcoder/utils/themes.dart';

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
      onGenerateRoute: Router.onGenerateRoute,
      navigatorKey: Router.navigator.key,
      initialRoute: Router.homeScreenRoute,
    );
  }
}
