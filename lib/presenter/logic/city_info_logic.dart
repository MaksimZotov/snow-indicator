import 'dart:io';
import 'package:snow_indicator/di/annotations.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/get_city_usecase.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectableWithDynamicParams
class CityInfoLogic extends BaseLogic {
  final GetCityUseCase _getCityUseCase;
  final UpdateCityUseCase _updateCityUseCase;
  City _city;

  CityInfoLogic(this._getCityUseCase, this._updateCityUseCase, this._city);

  File? _bg;

  City get city => _city;

  File? get bg => _bg;

  Duration getDuration() {
    if (city.snowiness == 0) {
      return const Duration(milliseconds: 10000);
    } else {
      return Duration(milliseconds: 10000 ~/ city.snowiness);
    }
  }

  Future getActualCityState() async {
    showLoading();
    _city = await _getCityUseCase.getCity(city.id!);
    hideLoading();
    setBackground();
  }

  void setBackground({String? image}) {
    if (image != city.image) {
      update(() {
        _city = city.copy(image: image);
        _updateCityUseCase.updateCity(city);
        _bg = city.image != null ? File(city.image!) : null;
      });
    }
  }
}
