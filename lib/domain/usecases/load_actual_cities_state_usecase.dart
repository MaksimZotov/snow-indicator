import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/repository.dart';

@injectable
class LoadActualCitiesStateUseCase {
  final Repository _repository;
  LoadActualCitiesStateUseCase(this._repository);

  Future<List<City>> loadActualCitiesState(List<City> cities) async {
    final cityNames = cities.map((city) => city.name).toList();
    final updatedCities = await _repository.loadActualCitiesState(cityNames);
    for (int i = 0; i < updatedCities.length; i++) {
      updatedCities[i] = updatedCities[i].copy(image: cities[i].image);
    }
    return updatedCities;
  }
}