import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:rubber/rubber.dart';
import 'package:tracker_status_atcoder/ui/widgets/a_little_above_floating_action_button.dart';
import 'package:tracker_status_atcoder/ui/widgets/build_users_list_ui.dart';
import '../../utils/settings.dart';
import 'home_viewmodel.dart';

class BaseHomeScreenWidget extends ProviderWidget<HomeViewModel> {
  final RubberAnimationController _rubberAnimationController;

  BaseHomeScreenWidget(
      this._rubberAnimationController); // ignore: avoid_positional_boolean_parameters
  void changeTheme(bool set, BuildContext context) {
    Provider.of<Settings>(context, listen: false).setDarkMode(set);
  }

  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _rubberAnimationController.expand();
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
      ),
      floatingActionButtonLocation: ALittleAboveEndFloatingActionButtonLocation(),
      appBar: AppBar(
        title: const Text('AtCoder Tracker'),
        leading: IconButton(
          icon: Icon(Provider.of<Settings>(context).isDarkMode
              ? Icons.brightness_high
              : Icons.brightness_low),
          onPressed: () {
            changeTheme(
                // ignore: avoid_bool_literals_in_conditional_expressions
                Provider.of<Settings>(context, listen: false).isDarkMode
                    ? false
                    : true,
                context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.INFO,
                  animType: AnimType.BOTTOMSLIDE,
                  tittle: '確認',
                  desc: '現在登録されている全てのデータを削除します',
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    model.allDeleteUserId();
                  }).show();
            },
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: model.state == ViewState.busy
          ? Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 15),
              child: BuildUsersListUi(usersMap: model.users))
          : Center(
              child: SpinKitCircle(
                color: Theme.of(context).accentColor,
              ),
            ),
    );
  }
}
