import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/domain/entities/city.dart';
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
                  _getCityWidget(ctx, anim, index: index),
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

  Widget _getCityWidget(
    BuildContext ctx,
    Animation anim, {
    int? index,
    City? city,
  }) {
    final type = index != null;
    return SlideTransition(
      position: anim.drive(
        Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: ListTile(
        title: Text(type ? _logic.cities[index!].name : city!.name),
        subtitle: Text(
          "Snowiness:"
          " ${type ? _logic.cities[index!].snowiness : city!.snowiness}",
        ),
        leading: const Image(
          image: AssetImage('assets/images/snowflake.png'),
        ),
        onTap: () {
          if (type) {
            _goToCityInfoScreen(ctx, index!);
          }
        },
        onLongPress: () {
          if (type) {
            _showRemoveCityDialog(ctx, index!);
          }
        },
      ),
    );
  }

  Future _goToCityInfoScreen(BuildContext ctx, int index) async {
    final cityWithPrevImage = _logic.cities[index];
    final curImage = await Navigator.of(ctx).pushNamed(
      Routes.toCityInfo,
      arguments: cityWithPrevImage,
    );
    _logic.cities[index] = cityWithPrevImage.copy(image: curImage as String?);
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
    final indexToCity = _logic.removeCityByIndexNotifier.value;
    if (indexToCity != null) {
      _listKey.currentState?.removeItem(
        indexToCity.key,
        (ctx, anim) => _getCityWidget(ctx, anim, city: indexToCity.value),
      );
    }
  }
}
