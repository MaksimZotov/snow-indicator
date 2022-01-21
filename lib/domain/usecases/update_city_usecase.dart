import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

import '../repository.dart';

@injectable
class UpdateCityUseCase {
  final Repository _repository;
  UpdateCityUseCase(this._repository);

  Future updateCity(City city) async {
    await _repository.updateCity(city);
  }
}