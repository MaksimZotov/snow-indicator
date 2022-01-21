import 'dart:io';
import 'package:snow_indicator/di/annotations.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectableWithDynamicParams
class CityInfoLogic extends BaseLogic {
  final UpdateCityUseCase _updateCityUseCase;
  City _city;

  CityInfoLogic(this._updateCityUseCase, this._city);

  City get city => _city;

  File? get bg => city.image != null ? File(city.image!) : null;

  Duration getDuration() {
    if (city.snowiness == 0) {
      return const Duration(milliseconds: 10000);
    } else {
      return Duration(milliseconds: 1000 ~/ city.snowiness);
    }
  }

  void setBackground(String? image) {
    update(() {
      _city = city.copy(image: image);
      _updateCityUseCase.updateCity(city);
    });
  }
}
