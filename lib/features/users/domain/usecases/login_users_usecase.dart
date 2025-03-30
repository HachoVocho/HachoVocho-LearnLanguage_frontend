
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_users_params_entity.dart';
import '../entities/login_users_response_entity.dart';
import '../repositories/users_repository.dart';

class LoginUsersUseCase extends UseCase<LoginUsersResponseEntity, LoginUsersParamsEntity?> {
  final UsersRepository _repository;

  LoginUsersUseCase(this._repository);

  @override
  Stream<Either<Failure, LoginUsersResponseEntity>> call(LoginUsersParamsEntity? params) {
    return _repository.loginUsers(params!);
  }
}
