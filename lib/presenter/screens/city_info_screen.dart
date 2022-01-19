import 'dart:io';
import 'package:flutter/material.dart';
import 'chose_background_dialog.dart';

class CityInfoWidget extends StatefulWidget {
  final String title;

  const CityInfoWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityInfoState(title);
}

class CityInfoState extends State<CityInfoWidget>
    with SingleTickerProviderStateMixin {
  File? _bg;
  final String _title;
  late AnimationController _controller;

  CityInfoState(this._title);

  Future _showChoseBackgroundDialog(BuildContext ctx) async {
    final path = await showDialog(
      context: ctx,
      builder: (_) => const ChoseBackgroundDialog(),
    );
    _bg = null;
    if (path is String?) {
      if (path != null) {
        _bg = File(path);
      }
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
          "24",
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
      duration: const Duration(milliseconds: 1000),
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
          title: Text(_title),
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
