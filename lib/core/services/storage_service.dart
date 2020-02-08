import 'network_helper.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
//import 'package:shared_preferences/shared_preferences.dart';

const problemsUrl = 'https://kenkoooo.com/atcoder/atcoder-api/v2/user_info';

class StorageService {
  List<String> _userNameList = ['cowgirl', 'gomimap', 'naoi', 'shuG',];

  Future updateStorage() async {
    List<User> _userProfileStructList = [];
    for (var userName in _userNameList) {
      var userData = await getUserProfile(userName);

      _userProfileStructList.add(User.fromJson(userData));
    }

    return _userProfileStructList;
  }

  Future getUserProfile(String userName) async {
    NetworkHelper networkHelper = NetworkHelper('$problemsUrl?user=$userName');

    var userData = await networkHelper.getData();
    return userData;
  }

  //TODO: SharedPreferencesを利用して実装する

//  Future<int> getUserNameList() async {
//    final prefs = await SharedPreferences.getInstance();
//    return prefs.getStringList('my_user_name_list_key') ?? 0;
//  }
//
//  Future<void> saveUserNameList(List<String> nameList) async {
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setStringList('my_user_name_list_key', nameList);
//  }

}

StorageService serviceLocator<T>() {
  return StorageService();
}
