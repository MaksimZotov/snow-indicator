import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/presenter/logic/app_logic.dart';
import 'package:snow_indicator/presenter/logic/chosen_cities_logic.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';
import 'package:snow_indicator/presenter/screens/base/base_state.dart';
import 'package:snow_indicator/presenter/screens/dialogs/remove_city_dialog.dart';

class ChosenCitiesWidget extends StatefulWidget {
  const ChosenCitiesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => assemble.chosenCitiesState;
}

@injectable
class ChosenCitiesState extends BaseState<ChosenCitiesWidget> {
  final ChosenCitiesLogic _logic;
  final AppLogic _appLogic;

  ChosenCitiesState(this._logic, this._appLogic);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    _logic.initCities();
    _logic.addListener(update);
    _logic.addCityNotifier.addListener(_animateCityAdding);
    _logic.removeCityByIndexNotifier.addListener(_animateCityRemoving);
    _appLogic.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    _logic.removeListener(update);
    _logic.addCityNotifier.removeListener(_animateCityAdding);
    _logic.removeCityByIndexNotifier.removeListener(_animateCityRemoving);
    _appLogic.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chosen Cities"),
        actions: [
          Switch(
            value: _appLogic.darkTheme,
            onChanged: (darkTheme) {
              _appLogic.setDarkTheme(darkTheme);
            },
          )
        ],
      ),
      body: _logic.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimatedList(
              key: _listKey,
              itemBuilder: (ctx, index, anim) =>
                  _getCityWidget(ctx, index, anim),
              initialItemCount: _logic.cities.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _searchCity(ctx);
        },
        tooltip: 'Navigate to search_city_screen',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getCityWidget(BuildContext ctx, int index, Animation anim) {
    return SlideTransition(
      position: anim.drive(
        Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: ListTile(
        title: Text(_logic.cities[index].name),
        subtitle: Text("Snowiness: ${_logic.cities[index].snowiness}"),
        leading: const Image(
          image: AssetImage('assets/images/snowflake.png'),
        ),
        onTap: () {
          Navigator.of(ctx).pushNamed(
            Routes.toCityInfo,
            arguments: _logic.cities[index],
          );
        },
        onLongPress: () => _showRemoveCityDialog(ctx, index),
      ),
    );
  }

  Future _showRemoveCityDialog(BuildContext ctx, int index) async {
    final remove = await showDialog<bool?>(
      context: ctx,
      builder: (_) => RemoveCityDialog(_logic.cities[index].name),
    );
    if (remove != null && remove) {
      _logic.removeCity(index);
    }
  }

  Future _searchCity(BuildContext ctx) async {
    final addedCity = await Navigator.of(ctx).pushNamed(
      Routes.toSearchCity,
    );
    if (addedCity != null && addedCity is String?) {
      _logic.addCity(addedCity as String);
    }
  }

  void _animateCityAdding() {
    _listKey.currentState?.insertItem(_logic.cities.length);
  }

  void _animateCityRemoving() {
    final index = _logic.removeCityByIndexNotifier.value;
    _listKey.currentState?.removeItem(
      index,
      (ctx, anim) => _getCityWidget(ctx, index, anim),
    );
  }
}
