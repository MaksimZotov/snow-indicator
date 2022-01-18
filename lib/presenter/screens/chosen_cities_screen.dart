import 'package:flutter/material.dart';
import 'package:snow_indicator/presenter/navigation/route_generator.dart';

class ChosenCitiesWidget extends StatefulWidget {
  const ChosenCitiesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChosenCitiesState();
}

class ChosenCitiesState extends State<ChosenCitiesWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late final List<String> _items = [];

  void _addItem(String title) {
    _listKey.currentState?.insertItem(_items.length);
    setState(() {
      _items.add(title);
    });
  }

  void _removeItem(int index) {
    _listKey.currentState
        ?.removeItem(index, (ctx, anim) => _slideItem(ctx, index, anim));
    setState(() {
      _items.removeAt(index);
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
        itemBuilder: (ctx, index, anim) => _slideItem(ctx, index, anim),
        initialItemCount: _items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem("Item ${_items.length}"),
        tooltip: 'Navigate to search_city_screen',
        child: const Icon(
          Icons.add,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _slideItem(BuildContext ctx, int index, Animation anim) {
    return SlideTransition(
      position: anim.drive(
        Tween(
          begin: const Offset(-1, 0),
          end: const Offset(0, 0),
        ),
      ),
      child: ListTile(
        title: Text(_items[index]),
        subtitle: index.isOdd ? const Text("subtitle") : null,
        leading: const Image(
          image: AssetImage('assets/images/snowflake.png'),
        ),
        onTap: () {
          Navigator.of(ctx).pushNamed(
            Routes.toCityInfo,
            arguments: _items[index],
          );
        },
      ),
    );
  }
}
