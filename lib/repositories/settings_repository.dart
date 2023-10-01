import 'package:clipboard_listener/models/settings.dart';
import 'package:clipboard_listener/services/shared_preferences.dart';

class SettingsRepository {
  const SettingsRepository({
    required this.sharedPreferencesService,
  });

  final SharedPreferencesService sharedPreferencesService;

  static const _key = 'settings';

  Future<Settings?> get() async {
    final res = await sharedPreferencesService.getMap(key: _key);

    if (res == null) {
      return null;
    }

    return Settings.fromJson(res);
  }

  Future<void> set({
    required Settings? settings,
  }) async {
    if (settings == null) {
      await sharedPreferencesService.setMap(key: _key, value: null);

      return;
    }

    await sharedPreferencesService.setMap(key: _key, value: settings.toJson());
  }
}
