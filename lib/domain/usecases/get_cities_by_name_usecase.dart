import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/entities/city.dart';

@injectable
class GetCitiesByNameUseCase {
  final List<City> _cities = [
    City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
    City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
    City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
  ];

  List<City> getCitiesByName(String text) {
    List<City> cities = [];
    for (City city in _cities) {
      if (city.name.toLowerCase().startsWith(text.toLowerCase())) {
        cities.add(city);
      }
    }
    return cities;
  }
}