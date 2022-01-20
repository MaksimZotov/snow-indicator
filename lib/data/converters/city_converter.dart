import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@singleton
class CityFields {
  late final List<String> values = [id, name, snowiness, image, time];

  final String id = '_id';
  final String name = 'name';
  final String snowiness = 'snowiness';
  final String image = 'image';
  final String time = 'time';
}

@singleton
class CityConverter {
  final CityFields _cityFields;
  CityConverter(this._cityFields);

  City fromJson(Map<String, Object?> json) => City(
    id: json[_cityFields.id] as int?,
    name: json[_cityFields.name] as String,
    snowiness: json[_cityFields.snowiness] as double,
    image: json[_cityFields.image] as String?,
    time: DateTime.parse(json[_cityFields.time] as String),
  );

  Map<String, Object?> toJson(City city) => {
   _cityFields.id: city.id,
   _cityFields.name: city.name,
   _cityFields.snowiness: city.snowiness,
   _cityFields.image: city.image,
   _cityFields.time: city.time.toIso8601String(),
  };
}