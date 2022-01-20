import 'package:injectable/injectable.dart';
import 'package:snow_indicator/domain/usecases/get_theme_usecase.dart';
import 'package:snow_indicator/domain/usecases/set_theme_usecase.dart';
import 'package:snow_indicator/presenter/logic/base/base_logic.dart';

@singleton
class AppLogic extends BaseLogic {
  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  AppLogic(this._getThemeUseCase, this._setThemeUseCase);

  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  Future getTheme() async {
    showLoading();
    _darkTheme = await _getThemeUseCase.getDarkTheme();
    hideLoading();
  }

  void setDarkTheme(bool darkTheme) {
    update(() {
      _darkTheme = darkTheme;
    });
    _setThemeUseCase.setDarkTheme(darkTheme);
  }
}
