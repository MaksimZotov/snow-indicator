import 'package:flutter/material.dart';

class CityInfoWidget extends StatefulWidget {
  final String title;

  const CityInfoWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityInfoState(title);
}

class CityInfoState extends State<CityInfoWidget> {
  final String title;

  CityInfoState(this.title);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
