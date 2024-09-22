import 'package:in_app_update/in_app_update.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';

class AppUpdateService {
  // Private constructor
  AppUpdateService._privateConstructor();

  // Singleton instance
  static final AppUpdateService _instance =
      AppUpdateService._privateConstructor();

  // Getter to access the instance
  static AppUpdateService get instance => _instance;

  Future<AppUpdateInfo> checkForUpdate() async {
    return await InAppUpdate.checkForUpdate();
  }

  bool isUpdateMandatory() {
    final value = RemoteConfigKeys.showUpdatePage.value<bool>();
    return value;
  }

  void immediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }
}
