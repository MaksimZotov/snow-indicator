import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/presenter/screens/app_screen.dart';

void main() async {
  setup();
  await GetStorage.init();
  runApp(const AppWidget());
}