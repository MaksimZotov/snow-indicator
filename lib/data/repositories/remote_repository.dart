import 'dart:convert';

import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/converters/city_weather_converter.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@singleton
class RemoteRepository {
  final CityWeatherConverter _cityConverter;

  RemoteRepository(this._cityConverter);

  final url = 'https://api.openweathermap.org/data/2.5/weather?';
  final appId = 'appId=76213d5339b06a994535d0cfcdbeab22';

  Future<List<City>> loadActualCitiesState(List<String> cities) async {
    List<City> updatedCities = [];
    for (String city in cities) {
      final response =
          await get(Uri.parse('${url}q=${city}&$appId'));
      if (response.statusCode == 200) {
        updatedCities.add(_cityConverter.fromJson(jsonDecode(response.body)));
      } else {
        throw Exception('Failed to load');
      }
    }
    return updatedCities;
  }

  /// Stub
  final List<String> _cities = [
    'Magnitogorsk',
    'Moscow',
    'Arkhangelsk',
    'Armavir',
    'Arsenyev',
    'Artem',
    'Arkhangelsk',
    'Asbestos',
    'Astrakhan',
    'Achinsk',
    'Balakovo',
    'Balakhna',
    'Balashikha',
    'Balashov',
    'Barnaul',
    'Bataysk',
    'Belgorod',
    'Murmansk',
    'Murom',
    'Mytishchi',
  ];

  /// Stub
  Future<List<String>> getCityNamesStartedWith(String text) async {
    List<String> cities = [];
    await Future.delayed(const Duration(milliseconds: 100), () {
      for (String city in _cities) {
        if (city.toLowerCase().startsWith(text.toLowerCase())) {
          cities.add(city);
        }
      }
    });
    return cities;
  }
}
