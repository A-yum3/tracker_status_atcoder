import 'package:flutter/material.dart';
import 'package:rubber/rubber.dart';
import 'package:tracker_status_atcoder/ui/home_screen/add_screen.dart';
import '../../locator.dart';
import 'base_home_screen.dart';
import 'package:provider_architecture/provider_architecture.dart';

import 'home_viewmodel.dart';

class HomeScreen extends StatefulWidget {

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
    return ViewModelProvider<HomeViewModel>.withoutConsumer(
        onModelReady: (model) => model.initialize(),
        reuseExisting: true,
        viewModel: locator<HomeViewModel>(),
        builder: (context, model, _) => RubberBottomSheet(
              lowerLayer: BaseHomeScreenWidget(),
              upperLayer: AddScreen(_controller),
              animationController: _controller,
            ));
  }
}
