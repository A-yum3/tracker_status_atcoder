import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'user_list_item.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';
import 'package:provider/provider.dart';

class BuildUsersListUi extends StatelessWidget {
  final LinkedHashMap<String, User> usersMap;
  BuildUsersListUi({this.usersMap});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<HomeViewModel>(context);
    List<User> users = [];
    if(usersMap != null) {
      usersMap.forEach((name, user) => users.add(user));
    }

    print('List Genereted');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) => UserListItem(
        user: users[index],
        onTap: () {
          Navigator.of(context)
              .pushNamed(UserDetails.id, arguments: users[index]);
        },
        onLongTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('確認'),
                  content: Text('${users[index].userId}を削除しますか？'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    FlatButton(
                      child: Text('OK'),
                      onPressed: () {
                        vm.removeUserName(users[index].userId);
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}
