import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/locator.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_screen.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';

void main() {
  setupServiceLocator();
  runApp(TrackerStatusAtCoderApp());
}

class TrackerStatusAtCoderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        UserDetails.id : (context) => UserDetails(),
      },
    );
  }
}
