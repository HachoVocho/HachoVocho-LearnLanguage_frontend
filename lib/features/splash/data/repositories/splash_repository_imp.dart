import '../../domain/entities/getStaticStrings_splash_params_entity.dart';
import '../../domain/entities/getStaticStrings_splash_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/repositories/splash_repository.dart';
import '../datasource/network_source.dart';

class SplashRepositoryImp extends SplashRepository {
  final SplashNetworkSource _networkSource;

  SplashRepositoryImp(this._networkSource);
      @override
      Stream<Either<Failure, GetstaticstringsSplashResponseEntity>> getstaticstringsSplash(GetstaticstringsSplashParamsEntity getstaticstringsSplashParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.getstaticstringsSplash(getstaticstringsSplashParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    

  // Implement repository methods here
}
