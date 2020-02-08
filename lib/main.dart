import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_screen.dart';
import 'ui/add_screen/add_screen.dart';

void main() => runApp(TrackerStatusAtCoderApp());

class TrackerStatusAtCoderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
      routes: {
        AddScreen.id: (context) => AddScreen(),
      },
    );
  }
}
