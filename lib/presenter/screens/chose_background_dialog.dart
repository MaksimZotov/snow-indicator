import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChoseBackgroundDialog extends StatelessWidget {
  const ChoseBackgroundDialog({Key? key}) : super(key: key);
  final padding = 10.0;

  Future _pickImage(BuildContext ctx, ImageSource imageSource) async {
    late final String? path;
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      path = image?.path;
      Navigator.of(ctx).pop<String?>(path);
    } on PlatformException {
      Navigator.of(ctx).pop<String?>(path);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(padding),
                child: const Text(
                  'Do you want to set background?',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding),
                child: OutlinedButton(
                  child: const Text("Yes, from camera"),
                  onPressed: () {
                    _pickImage(ctx, ImageSource.camera);
                  },
                )
              ),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: OutlinedButton(
                    child: const Text("Yes, from gallery"),
                    onPressed: () {
                      _pickImage(ctx, ImageSource.gallery);
                    },
                  )
              ),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: OutlinedButton(
                    child: const Text("Yes, set default background"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
              ),
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: OutlinedButton(
                    child: const Text("No, I don't"),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
