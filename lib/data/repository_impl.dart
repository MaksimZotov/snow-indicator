import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/repositories/cities_database.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/repository.dart';

@singleton
class RepositoryImpl implements Repository {
  CitiesDatabase _citiesDB;

  RepositoryImpl(this._citiesDB);

  @override
  Future<City> addCity(City city) async {
    return _citiesDB.create(city);
  }

  @override
  Future<City> getCity(int id) async {
    return await _citiesDB.readCity(id);
  }

  @override
  Future removeCity(int id) async {
    await _citiesDB.delete(id);
  }

  @override
  Future updateCity(City city) async {
    await _citiesDB.update(city);
  }

  @override
  Future<List<City>> getChosenCities() async {
    return await _citiesDB.readAllCities();
  }

  @override
  Future<bool> getDarkTheme() async {
    return await true;
  }

  @override
  Future<bool> setDarkTheme(bool darkTheme) async {
    return await true;
  }

  List<City> getCitiesByName(String text) {
    final List<City> _cities = [
      City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
      City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
      City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
    ];

    List<City> cities = [];
    for (City city in _cities) {
      if (city.name.toLowerCase().startsWith(text.toLowerCase())) {
        cities.add(city);
      }
    }
    return cities;
  }
}
