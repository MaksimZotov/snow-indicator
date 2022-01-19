import 'package:flutter/material.dart';
import 'package:snow_indicator/domain/entities/city.dart';

class SearchCityWidget extends StatefulWidget {
  const SearchCityWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchCityState();
}

List<City> _cities = [
  City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
  City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
  City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
];
List<City> _filteredCities = [
  City(name: 'Magnitogorsk', snowiness: 9.2, time: DateTime.now()),
  City(name: 'Moscow', snowiness: 5.2, time: DateTime.now()),
  City(name: 'Saint-Petersburg', snowiness: 0.5, time: DateTime.now()),
];

class SearchCityState extends State<SearchCityWidget> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('SearchCity');

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
                          setState(() {
                            _filteredCities.clear();
                            for (City city in _cities) {
                              if (city.name.startsWith(text)) {
                                _filteredCities.add(city);
                              }
                            }
                          });
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
          itemCount: _filteredCities.length,
          separatorBuilder: (BuildContext ctx, int index) => const Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(_cities[index].name),
            subtitle: Text("Snowiness: ${_cities[index].snowiness}"),
            leading: const Image(
              image: AssetImage('assets/images/snowflake.png'),
            ),
            onTap: () {
              Navigator.of(ctx).pop(_cities[index]);
            },
          ),
        ));
  }
}
