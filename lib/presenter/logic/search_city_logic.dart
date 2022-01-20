import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/get_cities_by_name_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectable
class SearchCityLogic extends BaseLogic {
  GetCitiesByNameUseCase getCitiesByNameFromRemoteUseCase;

  SearchCityLogic(this.getCitiesByNameFromRemoteUseCase);

  List<City>? _cities;

  List<City> get cities =>
      _cities != null ? _cities! : throw Exception("Cities is null");

  void filterCities(String text) {
    update(() {
      _cities = getCitiesByNameFromRemoteUseCase.getCitiesByName(text);
    });
  }
}
