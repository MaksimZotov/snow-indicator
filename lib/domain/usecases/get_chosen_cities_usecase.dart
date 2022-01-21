import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

import '../repository.dart';

@injectable
class GetChosenCitiesUseCase {
  final Repository _repository;
  GetChosenCitiesUseCase(this._repository);

  Future<List<City>> getChosenCities() async {
    return await _repository.getChosenCities();
  }
}