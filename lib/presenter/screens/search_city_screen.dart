import 'package:flutter/material.dart';
import 'package:snow_indicator/presenter/logic/search_city_logic.dart';

class SearchCityWidget extends StatefulWidget {
  const SearchCityWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchCityState();
}

class SearchCityState extends State<SearchCityWidget> {
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text('SearchCity');
  final logic = SearchCityLogic();

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
                          logic.filterCities(text);
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
          itemCount: logic.cities.length,
          separatorBuilder: (BuildContext ctx, int index) => const Divider(
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text(logic.cities[index].name),
            subtitle: Text("Snowiness: ${logic.cities[index].snowiness}"),
            leading: const Image(
              image: AssetImage('assets/images/snowflake.png'),
            ),
            onTap: () {
              Navigator.of(ctx).pop(logic.cities[index]);
            },
          ),
        ));
  }
}
