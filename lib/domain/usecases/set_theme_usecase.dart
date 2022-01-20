import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';

@injectable
class SetThemeUseCase {
  final CitiesDatabase _db;
  SetThemeUseCase(this._db);

  Future<bool> setDarkTheme(bool darkTheme) async {
    return await true;
  }
}