
import 'dart:convert';

import '../../domain/entities/verify_email_users_response_entity.dart';

class VerifyEmailUsersResponseModel extends VerifyEmailUsersResponseEntity {
  
    const VerifyEmailUsersResponseModel({
        required super.success,
        required super.message,
    });
    
    factory VerifyEmailUsersResponseModel.fromMap(Map<String, dynamic> map) {
        return VerifyEmailUsersResponseModel(
        success: map['success'] ?? false,
        message: map['message'] ?? '',
        );
    }
    

  factory VerifyEmailUsersResponseModel.fromJson(String str) =>
      VerifyEmailUsersResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    
    'message': message,
  };
}


