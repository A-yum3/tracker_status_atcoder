import 'dart:collection';

import 'package:tracker_status_atcoder/core/models/user.dart';

abstract class StorageService {
  Future<User> getUserData(String name);
  Future<User> registerUserName(String name);
  Future<LinkedHashMap<String, User>> getUserDataAll();
  Future<void> userDataAllDelete();
  Future<void> userDataDelete(String name);
  Future<void> updateAllUserData();
}
