import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

import '../repository.dart';

@injectable
class GetCitiesByNameUseCase {
  final Repository _repository;
  GetCitiesByNameUseCase(this._repository);

  List<City> getCitiesByName(String text) {
    return _repository.getCitiesByName(text);
  }
}