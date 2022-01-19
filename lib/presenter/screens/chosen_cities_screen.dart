import 'package:flutter/material.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';

class ChosenCitiesWidget extends StatefulWidget {
  const ChosenCitiesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChosenCitiesState();
}

class ChosenCitiesState extends State<ChosenCitiesWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late final List<City> _cities = [];

  Future _searchCity(BuildContext ctx) async {
    final addedCity = await Navigator.of(ctx).pushNamed(
      Routes.toSearchCity,
    );
    if (addedCity != null && addedCity is City?) {
      _addCity(addedCity as City);
    }
  }

  void _addCity(City city) {
    _listKey.currentState?.insertItem(
      _cities.length,
    );
    setState(() {
      _cities.add(city);
    });
  }

  void _removeCity(int index) {
    _listKey.currentState?.removeItem(
      index,
      (ctx, anim) => _getCityWidget(ctx, index, anim),
    );
    setState(() {
      _cities.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chosen Cities"),
      ),
      body: AnimatedList(
        key: _listKey,
        itemBuilder: (ctx, index, anim) => _getCityWidget(ctx, index, anim),
        initialItemCount: _cities.length,
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
        title: Text(_cities[index].name),
        subtitle: Text("Snowiness: ${_cities[index].snowiness}"),
        leading: const Image(
          image: AssetImage('assets/images/snowflake.png'),
        ),
        onTap: () {
          Navigator.of(ctx).pushNamed(
            Routes.toCityInfo,
            arguments: _cities[index],
          );
        },
      ),
    );
  }
}
