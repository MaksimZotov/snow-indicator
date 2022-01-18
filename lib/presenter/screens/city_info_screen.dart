import 'dart:io';
import 'package:flutter/material.dart';
import 'chose_background_dialog.dart';

class CityInfoWidget extends StatefulWidget {
  final String title;

  const CityInfoWidget({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CityInfoState(title);
}

class CityInfoState extends State<CityInfoWidget> {
  File? bg;
  final String title;

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

  CityInfoState(this.title);

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
      body: bg != null
          ? Image.file(
              bg!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            )
          : null,
    );
  }
}
