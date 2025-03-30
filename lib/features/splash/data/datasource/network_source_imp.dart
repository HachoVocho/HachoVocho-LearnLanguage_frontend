import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../../domain/entities/getStaticStrings_splash_response_entity.dart';
import '../models/getStaticStrings_splash_model.dart';
import 'network_source.dart';
import '../../../../core/utils/api_service/api_helper_dio.dart';
                       
class SplashNetworkSourceImp extends SplashNetworkSource {
      @override
      Future<GetstaticstringsSplashResponseEntity> getstaticstringsSplash(GetstaticstringsSplashParamsEntity getstaticstringsSplashParamsEntity) async {
        var params = {
      'lang': getstaticstringsSplashParamsEntity.lang,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: 'api/localization/get-static-strings/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model getStaticStrings_splash_model.dart with fromMap(), use that here:
        return GetstaticstringsSplashResponseModel.fromMap(responseFromApi);
      }
    
  // Implement methods here
}
