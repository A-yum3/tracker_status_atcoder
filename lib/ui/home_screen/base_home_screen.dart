import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/ui/widgets/build_users_list_ui.dart';

class BaseHomeScreenWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker Status'),
        // Shared削除の仮実装
        actions: <Widget>[
          GestureDetector(
            child: Icon(Icons.clear),
            onTap: () {
              vm.allDeleteUserId();
            },
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
        child: BuildUsersListUi(users: vm.users),
      ),
    );
  }
}
