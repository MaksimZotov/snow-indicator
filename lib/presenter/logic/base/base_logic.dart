import 'package:flutter/cupertino.dart';

class BaseLogic extends ChangeNotifier {
  @protected
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void showLoading() => update(() => _isLoading = true);

  void hideLoading() => update(() => _isLoading = false);

  @protected
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
