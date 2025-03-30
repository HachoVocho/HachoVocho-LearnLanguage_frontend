import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
                       
abstract class SpeakingpracticehubRepository {
  Stream<Either<Failure, GetfacetofaceconversationsSpeakingpracticehubResponseEntity>> getfacetofaceconversationsSpeakingpracticehub(GetfacetofaceconversationsSpeakingpracticehubParamsEntity getfacetofaceconversationsSpeakingpracticehubParamsEntity);
  // Define repository methods here
}
