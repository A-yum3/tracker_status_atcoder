import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';

class UserDetails extends StatelessWidget {
  static String id = '/user_details';

  @override
  Widget build(BuildContext context) {
    User user = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.userId,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  user.userId,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.green,
                    fontFamily: 'Lobster',
                  ),
                ),
              ),
              // TODO: AtCoderのサイトを表示する。
              Icon(
                Icons.exit_to_app,
                color: Colors.green,
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Rating',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'High',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '803',
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.green,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Now',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          '537',
                          style: TextStyle(
                            fontSize: 50.0,
                            color: Colors.brown[400],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Text(
            'JOIN Competitions: 25',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Rank',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100.0),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '9493',
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text('最終更新日: 2020/2/19')
        ],
      )),
    );
  }
}
