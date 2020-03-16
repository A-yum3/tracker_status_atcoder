import 'package:flutter/material.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:intl/intl.dart';
import 'package:tracker_status_atcoder/ui/widgets/profile_item.dart';
import 'package:tracker_status_atcoder/ui/widgets/template_indicator.dart';
import 'package:tracker_status_atcoder/utils/assets.dart';
import 'package:tracker_status_atcoder/utils/show_color_by_rate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDetails extends StatefulWidget {
  final User user;
  const UserDetails(this.user);

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();

  final controller = PageController(
    initialPage: 0,
  );

  var scrollDirection = Axis.horizontal;
  var actionIcon = Icons.swap_vert;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    DateTime formatData = DateTime.parse(widget.user.lastUpdate);
    String formattedData = DateFormat('yyyy-MM-dd').format(formatData);

    _launchURL() async {
      var url = 'https://atcoder.jp/users/${widget.user.userId}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: _screenSize.height * (5 / 6),
              child: PageView(
                controller: controller,
                scrollDirection: scrollDirection,
                pageSnapping: true,
                children: <Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Card(
                      elevation: 4,
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(24),
                      child: Column(
                        children: <Widget>[
                          // TODO: リファクタリング
                          SizedBox(
                            height: _screenSize.height * (1 / 10),
                          ),
                          Text(
                            widget.user.userId,
                            style: TextStyle(
                                color: showColorByRate(widget.user.color),
                                fontSize: 32,
                                fontFamily: 'Lobster'),
                          ),
                          Text(
                            widget.user.affiliation ??= '',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(
                            height: _screenSize.height * (1 / 25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ProfileItem(
                                title: 'Highest',
                                titleColor: Colors.grey,
                                detail: widget.user.highestRating.toString(),
                                detailColor: showColorByRate(widget.user.color),
                                fontSizeDenom: 35,
                                size: _screenSize,
                              ),
                              Container(
                                height: _screenSize.height * (1 / 30),
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  width: _screenSize.width * (1 / 5),
                                ),
                              ),
                              ProfileItem(
                                title: 'Now',
                                titleColor: Theme.of(context).accentColor,
                                detail: widget.user.rating.toString(),
                                detailColor: showColorByRate(widget.user.color),
                                fontSizeDenom: 35,
                                size: _screenSize,
                              ),
                            ],
                          ),
                          SizedBox(height: _screenSize.height * (1 / 15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('Country'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.globe,
                                          size: (_screenSize.height +
                                                  _screenSize.width) *
                                              (1 / 30),
                                        ),
                                      ),
                                      Text(
                                        widget.user.formalCountryName,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _screenSize.height * (1 / 30),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Wins',
                                        textAlign: TextAlign.center,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.crown,
                                          size: (_screenSize.height +
                                                  _screenSize.width) *
                                              (1 / 32),
                                        ),
                                      ),
                                      Text(
                                        widget.user.wins.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text('Competitions'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.medal,
                                          size: (_screenSize.height +
                                                  _screenSize.width) *
                                              (1 / 30),
                                        ),
                                      ),
                                      Text(
                                        widget.user.competitions.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: _screenSize.height * (1 / 30),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text('Ranking'),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          FontAwesomeIcons.chartLine,
                                          size: (_screenSize.height +
                                                  _screenSize.width) *
                                              (1 / 30),
                                        ),
                                      ),
                                      Text(
                                        widget.user.rank.toString(),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: _screenSize.height * (1 / 25),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(24),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: _screenSize.height * (1 / 9),
                            ),
//                            Text(
//                              'AtCoder Problems',
//                              style: TextStyle(
//                                fontSize: 24,
//                              ),
//                            ),
                            SizedBox(
                              height: _screenSize.height * (1 / 25),
                            ),
                            Wrap(
                              spacing: 40,
                              runSpacing: 20,
                              children: <Widget>[
                                ProfileItem(
                                  detail: widget.user.acceptedCount.toString(),
                                  detailColor: Theme.of(context).accentColor,
                                  fontSizeDenom: 50,
                                  title: 'Accepted Count',
                                  titleColor: Colors.grey,
                                  size: _screenSize,
                                ),
                                ProfileItem(
                                  title: 'Accepted Count Rank',
                                  titleColor: Colors.grey,
                                  detail: widget.user.acceptedCountRank.toString(),
                                  detailColor: Theme.of(context).accentColor,
                                  fontSizeDenom: 50,
                                  size: _screenSize,
                                ),
                                ProfileItem(
                                  title: 'Rated Point Sum',
                                  titleColor: Colors.grey,
                                  detail: widget.user.ratedPointSum.toInt().toString(),
                                  detailColor: Theme.of(context).accentColor,
                                  fontSizeDenom: 50,
                                  size: _screenSize,
                                ),
                                ProfileItem(
                                  title: 'Rated Point Sum Rank',
                                  titleColor: Colors.grey,
                                  detail: widget.user.ratedPointSumRank.toString(),
                                  detailColor: Theme.of(context).accentColor,
                                  fontSizeDenom: 50,
                                  size: _screenSize,
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Road to ...',
                              style: TextStyle(fontSize: 24),
                            ),
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: <Widget>[
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Max',
                                  limit: 757718,
                                  color: Colors.green,
                                ),
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Brown',
                                  limit: 90000,
                                  color: Colors.brown,
                                ),
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Green',
                                  limit: 120000,
                                  color: Colors.green,
                                ),
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Cyan',
                                  limit: 150000,
                                  color: Colors.cyan,
                                ),
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Blue',
                                  limit: 200000,
                                  color: Colors.blue,
                                ),
                                TemplateIndicator(
                                  user: widget.user,
                                  info: 'Yellow',
                                  limit: 250000,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              child: Card(
                elevation: 4,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CircleAvatar(
                  backgroundImage: widget.user.imageUrl == 'none'
                      ? AssetImage(Assets.avatar)
                      : NetworkImage(widget.user.imageUrl),
                  radius: (_screenSize.width + _screenSize.height) / 18,
                ),
              ),
              onTap: () {
                _launchURL();
              },
            ),
          ),
        ],
      ),
    );
  }
}
