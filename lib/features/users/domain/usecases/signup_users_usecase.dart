
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/signup_users_params_entity.dart';
import '../entities/signup_users_response_entity.dart';
import '../repositories/users_repository.dart';

class SignupUsersUseCase extends UseCase<SignupUsersResponseEntity, SignupUsersParamsEntity?> {
  final UsersRepository _repository;

  SignupUsersUseCase(this._repository);

  @override
  Stream<Either<Failure, SignupUsersResponseEntity>> call(SignupUsersParamsEntity? params) {
    return _repository.signupUsers(params!);
  }
}
