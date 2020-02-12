import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'user_list_item.dart';


class BuildUsersListUi extends StatelessWidget {
  final List<User> users;
  BuildUsersListUi({this.users});

  @override
  Widget build(BuildContext context) {
    print('List Genereted');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) => UserListItem(
        user: users[index],
        onTap: () {
         // TODO: ユーザーごとの詳細ページに遷移する処理
          // 仮実装
          Navigator.of(context).pushNamed(UserDetails.id, arguments: users[index]);
        },
      ),
    );
  }
}
