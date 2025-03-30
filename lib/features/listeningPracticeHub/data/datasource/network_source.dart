import '../../domain/entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_response_entity.dart';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';

import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';

abstract class ListeningpracticehubNetworkSource {
  Future<MarksentencelistenedListeningpracticehubResponseEntity> marksentencelistenedListeningpracticehub(MarksentencelistenedListeningpracticehubParamsEntity marksentencelistenedListeningpracticehubParamsEntity);
  Future<GetsentencesbytopicListeningpracticehubResponseEntity> getsentencesbytopicListeningpracticehub(GetsentencesbytopicListeningpracticehubParamsEntity getsentencesbytopicListeningpracticehubParamsEntity);
  Future<GetusertopicsprogressListeningpracticehubResponseEntity> getusertopicsprogressListeningpracticehub(GetusertopicsprogressListeningpracticehubParamsEntity getusertopicsprogressListeningpracticehubParamsEntity);
  // Define abstract methods here
}
