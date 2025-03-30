import '../../domain/entities/login_users_params_entity.dart';
import '../../domain/entities/login_users_response_entity.dart';import '../../domain/entities/verify_email_users_params_entity.dart';
import '../../domain/entities/verify_email_users_response_entity.dart';import '../../domain/entities/signup_users_params_entity.dart';
import '../../domain/entities/signup_users_response_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/failures/failures.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasource/network_source.dart';

class UsersRepositoryImp extends UsersRepository {
  final UsersNetworkSource _networkSource;

  UsersRepositoryImp(this._networkSource);
      @override
      Stream<Either<Failure, LoginUsersResponseEntity>> loginUsers(LoginUsersParamsEntity loginUsersParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.loginUsers(loginUsersParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    
      @override
      Stream<Either<Failure, VerifyEmailUsersResponseEntity>> verifyEmailUsers(VerifyEmailUsersParamsEntity verifyEmailUsersParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.verifyEmailUsers(verifyEmailUsersParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    
      @override
      Stream<Either<Failure, SignupUsersResponseEntity>> signupUsers(SignupUsersParamsEntity signupUsersParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.signupUsers(signupUsersParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    

  // Implement repository methods here
}
