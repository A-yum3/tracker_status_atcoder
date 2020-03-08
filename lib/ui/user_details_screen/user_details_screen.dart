import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:intl/intl.dart';
import 'package:tracker_status_atcoder/utils/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class UserDetails extends StatelessWidget {
  final User user;

  const UserDetails(this.user);

  @override
  Widget build(BuildContext context) {
    DateTime formatData = DateTime.parse(user.lastUpdate);
    String formattedData = DateFormat('yyyy-MM-dd').format(formatData);

    _launchURL() async {
      var url = 'https://atcoder.jp/users/${user.userId}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.userId,
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          CircleAvatar(
            backgroundImage: user.imageUrl == 'none' ? AssetImage(Assets.avatar) : NetworkImage(user.imageUrl),
            radius: 72,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  user.userId,
                  style: TextStyle(
                    fontSize: 50.0,
                    color: showColorByRate(user.color),
                    fontFamily: 'Lobster',
                  ),
                ),
              ),
              GestureDetector(
                onTap: _launchURL,
                child: Icon(
                  Icons.exit_to_app,
                  color: showColorByRate(user.color),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Rating',
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          SizedBox(height: 20),
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
                          'Highest',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          user.highestRating.toString(),
                          style: TextStyle(
                            fontSize: 50.0,
                            color: showColorByRate(user.color),
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
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Now',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          user.rating.toString(),
                          style: TextStyle(
                            fontSize: 50.0,
                            color: showColorByRate(user.color),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 40),
          Text(
            'JOIN Competitions: ${user.competitions.toString()}',
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
                      user.rank.toString(),
                      style: TextStyle(fontSize: 50.0),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(formattedData)
        ],
      )),
    );
  }
}

Color showColorByRate(String color) {
  switch (color) {
    case 'red':
      return Colors.red;
    case 'orange':
      return Colors.orange;
    case 'yellow':
      return Colors.yellow;
    case 'blue':
      return Colors.blue;
    case 'cyan':
      return Colors.cyan;
    case 'green':
      return Colors.green;
    case 'brown':
      return Colors.brown;
  }
  return Colors.grey;
}
