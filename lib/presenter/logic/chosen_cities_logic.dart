import 'package:flutter/cupertino.dart';
import 'package:snow_indicator/data/databases/database.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/presenter/logic/base_logic.dart';

class ChosenCitiesLogic extends ChangeNotifier {
  List<City> _cities = [];
  bool _isLoading = false;

  List<City> get cities => _cities;
  bool get isLoading => _isLoading;

  Future loadCities() async {
    _update(() => _isLoading = true);
    _cities = await CitiesDatabase.instance.readAllCities();
    _update(() => _isLoading = false);
  }

  void addCity(City city) {
    _update(() { _cities.add(city); });
    CitiesDatabase.instance.create(city);
  }

  void removeCity(int index) {
    _update(() { _cities.removeAt(index); });
    CitiesDatabase.instance.delete(_cities[index].id!);
  }

  void closeDatabase() {
    CitiesDatabase.instance.close();
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}