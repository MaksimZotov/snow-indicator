import 'package:injectable/injectable.dart';

import '../repository.dart';

@injectable
class DisposeRepositoryUseCase {
  final Repository _repository;
  DisposeRepositoryUseCase(this._repository);

  Future disposeRepository() async {
    return await _repository.disposeRepository();
  }
}