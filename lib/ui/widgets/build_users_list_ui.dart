import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'user_list_item.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';
import 'package:provider/provider.dart';


class BuildUsersListUi extends StatelessWidget {
  final List<User> users;
  BuildUsersListUi({this.users});

  @override
  Widget build(BuildContext context) {
    var vm = Provider.of<HomeViewModel>(context);

    print('List Genereted');
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: users.length,
      itemBuilder: (context, index) => UserListItem(
        user: users[index],
        onTap: () {
          Navigator.of(context).pushNamed(UserDetails.id, arguments: users[index]);
        },
        onLongTap: () {
          // TODO: アラートダイアログを表示する
          vm.removeUserId(users[index].userId);
        },
      ),
    );
  }
}
