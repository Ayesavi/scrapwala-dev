part of 'remote_config_service.dart';

enum RemoteConfigKeys {
  isAppOutage('is_app_outage', false),
  showUpdatePage('show_update_page', false),
  enablePhoneAuth('enable_phone_auth', false),
  enableDarkMode('enable_dark_mode', false),
  maxServiceDistance('max_service_distance', 50.00);

  final String keyName;
  final dynamic defaultValue;

  void subscribeWithinWidget(WidgetRef ref) {
    ref.watch(remoteConfigUpdateProvider
        .select((e) => e.value?.updatedKeys.contains(keyName) ?? false));
  }

  void subsribeWithinProvider(ProviderRef ref) {
    ref.watch(remoteConfigUpdateProvider
        .select((e) => e.value?.updatedKeys.contains(keyName) ?? false));
  }

  T value<T>([dynamic ref]) {
    if (ref != null && ref == WidgetRef) {
      subscribeWithinWidget(ref);
    } else if (ref != null && ref == ProviderRef) {
      subsribeWithinProvider(ref);
    }
    if (T == bool) {
      return RemoteConfigService.getBool(keyName) as T;
    } else if (T == double) {
      return RemoteConfigService.getDouble(keyName) as T;
    } else if (T == String) {
      return RemoteConfigService.getString(keyName) as T;
    } else {
      throw 'Data type not supported';
    }
  }

  const RemoteConfigKeys(this.keyName, this.defaultValue);
}
