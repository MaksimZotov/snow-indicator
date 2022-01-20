import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:snow_indicator/di/annotations.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@injectableWithParameters
class CityInfoLogic extends BaseLogic {
  UpdateCityUseCase updateCityUseCase;
  City _city;

  CityInfoLogic(this.updateCityUseCase, this._city);

  bool _isLoading = false;
  File? _bg;

  City get city => _city;
  bool get isLoading => _isLoading;
  File? get bg => _bg;

  Duration getDuration() {
    if (_city.snowiness == 0) {
      return const Duration(milliseconds: 10000);
    } else {
      return Duration(milliseconds: 10000 ~/ _city.snowiness);
    }
  }

  Future setBackground({String? image}) async {
    if (image != _city.image) {
      update(() {
        _isLoading = true;
      });
      _city = _city.copy(image: image);
      updateCityUseCase.updateCity(_city);
      _bg = _city.image != null ? File(_city.image!) : null;
      update(() {
        _isLoading = false;
      });
    }
  }
}