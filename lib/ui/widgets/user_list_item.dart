import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final Function onTap;
  final Function onLongTap;

  UserListItem({this.user, this.onTap, this.onLongTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  user.userId,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: showColorByRate(user.color),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text('Rated Point Sum'),
                  Text(
                    user.ratedPointSum.toInt().toString(),
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('AC'),
                      Text(
                        user.acceptedCount.toString(),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: <Widget>[
                      Text('ACRank'),
                      Text(user.acceptedCountRank.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
