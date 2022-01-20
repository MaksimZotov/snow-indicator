import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@injectable
class AddCityUseCase {
  final CitiesDatabase _db;
  AddCityUseCase(this._db);

  Future<City> addCity(City city) async {
    return _db.create(city);
  }
}