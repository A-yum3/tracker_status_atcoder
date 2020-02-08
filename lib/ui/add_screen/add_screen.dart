import 'package:flutter/material.dart';

class AddScreen extends StatelessWidget {
  static const String id = '/add_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User Info'),
      ),
    );
  }
}
