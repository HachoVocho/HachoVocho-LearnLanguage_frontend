
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';
import '../repositories/listeningPracticeHub_repository.dart';

class GetusertopicsprogressListeningpracticehubUseCase extends UseCase<GetusertopicsprogressListeningpracticehubResponseEntity, GetusertopicsprogressListeningpracticehubParamsEntity?> {
  final ListeningpracticehubRepository _repository;

  GetusertopicsprogressListeningpracticehubUseCase(this._repository);

  @override
  Stream<Either<Failure, GetusertopicsprogressListeningpracticehubResponseEntity>> call(GetusertopicsprogressListeningpracticehubParamsEntity? params) {
    return _repository.getusertopicsprogressListeningpracticehub(params!);
  }
}
