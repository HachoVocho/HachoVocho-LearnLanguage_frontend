import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
import '../../domain/repositories/speakingPracticeHub_repository.dart';
import '../datasource/network_source.dart';

class SpeakingpracticehubRepositoryImp extends SpeakingpracticehubRepository {
  final SpeakingpracticehubNetworkSource _networkSource;

  SpeakingpracticehubRepositoryImp(this._networkSource);
      @override
      Stream<Either<Failure, GetfacetofaceconversationsSpeakingpracticehubResponseEntity>> getfacetofaceconversationsSpeakingpracticehub(GetfacetofaceconversationsSpeakingpracticehubParamsEntity getfacetofaceconversationsSpeakingpracticehubParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.getfacetofaceconversationsSpeakingpracticehub(getfacetofaceconversationsSpeakingpracticehubParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    

  // Implement repository methods here
}
