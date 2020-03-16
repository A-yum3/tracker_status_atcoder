import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';


class TemplateIndicator extends StatelessWidget {
  final User user;
  final int limit;
  final String info;
  final Color color;

  TemplateIndicator(
      {@required this.user,
        @required this.info,
        @required this.limit,
        this.color});

  @override
  Widget build(BuildContext context) {
    double percent = user.ratedPointSum / limit;
    String perText = ((percent * 1000).round() / 10).toString();
    if (percent > 1.0) percent = 1.0;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: CircularPercentIndicator(
        radius: 60.0,
        lineWidth: 5.0,
        percent: percent,
        center: Text('$perText%'),
        progressColor: color,
        footer: Text(info),
      ),
    );
  }
}