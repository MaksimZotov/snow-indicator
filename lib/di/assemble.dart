import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/data/converters/city_converter.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/city_info_logic.dart';
import 'package:snow_indicator/presenter/screens/chosen_cities_screen.dart';
import 'package:snow_indicator/presenter/screens/city_info_screen.dart';
import 'package:snow_indicator/presenter/screens/search_city_screen.dart';

import 'assemble.config.dart';

final getIt = GetIt.I;

@InjectableInit()
void setup() {
  $initGetIt(getIt);
  getIt.registerFactoryParam<CityInfoLogic, City, void>(
    (city, _) => CityInfoLogic(getIt.get<UpdateCityUseCase>(), city),
  );
  getIt.registerFactoryParam<CityInfoState, City, void>(
    (city, _) => CityInfoState(city),
  );
}

// Class for providing of instances
@module
abstract class AssembleModule {}

class Assemble {
  const Assemble._();

  CityConverter get cityConverter => getIt.get<CityConverter>();

  ChosenCitiesState get chosenCitiesState => getIt.get<ChosenCitiesState>();

  SearchCityState get searchCityState => getIt.get<SearchCityState>();

  CityInfoState getCityInfoStateWithParam(City city) =>
      getIt.get<CityInfoState>(param1: city);

  CityInfoLogic getCityInfoLogicWithParam(City city) =>
      getIt.get<CityInfoLogic>(param1: city);
}

const assemble = Assemble._();