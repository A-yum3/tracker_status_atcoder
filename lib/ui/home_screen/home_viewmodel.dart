import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:tracker_status_atcoder/core/models/user.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:tracker_status_atcoder/locator.dart';

class HomeViewModel extends ChangeNotifier {
  StorageService _storageService = locator<StorageService>();

  LinkedHashMap<String, User> users;

  Future getUserMap() async {
    users = await _storageService.getUserDataAll();
    notifyListeners();
  }

  Future<bool> registerUserName(String inputUserName) async {
    User user = await _storageService.registerUserName(inputUserName);
    if(user != null) {
      users[inputUserName] = user;
      print('registered');
      notifyListeners();
      return true;
    } else {
      print('failed');
      return false;
    }
  }

  void allDeleteUserId() async {
    _storageService.userDataAllDelete();
    users = LinkedHashMap<String, User>();
    print('deleted');
  }

  void removeUserName(String user) async {
    users.remove(user);
    _storageService.userDataDelete(user);

    notifyListeners();
  }

  // T: Already F: No
  Future<bool> checkUserIsRegistered(String inputUserName) async {
    var data = await _storageService.getUserData(inputUserName);
    return data == null ? false : true;
  }
}
