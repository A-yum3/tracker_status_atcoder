import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/routes/router.gr.dart';
import 'user_list_card.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';

class BuildUsersListUi extends ProviderWidget<HomeViewModel> {
  final LinkedHashMap<String, User> usersMap;
  BuildUsersListUi({this.usersMap});

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    List<User> users = [];
    if (usersMap != null) {
      usersMap.forEach((name, user) => users.add(user));
    }
    print('List Genereted');

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) => UserListCard(
        user: users[index],
        onTap: () {
          Router.navigator
              .pushNamed(Router.userDetailsRoute, arguments: users[index]);
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
                        model.removeUserName(users[index].userId);
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
