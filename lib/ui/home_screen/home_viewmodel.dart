import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';

enum ViewState { Idle, Busy }

class HomeViewModel extends ChangeNotifier {
  StorageService _storageService = locator<StorageService>();
  ViewState state = ViewState.Idle;
  // データベースを使用しない限り、Userの保存は不可能
  // P.S 極力コードを変えないようにこのまま
  LinkedHashMap<String, User> _users = LinkedHashMap<String, User>();

  LinkedHashMap<String, User> get users => _users;

  void initialize() async {
    getUserMap();
  }

  Future getUserMap() async {
    _users = await _storageService.getUserDataAll();
    notifyListeners();
    state = ViewState.Busy;
  }

  Future<bool> registerUserNameAndCheck(String inputUserName) async {
    // 10件以上登録できないようにする（APIの負荷のため）
    if(_users.length >= 10) {
      return false;
    }

    // すでに登録されていたら登録しない
    if (_users[inputUserName] != null) {
      return false;
    }

    User user = await _storageService.registerUserName(inputUserName);
    if (user != null) {
      _users[inputUserName] = user;
      print('registered');
      notifyListeners();
      return true;
    } else {
      print('failed');
      return false;
    }
  }

  void allDeleteUserId() async {
    await _storageService.userDataAllDelete();
    _users = LinkedHashMap<String, User>();
    notifyListeners();
    print('deleted');
  }

  void removeUserName(String user) async {
    _users.remove(user);
    await _storageService.userDataDelete(user);

    notifyListeners();
  }

  Future updateAllData() async {
    await _storageService.updateAllUserData();
    await Future.delayed(Duration(milliseconds: 5000));
  }

  // T: Already F: No
  Future<bool> checkUserIsRegistered(String inputUserName) async {
    var data = await _storageService.getUserData(inputUserName);
    return data == null ? false : true;
  }
}
