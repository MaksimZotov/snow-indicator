import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class SetThemeUseCase {
  final Repository _repository;
  SetThemeUseCase(this._repository);

  Future<void> setDarkTheme(bool darkTheme) async {
    return await _repository.setDarkTheme(darkTheme);
  }
}