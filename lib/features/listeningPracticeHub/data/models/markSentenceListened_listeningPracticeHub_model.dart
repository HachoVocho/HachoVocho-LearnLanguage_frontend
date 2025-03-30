
import 'dart:convert';

import '../../domain/entities/markSentenceListened_listeningPracticeHub_response_entity.dart';

class MarksentencelistenedListeningpracticehubResponseModel extends MarksentencelistenedListeningpracticehubResponseEntity {
  
    const MarksentencelistenedListeningpracticehubResponseModel({
        required super.success,
        required super.message,
    });
    
    factory MarksentencelistenedListeningpracticehubResponseModel.fromMap(Map<String, dynamic> map) {
        return MarksentencelistenedListeningpracticehubResponseModel(
        success: map['success'] ?? false,
        message: map['message'] ?? '',
        );
    }
    

  factory MarksentencelistenedListeningpracticehubResponseModel.fromJson(String str) =>
      MarksentencelistenedListeningpracticehubResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
  };
}


