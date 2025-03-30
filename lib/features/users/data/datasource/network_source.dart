import '../../domain/entities/login_users_params_entity.dart';
import '../../domain/entities/login_users_response_entity.dart';

import '../../domain/entities/verify_email_users_params_entity.dart';
import '../../domain/entities/verify_email_users_response_entity.dart';

import '../../domain/entities/signup_users_params_entity.dart';
import '../../domain/entities/signup_users_response_entity.dart';


abstract class UsersNetworkSource {
  Future<LoginUsersResponseEntity> loginUsers(LoginUsersParamsEntity loginUsersParamsEntity);
  Future<VerifyEmailUsersResponseEntity> verifyEmailUsers(VerifyEmailUsersParamsEntity verifyEmailUsersParamsEntity);
  Future<SignupUsersResponseEntity> signupUsers(SignupUsersParamsEntity signupUsersParamsEntity);
}
