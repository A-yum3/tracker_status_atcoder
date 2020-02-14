import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeViewModel extends ChangeNotifier {

  StorageService _storageService = serviceLocator<StorageService>();

  List<User> _users = [];

  List<User> get users => _users;

  HomeViewModel() {
    getUserList();
  }

  Future getUserList() async {
    final prefs = await SharedPreferences.getInstance();
    _users = await _storageService.updateUserStorage(prefs);
    notifyListeners();
  }

  Future<void> registerUserName(String inputUserName) async {
    final prefs = await SharedPreferences.getInstance();
    await _storageService.addUserId(inputUserName, prefs);
    getUserList();
    print('register');
  }

  void allDeleteUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    getUserList();
    print('deleted');
  }

  void removeUserId(String user) async {
    final prefs = await SharedPreferences.getInstance();
    var deleteUsers =  _storageService.getUserNameList(prefs);
    deleteUsers.remove(user);
    await _storageService.saveUserNameList(deleteUsers, prefs);
    getUserList();
  }

  // T: Already F: No
  Future<bool> checkUserIsRegistered(String inputUserName) async {
    var data = await _storageService.getUserProfile(inputUserName);
    return data == null ? false : true;
  }

}


