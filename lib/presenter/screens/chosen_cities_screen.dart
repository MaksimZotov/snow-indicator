import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/presenter/logic/chosen_cities_logic.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';

class ChosenCitiesWidget extends StatefulWidget {
  const ChosenCitiesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => assemble.chosenCitiesState;
}

@injectable
class ChosenCitiesState extends State<ChosenCitiesWidget> {
  final ChosenCitiesLogic _logic;
  ChosenCitiesState(this._logic);

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  Future _searchCity(BuildContext ctx) async {
    final addedCity = await Navigator.of(ctx).pushNamed(
      Routes.toSearchCity,
    );
    if (addedCity != null && addedCity is City?) {
      _addCity(addedCity as City);
    }
  }

  void _addCity(City city) {
    _listKey.currentState?.insertItem(_logic.cities.length);
    _logic.addCity(city);
  }

  void _removeCity(int index) {
    _listKey.currentState?.removeItem(
      index,
      (ctx, anim) => _getCityWidget(ctx, index, anim),
    );
    _logic.removeCity(index);
  }

  @override
  void initState() {
    _logic.addListener(_update);
    _logic.getChosenCities();
    super.initState();
  }

  @override
  void dispose() {
    _logic.removeListener(_update);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chosen Cities"),
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
        onLongPress: () => showDialog(
          context: ctx,
          builder: (BuildContext ctx) {
            const padding = 10.0;
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Wrap(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(padding),
                        child: Text(
                          'Do you want to remove ${_logic.cities[index].name}?',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(padding),
                        child: ElevatedButton(
                          child: const Text('Yes'),
                          onPressed: () {
                            _removeCity(index);
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(padding),
                        child: ElevatedButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _update() {
    setState(() {});
  }
}
