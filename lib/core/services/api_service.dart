import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/helper/network_helper.dart';

const problemsUrl = 'https://kenkoooo.com/atcoder/atcoder-api/v2/user_info';
const atCoderUrl = 'https://us-central1-atcoderusersapi.cloudfunctions.net/api/info/username/';

class Api {

  Future<User> getUserDataFromApi(String userName) async {
    NetworkHelper atCoderProblemsHelper = NetworkHelper('$problemsUrl?user=$userName');
    NetworkHelper atCoderProfileHelper = NetworkHelper('$atCoderUrl$userName');

    // OK: DecodeJsonData False: Null
    var userProblemsData = await atCoderProblemsHelper.getData();
    var userAtCoderData = await atCoderProfileHelper.getData();

    try {
      // JsonDataの統合
      userProblemsData.addAll(userAtCoderData['data']);
    } catch (e) {
      print(e);
    }

    return User.fromJson(userProblemsData);
  }
}