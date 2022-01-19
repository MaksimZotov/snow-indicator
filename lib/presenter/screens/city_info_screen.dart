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
  File? bg;
  final String title;
  late AnimationController _controller;

  CityInfoState(this.title);

  Future _showChoseBackgroundDialog(BuildContext ctx) async {
    final path = await showDialog(
      context: ctx,
      builder: (_) => const ChoseBackgroundDialog(),
    );
    bg = null;
    if (path is String?) {
      if (path != null) {
        bg = File(path);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 1000),
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
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () => _showChoseBackgroundDialog(ctx),
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              child: bg != null
                  ? Image.file(
                      bg!,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    )
                  : null,
            ),
            Align(
              child: Text(
                "24",
                style: TextStyle(
                    fontSize: 54,
                    color: Colors.lightBlueAccent,
                    background: Paint()
                      ..color = Colors.blue
                      ..style = PaintingStyle.stroke),
              ),
            ),
            Positioned(
              top: 25,
              left: 25,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: const Image(
                  image: AssetImage('assets/images/snowflake.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              left: 25,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: const Image(
                  image: AssetImage('assets/images/snowflake.png'),
                ),
              ),
            ),
            Positioned(
              top: 25,
              right: 25,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: const Image(
                  image: AssetImage('assets/images/snowflake.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              right: 25,
              child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: const Image(
                  image: AssetImage('assets/images/snowflake.png'),
                ),
              ),
            ),
          ],
        ));
  }
}
