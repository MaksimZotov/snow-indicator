import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/repository.dart';

@injectable
class LoadCityUseCase {
  final Repository _repository;
  LoadCityUseCase(this._repository);

  Future<City> loadCity(String city) async {
    final loadedCities = await _repository.loadActualCitiesState([city]);
    return loadedCities.first;
  }
}