import 'package:flutter/material.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return const MaterialApp(
      initialRoute: Routes.toChosenCities,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}