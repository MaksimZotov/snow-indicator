import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/domain/usecases/update_city_usecase.dart';

class CityInfoLogic extends ChangeNotifier {
  UpdateCityUseCase updateCityUseCase;

  CityInfoLogic(this.updateCityUseCase, {required City city}) {
    _city = city;
  }

  bool _isLoading = false;
  late final City _city;
  File? _bg;

  bool get isLoading => _isLoading;
  City get city => _city;
  File? get bg => _bg;

  Duration getDuration() {
    if (_city.snowiness == 0) {
      return const Duration(milliseconds: 10000);
    } else {
      return Duration(milliseconds: 10000 ~/ _city.snowiness);
    }
  }

  Future setBackground() async {
    _update(() { _isLoading = true; });
    _bg = _city.image != null ? File(_city.image!) : null;
    _update(() { _isLoading = false; });
  }

  void updateCity() {
    updateCityUseCase.updateCity(_city);
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}