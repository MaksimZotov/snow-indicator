import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@injectable
class GetCityUseCase {
  final CitiesDatabase _db;
  GetCityUseCase(this._db);

  Future<City> getCity(int id) async {
    return await _db.readCity(id);
  }
}