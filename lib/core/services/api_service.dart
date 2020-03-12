import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/helper/network_helper.dart';

const problemsUrl = 'https://kenkoooo.com/atcoder/atcoder-api/v2/user_info';
const atCoderUrl =
    'https://us-central1-atcoderusersapi.cloudfunctions.net/api/info/username/';

class Api {
  Future<User> getUserDataFromApi(String userName) async {
    NetworkHelper atCoderProblemsHelper =
        NetworkHelper('$problemsUrl?user=$userName');
    NetworkHelper atCoderProfileHelper = NetworkHelper('$atCoderUrl$userName');

    // OK: DecodeJsonData False: Null
    var userData = await atCoderProblemsHelper.getJsonData();
    print('called problems');
    var userAtCoderData = await atCoderProfileHelper.getJsonData();
    print('called atcoder');

    NetworkHelper atCoderUserPageHelper =
        NetworkHelper('https://atcoder.jp/users/$userName');
    String data = await atCoderUserPageHelper.getData();
//    debugPrint(data);

    if (data == null) {
      return null;
    }

    // JsonDataの統合
    userData.addAll(userAtCoderData['data']);

    // AtCoderに設定されている画像の取得
    Iterable<Match> matches = RegExp(r"class='avatar' src='(.*?)'").allMatches(data);
    for (Match m in matches) {
      print(m.group(1));

      userData['image_url'] = m.group(1);
      if(m.group(1) == '//img.atcoder.jp/assets/icon/avatar.png') {
        userData['image_url'] = 'none';
      }
    }

    // このデータを取得した時の時間を記録
    var formatter = DateFormat('yyyy/MM/dd(E) HH:mm');
    var now = formatter.format(DateTime.now());
    userData['last_update_data'] = now;

    print(userData);
    return User.fromJson(userData);
  }
}
