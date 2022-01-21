import 'package:flutter/cupertino.dart';

class BaseLogic extends ChangeNotifier {
  @protected
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @protected
  void showLoading() => update(() => _isLoading = true);

  @protected
  void hideLoading() => update(() => _isLoading = false);

  @protected
  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }
}
