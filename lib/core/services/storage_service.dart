import 'network_helper.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const problemsUrl = 'https://kenkoooo.com/atcoder/atcoder-api/v2/user_info';

class StorageService {
  List<String> _userNameList = ['cowgirl'];

  // UIに表示するUser情報を作成

  Future updateUserStorage(SharedPreferences prefs) async {
    List<User> _userProfileStructList = [];
    _userNameList = _getUserNameList(prefs);

    if(_userNameList != null) {
      for (var userName in _userNameList) {
        var userData = await _getUserProfile(userName);

        if(userData != null) {
          _userProfileStructList.add(User.fromJson(userData));
        }
      }
    }

    return _userProfileStructList;
  }

  // Userを追加する

  Future<void> addUserId(String userId, SharedPreferences prefs) async {
    _userNameList = _getUserNameList(prefs);
    _userNameList.add(userId);
    await _saveUserNameList(_userNameList, prefs);
  }

  // Apiを叩く

  Future _getUserProfile(String userName) async {
    NetworkHelper networkHelper = NetworkHelper('$problemsUrl?user=$userName');

    var userData = await networkHelper.getData();
    return userData;
  }


  // SharedPreferencesのゲッターとセッター

  List<String> _getUserNameList(SharedPreferences prefs) {
    return prefs.getStringList('my_user_name_list_key');
  }

  Future<void> _saveUserNameList(List<String> nameList, SharedPreferences prefs) async {
//    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('my_user_name_list_key', nameList);
  }

}

StorageService serviceLocator<T>() {
  return StorageService();
}
