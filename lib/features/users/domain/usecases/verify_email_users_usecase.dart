
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/verify_email_users_params_entity.dart';
import '../entities/verify_email_users_response_entity.dart';
import '../repositories/users_repository.dart';

class VerifyEmailUsersUseCase extends UseCase<VerifyEmailUsersResponseEntity, VerifyEmailUsersParamsEntity?> {
  final UsersRepository _repository;

  VerifyEmailUsersUseCase(this._repository);

  @override
  Stream<Either<Failure, VerifyEmailUsersResponseEntity>> call(VerifyEmailUsersParamsEntity? params) {
    return _repository.verifyEmailUsers(params!);
  }
}
