import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final vm = Provider.of<HomeViewModel>(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[900],
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
                  color: Colors.white,
                ),
              ),
              Text(
                'Add UserID',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _tController,
                  decoration: InputDecoration(
                    hintText: 'Enter User Id',
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Consumer<HomeViewModel>(
                builder: (context, model, child) {
                  return RaisedButton.icon(
                    elevation: 16.0,
                    icon: Icon(Icons.input),
                    label: Text("Add"),
                    onPressed: () {
                      // TODO:　ここらへんのリファクタリングと表示の修正
                      // TODO:　既にユーザーが登録されている場合は登録を行わない処理
                      vm
                          .checkUserIsRegistered(_tController.text)
                          .then((already) {
                        if (already) {
                          vm.registerUserName(_tController.text);
                          _tController.clear();
                          widget._rubberAnimationController.collapse();
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error!!'),
                                  content:
                                      Text('ユーザーは登録されていません。'),
                                );
                              });
                          _tController.clear();
                        }
                      });
                    },
                    color: Colors.blue,
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
