import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';

@injectable
class GetThemeUseCase {
  final CitiesDatabase _db;
  GetThemeUseCase(this._db);

  Future<bool> getDarkTheme() async {
    return await true;
  }
}