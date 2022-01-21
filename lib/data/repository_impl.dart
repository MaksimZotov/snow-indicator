import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/repositories/cities_database.dart';
import 'package:snow_indicator/data/repositories/key_value_storage.dart';
import 'package:snow_indicator/data/repositories/remote_repository.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/repository.dart';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  final CitiesDatabase _citiesDB;
  final KeyValueStorage _keyValueStorage;
  final RemoteRepository _remoteRepository;

  RepositoryImpl(this._citiesDB, this._keyValueStorage, this._remoteRepository);

  @override
  Future<City> addCity(City city) async {
    return _citiesDB.create(city);
  }

  @override
  Future<City> getCity(int id) async {
    return await _citiesDB.readCity(id);
  }

  @override
  Future<int> removeCity(int id) async {
    return await _citiesDB.delete(id);
  }

  @override
  Future<int> updateCity(City city) async {
    return await _citiesDB.update(city);
  }

  @override
  Future<List<City>> getChosenCities() async {
    return await _citiesDB.readAllCities();
  }

  @override
  Future<bool> getDarkTheme() async {
    return await _keyValueStorage.getDarkTheme();
  }

  @override
  Future<void> setDarkTheme(bool darkTheme) async {
    return await _keyValueStorage.setDarkTheme(darkTheme);
  }

  @override
  Future<List<String>> getCityNamesStartedWith(String text) async {
    return await _remoteRepository.getCityNamesStartedWith(text);
  }

  @override
  Future<List<City>> loadActualCitiesState(List<String> cities) async {
    return await _remoteRepository.loadActualCitiesState(cities);
  }

  @override
  Future disposeRepository() async {
    return await _citiesDB.close();
  }
}
