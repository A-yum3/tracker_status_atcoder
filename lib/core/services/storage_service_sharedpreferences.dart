import 'dart:collection';

import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:tracker_status_atcoder/core/services/api_service.dart';
import 'package:tracker_status_atcoder/locator.dart';

// TODO: SQLiteの使用を考慮する

class StorageServiceSharedPreferences extends StorageService {
  Api _api = locator<Api>();

  // Shared_preferencesからユーザデータを取り出す
  @override
  Future<User> getUserData(String userName) async {
    User user = await _api.getUserDataFromApi(userName);

    return user; // nullで返る時もある。
  }

  // Shared_preferencesにユーザーの名前を登録
  @override
  Future<User> registerUserName(String userName) async {
    // TODO: 重複登録できないようにする
    User user = await getUserData(userName);
    if(user == null) {
      return null;
    }

    List<String> currentNameList = await getUserNameList();
    if (currentNameList == null) currentNameList = [];
    currentNameList.add(userName);

    settingNameList(currentNameList);
    return user;
  }

  // Shared_preferencesに登録されているユーザーの名前リストを返す
  @override
  Future<List<String>> getUserNameList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('my_user_name_list_key');
  }

  @override
  Future<void> userDataAllDelete() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Future<void> userDataDelete(String name) async {
    List<String> users = await getUserNameList();
    users.remove(name);
    settingNameList(users);
  }

  @override
  Future<LinkedHashMap<String, User>> getUserDataAll() async {
    List<String> userNames = await getUserNameList();
    LinkedHashMap<String, User> userMap = LinkedHashMap<String, User>();

    if (userNames != null) {
      for (var userName in userNames) {
        User user = await _api.getUserDataFromApi(userName);
        userMap[userName] = user;
      }
    }
    return userMap;
  }

  // Shared_preferencesにリストを登録する。
  Future<void> settingNameList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('my_user_name_list_key', list);
  }

}
