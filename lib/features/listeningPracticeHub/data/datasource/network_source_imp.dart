import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_response_entity.dart';
import '../models/markSentenceListened_listeningPracticeHub_model.dart';
import '../models/getSentencesByTopic_listeningPracticeHub_model.dart';
import '../models/getUserTopicsProgress_listeningPracticeHub_model.dart';
import '../../../../core/utils/api_service/api_helper_dio.dart';

import 'network_source.dart';
                       
class ListeningpracticehubNetworkSourceImp extends ListeningpracticehubNetworkSource {
      @override
      Future<MarksentencelistenedListeningpracticehubResponseEntity> marksentencelistenedListeningpracticehub(MarksentencelistenedListeningpracticehubParamsEntity marksentencelistenedListeningpracticehubParamsEntity) async {
        var params = {
      'user_id': marksentencelistenedListeningpracticehubParamsEntity.userId,
      'sentence_id': marksentencelistenedListeningpracticehubParamsEntity.sentenceId,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: '/api/users/mark_sentence_listened/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model markSentenceListened_listeningPracticeHub_model.dart with fromMap(), use that here:
        return MarksentencelistenedListeningpracticehubResponseModel.fromMap(responseFromApi);
      }
    
      @override
      Future<GetsentencesbytopicListeningpracticehubResponseEntity> getsentencesbytopicListeningpracticehub(GetsentencesbytopicListeningpracticehubParamsEntity getsentencesbytopicListeningpracticehubParamsEntity) async {
        var params = {
      'user_id': getsentencesbytopicListeningpracticehubParamsEntity.userId,
      'topic_id': getsentencesbytopicListeningpracticehubParamsEntity.topicId,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: '/api/listening/get_sentences_by_topic/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model getSentencesByTopic_listeningPracticeHub_model.dart with fromMap(), use that here:
        return GetsentencesbytopicListeningpracticehubResponseModel.fromMap(responseFromApi);
      }
    
      @override
      Future<GetusertopicsprogressListeningpracticehubResponseEntity> getusertopicsprogressListeningpracticehub(GetusertopicsprogressListeningpracticehubParamsEntity getusertopicsprogressListeningpracticehubParamsEntity) async {
        var params = {
      'user_id': getusertopicsprogressListeningpracticehubParamsEntity.userId,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: '/api/users/topics_progress/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model getUserTopicsProgress_listeningPracticeHub_model.dart with fromMap(), use that here:
        return GetusertopicsprogressListeningpracticehubResponseModel.fromMap(responseFromApi);
      }
  
    
  // Implement methods here
}
