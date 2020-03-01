import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../settings.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/ui/widgets/build_users_list_ui.dart';
import 'package:provider/provider.dart';

class BaseHomeScreenWidget extends ProviderWidget<HomeViewModel> {

  void changeTheme(bool set, BuildContext context) {
    Provider.of<Settings>(context, listen: false).setDarkMode(set);
  }

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
        appBar: AppBar(
          title: Text('AtCoder Tracker'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Provider.of<Settings>(context).isDarkMode
                  ? Icons.brightness_high
                  : Icons.brightness_low),
              onPressed: () {
                changeTheme(
                    Provider.of<Settings>(context, listen: false).isDarkMode ? false : true, context);
              },
            ),
            IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                model.allDeleteUserId();
              },
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        body: model.state == ViewState.Busy
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
                child: BuildUsersListUi(usersMap: model.users))
            : Center(
                child: SpinKitCircle(
                  color: Theme.of(context).accentColor,
                ),
              ));
  }
}
