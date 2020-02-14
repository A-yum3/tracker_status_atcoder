import 'network_helper.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const problemsUrl = 'https://kenkoooo.com/atcoder/atcoder-api/v2/user_info';
const atCoderUrl = 'https://us-central1-atcoderusersapi.cloudfunctions.net/api/info/username/';

class StorageService {
  List<String> _userNameList = [];

  // UIに表示するUser情報を作成

  Future updateUserStorage(SharedPreferences prefs) async {
    List<User> _userProfileStructList = [];
    _userNameList = getUserNameList(prefs);

    if(_userNameList != null) {
      for (var userName in _userNameList) {
        var userData = await getUserProfile(userName);

        if(userData != null) {
          _userProfileStructList.add(User.fromJson(userData));
        }
      }
    }

    return _userProfileStructList;
  }

  // Userを追加する

  Future<void> addUserId(String userId, SharedPreferences prefs) async {
    _userNameList =  getUserNameList(prefs);
    if(_userNameList == null) {
      _userNameList = [];
    }
    _userNameList.add(userId);
    await saveUserNameList(_userNameList, prefs);
  }

  // Apiを叩く

  Future getUserProfile(String userName) async {
    NetworkHelper atCoderProblemsHelper = NetworkHelper('$problemsUrl?user=$userName');
    NetworkHelper atCoderProfileHelper = NetworkHelper('$atCoderUrl$userName');

    var userData = await atCoderProblemsHelper.getData();
    var tempData = await atCoderProfileHelper.getData();
    print(userName);
    if(tempData['data'] != null || userData != null) {
      userData.addAll(tempData['data']);
    }
    print(userData);
    return userData; // ユーザーが登録されていないときはNullが返る
  }


  // SharedPreferencesのゲッターとセッター

  List<String> getUserNameList(SharedPreferences prefs) {
    return prefs.getStringList('my_user_name_list_key');
  }

  Future<void> saveUserNameList(List<String> nameList, SharedPreferences prefs) async {
    await prefs.setStringList('my_user_name_list_key', nameList);
  }

}

StorageService serviceLocator<T>() {
  return StorageService();
}
