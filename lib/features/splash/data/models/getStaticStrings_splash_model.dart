
import 'dart:convert';

import '../../domain/entities/getStaticStrings_splash_response_entity.dart';

class GetstaticstringsSplashResponseModel extends GetstaticstringsSplashResponseEntity {
  
    @override
  final Map data;
    
    const GetstaticstringsSplashResponseModel({
        required super.success,
        required this.data,
        required super.message,
    }) : super(
            data: data,
        );
    
    factory GetstaticstringsSplashResponseModel.fromMap(Map<String, dynamic> map) {
        return GetstaticstringsSplashResponseModel(
        success: map['success'] ?? false,
        data: map['data'],
        message: map['message'] ?? '',
        );
    }
    

  factory GetstaticstringsSplashResponseModel.fromJson(String str) =>
      GetstaticstringsSplashResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    'data': data,
    'message': message,
  };
}

