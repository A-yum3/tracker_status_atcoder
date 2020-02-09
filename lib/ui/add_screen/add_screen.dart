import 'package:flutter/material.dart';
import 'add_viewmodel.dart';
import 'package:provider_architecture/provider_architecture.dart';

class AddScreen extends StatelessWidget {
  static const String id = '/add_screen';

  @override
  Widget build(BuildContext context) {
    String inputUserName = '';

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
                child: TextField(
                  onChanged: (value) {
                    inputUserName = value;
                    print(inputUserName);
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter User Id',
                    enabledBorder: const OutlineInputBorder(
                      // width: 0.0 produces a thin "hairline" border
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 0.0),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              ViewModelProvider<AddViewModel>.withConsumer(
                  viewModel: AddViewModel(),
                  builder: (context, model, child) => RaisedButton.icon(
                        elevation: 16.0,
                        icon: Icon(Icons.input),
                        label: Text("Add"),
                        onPressed: () => model.registerUserName(inputUserName),
                        color: Colors.blue,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
