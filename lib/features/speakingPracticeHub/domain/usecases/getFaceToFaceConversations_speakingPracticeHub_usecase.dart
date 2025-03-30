
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
import '../repositories/speakingPracticeHub_repository.dart';

class GetfacetofaceconversationsSpeakingpracticehubUseCase extends UseCase<GetfacetofaceconversationsSpeakingpracticehubResponseEntity, GetfacetofaceconversationsSpeakingpracticehubParamsEntity?> {
  final SpeakingpracticehubRepository _repository;

  GetfacetofaceconversationsSpeakingpracticehubUseCase(this._repository);

  @override
  Stream<Either<Failure, GetfacetofaceconversationsSpeakingpracticehubResponseEntity>> call(GetfacetofaceconversationsSpeakingpracticehubParamsEntity? params) {
    return _repository.getfacetofaceconversationsSpeakingpracticehub(params!);
  }
}
