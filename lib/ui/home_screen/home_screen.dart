import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rubber/rubber.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/ui/home_screen/add_screen.dart';
import 'base_home_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
      duration: Duration(milliseconds: 200),
      lowerBoundValue: AnimationControllerValue(pixel: 35.0),
      upperBoundValue: AnimationControllerValue(pixel: 420.0),
      vsync: this, // Thanks to the mixin
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: RubberBottomSheet(
        lowerLayer: BaseHomeScreenWidget(),
        upperLayer: AddScreen(_controller),
        animationController: _controller,
      ),
    );
  }
}
