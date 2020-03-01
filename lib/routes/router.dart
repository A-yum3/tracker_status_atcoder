import 'package:auto_route/auto_route_annotations.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_screen.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  HomeScreen homeScreenRoute;

  UserDetails userDetailsRoute;

}