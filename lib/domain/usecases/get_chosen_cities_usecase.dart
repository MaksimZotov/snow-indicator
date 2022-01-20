import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@injectable
class GetChosenCitiesUseCase {
  final CitiesDatabase _db;
  GetChosenCitiesUseCase(this._db);

  Future<List<City>> getChosenCities() async {
    return await _db.readAllCities();
  }
}