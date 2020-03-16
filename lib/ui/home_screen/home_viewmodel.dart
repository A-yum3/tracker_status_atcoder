import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:tracker_status_atcoder/utils/locator.dart';

enum ViewState { idle, busy }

class HomeViewModel extends ChangeNotifier {
  final StorageService _storageService = locator<StorageService>();
  ViewState state = ViewState.idle;
  LinkedHashMap<String, User> _users = LinkedHashMap<String, User>();

  LinkedHashMap<String, User> get users => _users;

  void initialize() {
    getUserMap();
  }

  Future getUserMap() async {
    _users = await _storageService.getUserDataAll();
    notifyListeners();
    state = ViewState.busy;
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

    final user = await _storageService.registerUserName(inputUserName);
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

  Future<void> allDeleteUserId() async {
    await _storageService.userDataAllDelete();
    // ignore: prefer_collection_literals
    _users = LinkedHashMap<String, User>();
    notifyListeners();
    print('deleted');
  }

  Future<void> removeUserName(String user) async {
    _users.remove(user);
    await _storageService.userDataDelete(user);

    notifyListeners();
  }

  Future updateAllData() async {
    await _storageService.updateAllUserData();
    await Future<Duration>.delayed(const Duration(milliseconds: 5000));
  }

  // T: Already F: No
  Future<bool> checkUserIsRegistered(String inputUserName) async {
    final data = await _storageService.getUserData(inputUserName);
    // ignore: avoid_bool_literals_in_conditional_expressions
    return data == null ? false : true;
  }
}
