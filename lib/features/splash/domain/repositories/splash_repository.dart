import '../entities/getStaticStrings_splash_params_entity.dart';
import '../entities/getStaticStrings_splash_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
                       
abstract class SplashRepository {
  Stream<Either<Failure, GetstaticstringsSplashResponseEntity>> getstaticstringsSplash(GetstaticstringsSplashParamsEntity getstaticstringsSplashParamsEntity);
  // Define repository methods here
}
