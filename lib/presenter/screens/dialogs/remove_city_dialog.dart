import 'package:flutter/material.dart';

class RemoveCityDialog extends StatelessWidget {
  final String _city;

  const RemoveCityDialog(this._city, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    const padding = 10.0;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(padding),
                child: Text(
                  'Do you want to remove $_city?',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(padding),
                child: ElevatedButton(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
