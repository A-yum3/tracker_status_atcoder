import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/ui/widgets/build_users_list_ui.dart';

class BaseHomeScreenWidget extends ProviderWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tracker Status'),
          actions: <Widget>[
            GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
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
                  color: Colors.white,
                ),
              ));
  }
}
