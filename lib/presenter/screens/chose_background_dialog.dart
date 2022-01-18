import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ChoseBackgroundDialog extends StatelessWidget {
  const ChoseBackgroundDialog({Key? key}) : super(key: key);

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
    return AlertDialog(
      title: const Text("Do you want to set background?"),
      actions: [
        TextButton(
          child: const Text("Yes, from camera"),
          onPressed: () {
            _pickImage(ctx, ImageSource.camera);
          },
        ),
        TextButton(
          child: const Text("Yes, from gallery"),
          onPressed: () {
            _pickImage(ctx, ImageSource.gallery);
          },
        ),
        TextButton(
          child: const Text("Yes, set default background"),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
        TextButton(
          child: const Text("No, I don't"),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    );
  }
}
