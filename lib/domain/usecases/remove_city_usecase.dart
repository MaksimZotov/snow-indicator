import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class RemoveCityUseCase {
  final Repository _repository;
  RemoveCityUseCase(this._repository);

  Future removeCity(int id) async {
    await _repository.removeCity(id);
  }
}