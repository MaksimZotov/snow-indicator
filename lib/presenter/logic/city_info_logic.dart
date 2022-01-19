import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:snow_indicator/data/databases/database.dart';
import 'package:snow_indicator/domain/entities/city.dart';

class CityInfoLogic extends ChangeNotifier {
  bool _isLoading = false;
  final City _city;
  File? _bg;

  CityInfoLogic(this._city);

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
    CitiesDatabase.instance.update(city);
  }

  void _update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}