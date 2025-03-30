import '../entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../entities/markSentenceListened_listeningPracticeHub_response_entity.dart';import '../entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';import '../entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';

abstract class ListeningpracticehubRepository {
  Stream<Either<Failure, MarksentencelistenedListeningpracticehubResponseEntity>> marksentencelistenedListeningpracticehub(MarksentencelistenedListeningpracticehubParamsEntity marksentencelistenedListeningpracticehubParamsEntity);
  Stream<Either<Failure, GetsentencesbytopicListeningpracticehubResponseEntity>> getsentencesbytopicListeningpracticehub(GetsentencesbytopicListeningpracticehubParamsEntity getsentencesbytopicListeningpracticehubParamsEntity);
  Stream<Either<Failure, GetusertopicsprogressListeningpracticehubResponseEntity>> getusertopicsprogressListeningpracticehub(GetusertopicsprogressListeningpracticehubParamsEntity getusertopicsprogressListeningpracticehubParamsEntity);
  // Define repository methods here
}
