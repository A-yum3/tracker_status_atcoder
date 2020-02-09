import 'package:flutter/cupertino.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddViewModel extends ChangeNotifier {

  StorageService _storageService = serviceLocator<StorageService>();

  void registerUserName(String inputUserName) async {
    //TODO: ストレージサービスのリストに名前を追加する機能を追加する。
    final prefs = await SharedPreferences.getInstance();
    await _storageService.addUserId(inputUserName, prefs);
    _storageService.updateUserStorage(prefs);
    notifyListeners();
  }
}