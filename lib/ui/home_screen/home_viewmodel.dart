import 'package:flutter/foundation.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeViewModel extends ChangeNotifier {

  StorageService _storageService = serviceLocator<StorageService>();

  List<User> _users = [];

  List<User> get users => _users;

  void initialize() {
    getUserList();
    print('a');
  }

  Future getUserList() async {
    final prefs = await SharedPreferences.getInstance();
    _users = await _storageService.updateUserStorage(prefs);
    notifyListeners();
  }

  // TODO: 名前を入れてADDを押してもUIの更新が行われないのを解決する。
  void registerUserName(String inputUserName) async {
    final prefs = await SharedPreferences.getInstance();
    await _storageService.addUserId(inputUserName, prefs);
    notifyListeners();
  }

  void allDeleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }


}


