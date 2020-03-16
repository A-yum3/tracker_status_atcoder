import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';
import 'package:rubber/rubber.dart';

class AddScreen extends StatefulWidget {
  const AddScreen(this._rubberAnimationController);
  static const String id = '/add_screen';

  final RubberAnimationController _rubberAnimationController;

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _tController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )),
        height: 800,
        width: double.infinity,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.maximize,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Text(
                'ユーザー追加',
                style: TextStyle(
                  fontSize: 32,
                  color: Theme.of(context).accentColor,
                  decoration: TextDecoration.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _tController,
                  decoration: const InputDecoration(
                    hintText: 'ユーザー名を入力してください',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 0),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ViewModelProvider<HomeViewModel>.withConsumer(
                reuseExisting: true,
                viewModel: locator<HomeViewModel>(),
                builder: (context, model, child) {
                  return RaisedButton.icon(
                    elevation: 16,
                    icon: Icon(Icons.input),
                    label: const Text('Add'),
                    onPressed: () async {
                      final success = await model
                          .registerUserNameAndCheck(_tController.text);
                      if (success) {
                        _tController.clear();
                        widget._rubberAnimationController.collapse();
                      } else {
                        // TODO: エラー内容によって表示を変える
                        await AwesomeDialog(
                          context: context,
                          animType: AnimType.BOTTOMSLIDE,
                          tittle: 'Error!',
                          btnOkOnPress: () {},
                          dialogType: DialogType.ERROR,
                          desc: 'ユーザーは登録されていないか\n'
                              '既に追加されています。\n'
                              '１０件以上は登録ができません。',
                        ).show();
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
