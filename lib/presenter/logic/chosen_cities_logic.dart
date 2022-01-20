import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/add_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/get_chosen_cities_usecase.dart';
import 'package:snow_indicator/domain/usecases/remove_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectable
class ChosenCitiesLogic extends BaseLogic {
  final AddCityUseCase _addCityUseCase;
  final GetChosenCitiesUseCase _getChosenCitiesUseCase;
  final RemoveCityUseCase _removeCityUseCase;

  ChosenCitiesLogic(
    this._addCityUseCase,
    this._getChosenCitiesUseCase,
    this._removeCityUseCase,
  );

  final ChangeNotifier _addCityNotifier = ChangeNotifier();
  final ValueNotifier<int> _removeCityByIndexNotifier = ValueNotifier(-1);
  List<City>? _cities;

  List<City> get cities =>
      _cities != null ? _cities! : throw Exception("Cities is null");

  ChangeNotifier get addCityNotifier => _addCityNotifier;

  ValueNotifier<int> get removeCityByIndexNotifier =>
      _removeCityByIndexNotifier;

  Future getChosenCities() async {
    showLoading();
    _cities = await _getChosenCitiesUseCase.getChosenCities();
    hideLoading();
  }

  Future addCity(City city) async {
    showLoading();
    final addedCity = await _addCityUseCase.addCity(city);
    hideLoading();
    addCityNotifier.notifyListeners();
    cities.add(addedCity);
  }

  Future removeCity(int index) async {
    removeCityByIndexNotifier.value = index;
    cities.removeAt(index);
    await _removeCityUseCase.removeCity(cities[index].id!);
  }
}
