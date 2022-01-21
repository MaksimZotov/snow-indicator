import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

import '../repository.dart';

@injectable
class GetCityUseCase {
  final Repository _repository;
  GetCityUseCase(this._repository);

  Future<City> getCity(int id) async {
    return await _repository.getCity(id);
  }
}