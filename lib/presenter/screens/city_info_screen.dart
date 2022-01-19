import 'package:flutter/material.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/presenter/logic/city_info_logic.dart';
import 'chose_background_dialog.dart';

class CityInfoWidget extends StatefulWidget {
  final City city;

  const CityInfoWidget({Key? key, required this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityInfoState(city: city);
}

class CityInfoState extends State<CityInfoWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CityInfoLogic logic;

  CityInfoState({required City city}){
    logic = CityInfoLogic(city);
  }

  Future _showChoseBackgroundDialog(BuildContext ctx) async {
    logic.city.image = await showDialog<String?>(
      context: ctx,
      builder: (_) => const ChoseBackgroundDialog(),
    );
    logic.updateCity();
    await logic.setBackground();
  }

  Container _getBackground() => Container(
        child: logic.bg != null
            ? Image.file(
                logic.bg!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              )
            : null,
      );

  Align _getSnowiness() => Align(
        child: Text(
          logic.city.snowiness.toString(),
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
    logic.addListener(_update);
    _controller = AnimationController(
      duration: logic.getDuration(),
      vsync: this,
    );
    _controller.repeat();
    logic.setBackground();
    super.initState();
  }

  @override
  void dispose() {
    logic.removeListener(_update);
    _controller.dispose();
    logic.closeDatabase();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text(logic.city.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () => _showChoseBackgroundDialog(ctx),
            ),
          ],
        ),
        body: logic.isLoading
            ? const CircularProgressIndicator()
            : Stack(
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

  void _update() {
    setState(() { });
  }
}
