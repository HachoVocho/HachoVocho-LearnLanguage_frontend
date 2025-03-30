import '../entities/login_users_params_entity.dart';
import '../entities/login_users_response_entity.dart';import '../entities/verify_email_users_params_entity.dart';
import '../entities/verify_email_users_response_entity.dart';import '../entities/signup_users_params_entity.dart';
import '../entities/signup_users_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
                       
abstract class UsersRepository {
  Stream<Either<Failure, LoginUsersResponseEntity>> loginUsers(LoginUsersParamsEntity loginUsersParamsEntity);
  Stream<Either<Failure, VerifyEmailUsersResponseEntity>> verifyEmailUsers(VerifyEmailUsersParamsEntity verifyEmailUsersParamsEntity);
  Stream<Either<Failure, SignupUsersResponseEntity>> signupUsers(SignupUsersParamsEntity signupUsersParamsEntity);
  // Define repository methods here
}
