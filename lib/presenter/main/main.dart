import 'package:flutter/material.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return const MaterialApp(
      initialRoute: Routes.toChosenCities,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}