import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class GetThemeUseCase {
  final Repository _repository;
  GetThemeUseCase(this._repository);

  Future<bool> getDarkTheme() async {
    return await _repository.getDarkTheme();
  }
}