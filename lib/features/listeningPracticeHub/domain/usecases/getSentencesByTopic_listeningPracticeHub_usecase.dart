
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';
import '../repositories/listeningPracticeHub_repository.dart';

class GetsentencesbytopicListeningpracticehubUseCase extends UseCase<GetsentencesbytopicListeningpracticehubResponseEntity, GetsentencesbytopicListeningpracticehubParamsEntity?> {
  final ListeningpracticehubRepository _repository;

  GetsentencesbytopicListeningpracticehubUseCase(this._repository);

  @override
  Stream<Either<Failure, GetsentencesbytopicListeningpracticehubResponseEntity>> call(GetsentencesbytopicListeningpracticehubParamsEntity? params) {
    return _repository.getsentencesbytopicListeningpracticehub(params!);
  }
}
