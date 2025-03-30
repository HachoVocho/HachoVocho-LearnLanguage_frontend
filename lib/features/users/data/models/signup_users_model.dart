
import 'dart:convert';

import '../../domain/entities/signup_users_response_entity.dart';

class SignupUsersResponseModel extends SignupUsersResponseEntity {
  
    const SignupUsersResponseModel({
        required super.success,
        required super.message,
    });
    
    factory SignupUsersResponseModel.fromMap(Map<String, dynamic> map) {
        return SignupUsersResponseModel(
        success: map['success'] ?? false,
        message: map['message'] ?? '',
        );
    }
    

  factory SignupUsersResponseModel.fromJson(String str) =>
      SignupUsersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    
    'message': message,
  };
}


