import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class GetCitiesByNameUseCase {
  final Repository _repository;
  GetCitiesByNameUseCase(this._repository);

  Future<List<String>> getCityNamesStartedWith(String text) async {
    return await _repository.getCityNamesStartedWith(text);
  }
}