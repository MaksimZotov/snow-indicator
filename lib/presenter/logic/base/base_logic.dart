import 'package:flutter/cupertino.dart';

class BaseLogic extends ChangeNotifier {
  @protected
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}