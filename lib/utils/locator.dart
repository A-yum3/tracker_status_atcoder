import 'package:get_it/get_it.dart';
import 'package:tracker_status_atcoder/core/services/api_service.dart';
import 'package:tracker_status_atcoder/core/services/storage_service.dart';
import 'package:tracker_status_atcoder/core/services/storage_service_sharedpreferences.dart';
import 'package:tracker_status_atcoder/ui/home_screen/home_viewmodel.dart';

GetIt locator = GetIt.instance;

setupServiceLocator() {
  locator.registerLazySingleton<StorageService>(() => StorageServiceSharedPreferences());
  locator.registerLazySingleton<Api>(() => Api());
  locator.registerSingleton<HomeViewModel>(HomeViewModel());
}