// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_screen.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';

class Router {
  static const homeScreenRoute = '/';
  static const userDetailsRoute = '/user-details-route';
  static final navigator = ExtendedNavigator();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.homeScreenRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomeScreen(),
          settings: settings,
        );
      case Router.userDetailsRoute:
        if (hasInvalidArgs<User>(args)) {
          return misTypedArgsRoute<User>(args);
        }
        final typedArgs = args as User;
        return MaterialPageRoute<dynamic>(
          builder: (_) => UserDetails(typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
