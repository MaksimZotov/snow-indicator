import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class KeyValueStorage {
  final _storage = GetStorage();

  final _darkThemeKey = 'DARK_THEME_KEY';

  Future setDarkTheme(bool darkTheme) async {
    await _storage.write(_darkThemeKey, darkTheme);
  }

  Future<bool> getDarkTheme() async {
    bool? darkThemeNullable = _storage.read(_darkThemeKey);
    bool darkTheme = darkThemeNullable ?? false;
    return darkTheme;
  }
}