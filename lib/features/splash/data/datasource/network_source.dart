import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../../domain/entities/getStaticStrings_splash_response_entity.dart';


abstract class SplashNetworkSource {
  Future<GetstaticstringsSplashResponseEntity> getstaticstringsSplash(GetstaticstringsSplashParamsEntity getstaticstringsSplashParamsEntity);
  // Define abstract methods here
}
