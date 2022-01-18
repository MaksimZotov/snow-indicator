import 'package:flutter/material.dart';
import 'package:snow_indicator/presenter/screens/chosen_cities_screen.dart';
import 'package:snow_indicator/presenter/screens/city_info_screen.dart';

class Routes {
  static const String toChosenCities = 'toChosenCities';
  static const String toCityInfo = 'toCityInfo';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final route = settings.name;
    final args = settings.arguments;

    switch (route) {
      case Routes.toChosenCities:
        return MaterialPageRoute(
          builder: (ctx) => const ChosenCitiesWidget(),
        );
      case Routes.toCityInfo:
        if (args is String) {
          return MaterialPageRoute(
            builder: (ctx) => CityInfoWidget(
              title: args,
            ),
          );
        }
        throw Exception("Incorrect type of args: ${args.runtimeType}");
    }
    throw Exception("Incorrect route: $route");
  }
}
