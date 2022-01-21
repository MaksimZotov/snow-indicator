import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/add_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/load_actual_cities_state_usecase.dart';
import 'package:snow_indicator/domain/usecases/get_chosen_cities_usecase.dart';
import 'package:snow_indicator/domain/usecases/load_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/remove_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectable
class ChosenCitiesLogic extends BaseLogic {
  final AddCityUseCase _addCityUseCase;
  final GetChosenCitiesUseCase _getChosenCitiesUseCase;
  final RemoveCityUseCase _removeCityUseCase;
  final LoadActualCitiesStateUseCase _getActualCitiesStateUseCase;
  final LoadCityUseCase _loadCityUseCase;
  final UpdateCityUseCase _updateCityUseCase;

  ChosenCitiesLogic(
    this._addCityUseCase,
    this._getChosenCitiesUseCase,
    this._removeCityUseCase,
    this._getActualCitiesStateUseCase,
    this._loadCityUseCase,
    this._updateCityUseCase,
  );

  final ChangeNotifier _addCityNotifier = ChangeNotifier();
  final ValueNotifier<int> _removeCityByIndexNotifier = ValueNotifier(-1);
  List<City>? _cities;

  List<City> get cities =>
      _cities != null ? _cities! : throw Exception("Cities is null");

  ChangeNotifier get addCityNotifier => _addCityNotifier;

  ValueNotifier<int> get removeCityByIndexNotifier =>
      _removeCityByIndexNotifier;

  Future initCities() async {
    showLoading();
    _cities = await _getChosenCitiesUseCase.getChosenCities();
    _cities = await _getActualCitiesStateUseCase.loadActualCitiesState(cities);
    for (City city in cities) {
      await _updateCityUseCase.updateCity(city);
    }
    hideLoading();
  }

  Future addCity(String city) async {
    showLoading();
    final loadedCity = await _loadCityUseCase.loadCity(city);
    final addedCity = await _addCityUseCase.addCity(loadedCity);
    hideLoading();
    addCityNotifier.notifyListeners();
    cities.add(addedCity);
  }

  Future removeCity(int index) async {
    removeCityByIndexNotifier.value = index;
    await _removeCityUseCase.removeCity(cities.removeAt(index).id!);
  }
}
