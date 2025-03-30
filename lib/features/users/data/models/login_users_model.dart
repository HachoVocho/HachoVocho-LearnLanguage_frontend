
import 'dart:convert';

import '../../domain/entities/login_users_response_entity.dart';

class LoginUsersResponseModel extends LoginUsersResponseEntity {
  
    const LoginUsersResponseModel({
        required super.success,
        required super.message,
        super.data
    });
    
    factory LoginUsersResponseModel.fromMap(Map<String, dynamic> map) {
        return LoginUsersResponseModel(
        success: map['success'] ?? false,
        message: map['message'] ?? '',
        data: map['data'] ?? '',
        );
    }
    

  factory LoginUsersResponseModel.fromJson(String str) =>
      LoginUsersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    'data': data,
    'message': message,
  };
}


