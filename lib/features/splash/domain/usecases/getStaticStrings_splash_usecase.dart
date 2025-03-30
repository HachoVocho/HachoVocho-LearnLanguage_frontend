
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/getStaticStrings_splash_params_entity.dart';
import '../entities/getStaticStrings_splash_response_entity.dart';
import '../repositories/splash_repository.dart';

class GetstaticstringsSplashUseCase extends UseCase<GetstaticstringsSplashResponseEntity, GetstaticstringsSplashParamsEntity?> {
  final SplashRepository _repository;

  GetstaticstringsSplashUseCase(this._repository);

  @override
  Stream<Either<Failure, GetstaticstringsSplashResponseEntity>> call(GetstaticstringsSplashParamsEntity? params) {
    return _repository.getstaticstringsSplash(params!);
  }
}
