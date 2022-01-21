import 'entities/city.dart';

abstract class Repository {
  Future<City> addCity(City city);
  Future<City> getCity(int id);
  Future removeCity(int id);
  Future updateCity(City city);
  Future<List<City>> getChosenCities();
  Future<bool> getDarkTheme();
  Future<bool> setDarkTheme(bool darkTheme);
  List<City> getCitiesByName(String text);
}