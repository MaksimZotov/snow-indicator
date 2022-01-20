import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/databases/cities_database.dart';

@injectable
class RemoveCityUseCase {
  final CitiesDatabase _db;
  RemoveCityUseCase(this._db);

  Future removeCity(int id) async {
    await _db.delete(id);
  }
}