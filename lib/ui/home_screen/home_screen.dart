import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:tracker_status_atcoder/ui/add_screen/add_screen.dart';
import 'package:tracker_status_atcoder/ui/widgets/user_list_item.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';

class HomeScreen extends StatelessWidget {
  static const String id = '/home_screen';

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Tracker Status'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
          child: getUsersUi(model.users),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddScreen.id);
          },
        ),
      ),
    );
  }

  Widget getUsersUi(List<User> users) => GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: users.length,
        itemBuilder: (context, index) => UserListItem(
          user: users[index],
          onTap: () {
//          Navigator.pushNamed(context, '/post', arguments: users[index]);
          },
        ),
      );
}
