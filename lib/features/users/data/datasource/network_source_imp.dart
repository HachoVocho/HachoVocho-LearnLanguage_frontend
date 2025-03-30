import '../../domain/entities/login_users_params_entity.dart';
import '../../domain/entities/login_users_response_entity.dart';
import '../models/login_users_model.dart';import '../../domain/entities/verify_email_users_params_entity.dart';
import '../../domain/entities/verify_email_users_response_entity.dart';
import '../models/verify_email_users_model.dart';import '../../domain/entities/signup_users_params_entity.dart';
import '../../domain/entities/signup_users_response_entity.dart';
import '../models/signup_users_model.dart';
import 'network_source.dart';
import '../../../../core/utils/api_service/api_helper_dio.dart';
                       
class UsersNetworkSourceImp extends UsersNetworkSource {
      @override
      Future<LoginUsersResponseEntity> loginUsers(LoginUsersParamsEntity loginUsersParamsEntity) async {
        var params = {
      'email': loginUsersParamsEntity.email,
      'password': loginUsersParamsEntity.password,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: 'api/users/login/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model login_users_model.dart with fromMap(), use that here:
        return LoginUsersResponseModel.fromMap(responseFromApi);
      }
    
      @override
      Future<VerifyEmailUsersResponseEntity> verifyEmailUsers(VerifyEmailUsersParamsEntity verifyEmailUsersParamsEntity) async {
        var params = {
      'email': verifyEmailUsersParamsEntity.email,
      'code': verifyEmailUsersParamsEntity.code,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: 'api/users/verify-email/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model verify_email_users_model.dart with fromMap(), use that here:
        return VerifyEmailUsersResponseModel.fromMap(responseFromApi);
      }
    
      @override
      Future<SignupUsersResponseEntity> signupUsers(SignupUsersParamsEntity signupUsersParamsEntity) async {
        var params = {
      'first_name': signupUsersParamsEntity.firstName,
      'last_name': signupUsersParamsEntity.lastName,
      'email': signupUsersParamsEntity.email,
      'password': signupUsersParamsEntity.password,
      'gender': signupUsersParamsEntity.gender,
      'date_of_birth': signupUsersParamsEntity.dateOfBirth,
        };
    
        var responseFromApi = await ApiHelperDio().postDioMethod(
          endpoint: 'api/users/signup/',
          params: params,
          isInFormData: false,
        );
    
        // If you have a model signup_users_model.dart with fromMap(), use that here:
        return SignupUsersResponseModel.fromMap(responseFromApi);
      }
    
  // Implement methods here
}
