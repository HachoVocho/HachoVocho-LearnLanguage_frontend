
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../entities/markSentenceListened_listeningPracticeHub_response_entity.dart';
import '../repositories/listeningPracticeHub_repository.dart';

class MarksentencelistenedListeningpracticehubUseCase extends UseCase<MarksentencelistenedListeningpracticehubResponseEntity, MarksentencelistenedListeningpracticehubParamsEntity?> {
  final ListeningpracticehubRepository _repository;

  MarksentencelistenedListeningpracticehubUseCase(this._repository);

  @override
  Stream<Either<Failure, MarksentencelistenedListeningpracticehubResponseEntity>> call(MarksentencelistenedListeningpracticehubParamsEntity? params) {
    return _repository.marksentencelistenedListeningpracticehub(params!);
  }
}
