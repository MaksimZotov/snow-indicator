import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/get_cities_by_name_usecase.dart';

@injectable
class SearchCityLogic extends ChangeNotifier {
  GetCitiesByNameUseCase getCitiesByNameFromRemoteUseCase;
  SearchCityLogic(this.getCitiesByNameFromRemoteUseCase);

  List<City> _cities = [];
  List<City> get cities => _cities;

  void filterCities(String text) {
    _update(() {
      _cities = getCitiesByNameFromRemoteUseCase.getCitiesByName(text);
    });
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
