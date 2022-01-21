import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/presenter/logic/app_logic.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';
import 'package:snow_indicator/presenter/screens/base/base_state.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => assemble.appState;
}

@injectable
class AppState extends BaseState<AppWidget> {
  final AppLogic _logic;

  AppState(this._logic);

  @override
  void initState() {
    _logic.getTheme();
    _logic.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    _logic.removeListener(update);
    _logic.disposeRepository();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return _logic.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MaterialApp(
            initialRoute: Routes.toChosenCities,
            onGenerateRoute: RouteGenerator.generateRoute,
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
            ),
            themeMode: _logic.darkTheme ? ThemeMode.dark : ThemeMode.light,
          );
  }
}
