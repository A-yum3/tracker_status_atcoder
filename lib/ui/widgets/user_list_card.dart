import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/ui/user_details_screen/user_details_screen.dart';
import 'package:tracker_status_atcoder/utils/assets.dart';
import 'package:tracker_status_atcoder/utils/show_color_by_rate.dart';

class UserListCard extends StatelessWidget {
  final User user;
  final Function onTap;
  final Function onLongTap;

  UserListCard({this.user, this.onTap, this.onLongTap});

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

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
                              ? Image.asset(Assets.avatar, fit: BoxFit.cover)
                              : Image.network(user.imageUrl,
                                  fit: BoxFit.cover)),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        radius:
                            (_screenSize.width + _screenSize.height) * (1 / 40),
                        backgroundColor: Theme.of(context).backgroundColor,
                        child: Text(
                          user.rating.toString(),
                          style: Theme.of(context).textTheme.headline.copyWith(
                                color: showColorByRate(user.color),
                            fontSize: (_screenSize.width + _screenSize.height) * (1 / 45),
                              ),
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
