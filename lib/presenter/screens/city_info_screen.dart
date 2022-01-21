import 'package:flutter/material.dart';
import 'package:snow_indicator/di/annotations.dart';
import 'package:snow_indicator/di/assemble.dart';
import 'package:snow_indicator/domain/entities/city.dart';
import 'package:snow_indicator/presenter/logic/city_info_logic.dart';
import 'package:snow_indicator/presenter/screens/base/base_state.dart';
import 'chose_background_dialog.dart';

class CityInfoWidget extends StatefulWidget {
  final City city;

  const CityInfoWidget({Key? key, required this.city}) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      assemble.getCityInfoStateWithParam(city);
}

@injectableWithDynamicParams
class CityInfoState extends BaseState<CityInfoWidget>
    with SingleTickerProviderStateMixin {
  late final CityInfoLogic _logic;

  CityInfoState(City city) {
    _logic = assemble.getCityInfoLogicWithParam(city);
  }

  late final AnimationController _controller;

  @override
  void initState() {
    _logic.addListener(update);
    _controller = AnimationController(
      duration: _logic.getDuration(),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _logic.removeListener(update);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_logic.city.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () => _showChoseBackgroundDialog(ctx),
            ),
          ],
        ),
        body: _logic.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
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

  Future _showChoseBackgroundDialog(BuildContext ctx) async {
    final image = await showDialog<String?>(
      context: ctx,
      builder: (_) => const ChoseBackgroundDialog(),
    );
    if (image != null) {
      final imageParam =
          image == ChoseBackgroundDialog.defaultBackgroundKey ? null : image;
      _logic.setBackground(imageParam);
    }
  }

  Container _getBackground() => Container(
        child: _logic.bg != null
            ? Image.file(
                _logic.bg!,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
              )
            : null,
      );

  Align _getSnowiness() => Align(
        child: Text(
          _logic.city.snowiness.toString(),
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
}
