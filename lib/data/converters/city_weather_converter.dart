import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@singleton
class CityWeatherFields {
  late final List<String> values = [name, weather, main, snow, h1, h3];

  final String name = 'name';
  final String weather = 'weather';
  final String main = 'main';
  final String snow = 'snow';
  final String h1 = '1h';
  final String h3 = '3h';
}

@singleton
class CityWeatherConverter {
  final CityWeatherFields _fields;
  CityWeatherConverter(this._fields);

  City fromJson(Map<String, Object?> json) {
    final name = json[_fields.name] as String;
    double snowiness = 0.0;
    final weatherField = json[_fields.weather] as List<dynamic>;
    final mainField = weatherField.first[_fields.main] as String;
    if (mainField == 'Snow') {
      final snowField = json[_fields.snow] as Map<String, Object?>;
      int count = 0;
      double h1Field = 0.0;
      double h3Field = 0.0;
      if (snowField.containsKey(_fields.h1)) {
        h1Field = snowField[_fields.h1] as double;
        count++;
      }
      if (snowField.containsKey(_fields.h3)) {
        h3Field = snowField[_fields.h3] as double;
        count++;
      }
      snowiness = (h1Field + h3Field / 3) / count;
    }
    return City(name: name, snowiness: snowiness);
  }
}