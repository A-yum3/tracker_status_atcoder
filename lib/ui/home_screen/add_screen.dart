import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';
import 'package:rubber/rubber.dart';

class AddScreen extends StatefulWidget {
  static const String id = '/add_screen';

  final RubberAnimationController _rubberAnimationController;

  AddScreen(this._rubberAnimationController);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _tController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _tController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("input: ${_tController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        height: 800,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.maximize,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                'ユーザー追加',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Theme.of(context).accentColor,
                  decoration: TextDecoration.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _tController,
                  decoration: InputDecoration(
                    hintText: 'ユーザー名を入力してください',
                    enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(width: 0.0),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              ViewModelProvider<HomeViewModel>.withConsumer(
                reuseExisting: true,
                viewModel: locator<HomeViewModel>(),
                builder: (context, model, child) {
                  return RaisedButton.icon(
                    elevation: 16.0,
                    icon: Icon(Icons.input),
                    label: Text("Add"),
                    onPressed: () async {
                      // TODO:　ここらへんのリファクタリングと表示の修正
                      bool success = await model
                          .registerUserNameAndCheck(_tController.text);
                      if (success) {
                        _tController.clear();
                        widget._rubberAnimationController.collapse();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Error!!'),
                                content: Text('ユーザーは登録されていないか\n'
                                    '既に追加されています。\n'
                                    '\n'
                                    '１０件以上は登録ができません'),
                              );
                            });
                        _tController.clear();
                      }
                    },
                    color: Theme.of(context).buttonColor,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
