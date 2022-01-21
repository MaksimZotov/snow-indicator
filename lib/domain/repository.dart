import 'entities/city.dart';

abstract class Repository {
  Future<City> addCity(City city);
  Future<City> getCity(int id);
  Future<int> removeCity(int id);
  Future<int> updateCity(City city);
  Future<List<City>> getChosenCities();
  Future<bool> getDarkTheme();
  Future<void> setDarkTheme(bool darkTheme);
  Future<List<String>> getCityNamesStartedWith(String text);
}