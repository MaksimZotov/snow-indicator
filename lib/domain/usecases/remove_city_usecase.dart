import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';

@injectable
class RemoveCityUseCase {
  final CitiesDatabase _db;
  RemoveCityUseCase(this._db);

  void removeCity(int id) async {
    _db.delete(id);
  }
}