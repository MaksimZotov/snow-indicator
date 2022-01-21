import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/repository.dart';

@injectable
class AddCityUseCase {
  final Repository _repository;
  AddCityUseCase(this._repository);

  Future<City> addCity(City city) async {
    return _repository.addCity(city);
  }
}