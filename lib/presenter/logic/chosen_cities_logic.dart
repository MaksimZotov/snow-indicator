import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/add_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/get_chosen_cities_usecase.dart';
import 'package:snow_indicator/domain/usecases/remove_city_usecase.dart';

@injectable
class ChosenCitiesLogic extends ChangeNotifier {
  AddCityUseCase addCityUseCase;
  GetChosenCitiesUseCase getChosenCitiesUseCase;
  RemoveCityUseCase removeCityUseCase;

  ChosenCitiesLogic(
    this.addCityUseCase,
    this.getChosenCitiesUseCase,
    this.removeCityUseCase,
  );

  List<City> _cities = [];
  bool _isLoading = false;

  List<City> get cities => _cities;
  bool get isLoading => _isLoading;

  Future getChosenCities() async {
    _update(() => _isLoading = true);
    _cities = await getChosenCitiesUseCase.getChosenCities();
    _update(() => _isLoading = false);
  }

  void addCity(City city) {
    _update(() {
      _cities.add(city);
    });
    addCityUseCase.addCity(city);
  }

  void removeCity(int index) {
    _update(() {
      _cities.removeAt(index);
    });
    removeCityUseCase.removeCity(cities[index].id!);
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
