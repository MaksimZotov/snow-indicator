import 'package:flutter/cupertino.dart';
import 'package:snow_indicator/domain/entities/city.dart';

class SearchCityLogic extends ChangeNotifier {
  final List<City> _cities = [
    City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
    City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
    City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
  ];

  final List<City> cities = [
    City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
    City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
    City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
  ];

  void filterCities(String text) {
    _update(() {
      cities.clear();
      for (City city in _cities) {
        if (city.name.toLowerCase().startsWith(text.toLowerCase())) {
          cities.add(city);
        }
      }
    });
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}