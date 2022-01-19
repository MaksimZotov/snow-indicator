import 'dart:io';
import 'package:flutter/material.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'chose_background_dialog.dart';

class CityInfoWidget extends StatefulWidget {
  final City city;

  const CityInfoWidget({Key? key, required this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityInfoState(city);
}

class CityInfoState extends State<CityInfoWidget>
    with SingleTickerProviderStateMixin {
  File? _bg;
  final City _city;
  late AnimationController _controller;

  CityInfoState(this._city);

  Duration _getDuration() {
    if (_city.snowiness == 0) {
      return const Duration(milliseconds: 10000);
    } else {
      return Duration(milliseconds: 10000 ~/ _city.snowiness);
    }
  }

  Future _showChoseBackgroundDialog(BuildContext ctx) async {
    final path = await showDialog<String?>(
      context: ctx,
      builder: (_) => const ChoseBackgroundDialog(),
    );
    _bg = null;
    if (path != null) {
      _bg = File(path);
    }
    setState(() {});
  }

  Container _getBackground() => Container(
        child: _bg != null
            ? Image.file(
                _bg!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              )
            : null,
      );

  Align _getSnowiness() => Align(
        child: Text(
          _city.snowiness.toString(),
          style: TextStyle(
              fontSize: 54,
              color: Colors.lightBlueAccent,
              background: Paint()
                ..color = Colors.blue
                ..style = PaintingStyle.stroke),
        ),
      );

  Positioned _getSnowflake({
    double? top,
    double? right,
    double? bottom,
    double? left,
  }) =>
      Positioned(
        top: top,
        right: right,
        bottom: bottom,
        left: left,
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: const Image(
            image: AssetImage('assets/images/snowflake.png'),
          ),
        ),
      );

  @override
  void initState() {
    _controller = AnimationController(
      duration: _getDuration(),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_city.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () => _showChoseBackgroundDialog(ctx),
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            _getBackground(),
            _getSnowiness(),
            _getSnowflake(top: 25, left: 25),
            _getSnowflake(top: 25, right: 25),
            _getSnowflake(bottom: 25, left: 25),
            _getSnowflake(bottom: 25, right: 25),
          ],
        ));
  }
}
