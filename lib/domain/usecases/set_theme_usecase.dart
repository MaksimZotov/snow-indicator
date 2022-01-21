import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class SetThemeUseCase {
  final Repository _repository;
  SetThemeUseCase(this._repository);

  void setDarkTheme(bool darkTheme) {
    _repository.setDarkTheme(darkTheme);
  }
}