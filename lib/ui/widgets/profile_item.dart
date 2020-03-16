import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final detail;
  final Size size;
  final int fontSizeDenom;
  final Color titleColor;
  final Color detailColor;
  final String title;

  ProfileItem(
      {@required this.detail,
        @required this.size,
        @required this.fontSizeDenom,
        @required this.titleColor,
        @required this.detailColor,
        @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: titleColor,
          ),
        ),
        SizedBox(height: 8),
        Text(
          detail,
          style: TextStyle(
              fontSize: (size.width + size.height) * (1 / fontSizeDenom),
              color: detailColor),
        )
      ],
    );
  }
}
