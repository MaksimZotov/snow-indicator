import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@injectable
class UpdateCityUseCase {
  final CitiesDatabase _db;
  UpdateCityUseCase(this._db);

  void updateCity(City city)  {
    _db.update(city);
  }
}