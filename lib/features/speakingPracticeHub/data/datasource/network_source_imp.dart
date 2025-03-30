import '../../../../core/utils/api_service/api_helper_dio.dart';
import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
import '../models/getFaceToFaceConversations_speakingPracticeHub_response_model.dart';
import 'network_source.dart';
                       
class SpeakingpracticehubNetworkSourceImp extends SpeakingpracticehubNetworkSource {
      @override
      Future<GetfacetofaceconversationsSpeakingpracticehubResponseEntity> getfacetofaceconversationsSpeakingpracticehub(GetfacetofaceconversationsSpeakingpracticehubParamsEntity getfacetofaceconversationsSpeakingpracticehubParamsEntity) async {
        var params = {
      'user_id': getfacetofaceconversationsSpeakingpracticehubParamsEntity.userId,
        };
    
        var _responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: '/api/speaking/get_face_to_face_conversations/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model getFaceToFaceConversations_speakingPracticeHub_model.dart with fromMap(), use that here:
        return GetfacetofaceconversationsSpeakingpracticehubResponseModel.fromMap(_responseFromApi);
      }
    
  // Implement methods here
}
