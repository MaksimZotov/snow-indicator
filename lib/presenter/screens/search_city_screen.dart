import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/presenter/logic/search_city_logic.dart';
import 'package:snow_indicator/presenter/screens/base/base_state.dart';

class SearchCityWidget extends StatefulWidget {
  const SearchCityWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => assemble.searchCityState;
}

@injectable
class SearchCityState extends BaseState<SearchCityWidget> {
  final SearchCityLogic _logic;

  SearchCityState(this._logic);

  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('SearchCity');

  @override
  void initState() {
    _logic.addListener(update);
    _logic.filterCities("");
    super.initState();
  }

  @override
  void dispose() {
    _logic.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      title: TextField(
                        onChanged: (text) {
                          _logic.filterCities(text);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Some city...',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text('SearchCity');
                  }
                });
              },
              icon: customIcon,
            )
          ],
        ),
        body: ListView.separated(
          itemCount: _logic.cities.length,
          separatorBuilder: (BuildContext ctx, int index) => const Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(_logic.cities[index].name),
            subtitle: Text("Snowiness: ${_logic.cities[index].snowiness}"),
            leading: const Image(
              image: AssetImage('assets/images/snowflake.png'),
            ),
            onTap: () {
              Navigator.of(ctx).pop(_logic.cities[index]);
            },
          ),
        ));
  }
}
