import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:rubber/rubber.dart';
import 'package:tracker_status_atcoder/ui/widgets/user_list_item.dart';
import 'home_viewmodel.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/add_screen/add_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  RubberAnimationController _controller;

  @override
  void initState() {
    _controller = RubberAnimationController(
      duration: Duration(milliseconds: 200),
      lowerBoundValue: AnimationControllerValue(pixel: 35.0),
      upperBoundValue: AnimationControllerValue(pixel: 500.0),
      vsync: this, // Thanks to the mixin
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RubberBottomSheet(
      lowerLayer: BaseHomeScreenWidget(),
      upperLayer: AddScreen(),
      animationController: _controller,
    );
  }
}

class BaseHomeScreenWidget extends StatelessWidget {
  const BaseHomeScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 15.0),
        child: ViewModelProvider<HomeViewModel>.withConsumer(
          viewModel: HomeViewModel(),
          onModelReady: (model) => model.initialize(),
          builder: (context, model, child) => getUsersUi(model.users),
        ),
      ),
    );
  }
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

//ViewModelProvider<HomeViewModel>.withConsumer(
//viewModel: HomeViewModel(),
//onModelReady: (model) => model.initialize(),
//builder: (context, model, child) =>
//
//getUsersUi(model.users),
