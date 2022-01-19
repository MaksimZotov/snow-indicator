import 'package:snow_indicator/domain/entities/city.dart';

class CityFields {
  static final List<String> values = [id, name, snowiness, image, time];

  static const String id = '_id';
  static const String name = 'name';
  static const String snowiness = 'snowiness';
  static const String image = 'image';
  static const String time = 'time';
}

class CityConverter {
  static City fromJson(Map<String, Object?> json) => City(
    id: json[CityFields.id] as int?,
    name: json[CityFields.name] as String,
    snowiness: json[CityFields.snowiness] as double,
    image: json[CityFields.image] as String?,
    time: DateTime.parse(json[CityFields.time] as String),
  );

  static Map<String, Object?> toJson(City city) => {
    CityFields.id: city.id,
    CityFields.name: city.name,
    CityFields.snowiness: city.snowiness,
    CityFields.image: city.image,
    CityFields.time: city.time.toIso8601String(),
  };
}