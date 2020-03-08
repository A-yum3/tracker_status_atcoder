import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'package:tracker_status_atcoder/utils/assets.dart';

class UserListCard extends StatelessWidget {
  final User user;
  final Function onTap;
  final Function onLongTap;

  UserListCard({this.user, this.onTap, this.onLongTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: <Widget>[
              Container(
                height: 130,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: user.imageUrl == 'none'
                              ? Image.asset(Assets.avatar)
                              : Image.network(user.imageUrl,
                                  fit: BoxFit.cover)),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: Text(
                          user.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: showColorByRate(user.color)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                user.userId,
                style: Theme.of(context).textTheme.title.copyWith(
                      color: showColorByRate(user.color),
                    ),
              ),
            ],
          )),
    );
  }
}

//            SizedBox(height: 10),
//            Padding(
//              padding: const EdgeInsets.only(top: 20.0),
//              child:
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                Text(
//                  'Raiting: ',
//                  style: Theme.of(context).textTheme.subhead,
//                ),
//                Text(
//                  user.rating.toString(),
//                  style: Theme.of(context)
//                      .textTheme
//                      .headline
//                      .copyWith(color: showColorByRate(user.color)),
//                ),
//              ],
//            ),
