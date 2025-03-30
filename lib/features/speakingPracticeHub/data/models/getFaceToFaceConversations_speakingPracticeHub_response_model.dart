import 'dart:convert';
import 'package:equatable/equatable.dart';

import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';

// Main Response Model
class GetfacetofaceconversationsSpeakingpracticehubResponseModel
    extends GetfacetofaceconversationsSpeakingpracticehubResponseEntity {
  final List<GetfacetofaceconversationsSpeakingpracticehubDataModel> data;

  GetfacetofaceconversationsSpeakingpracticehubResponseModel({
    required bool success,
    required this.data,
    required String message,
  }) : super(success: success, data: data, message: message);

  factory GetfacetofaceconversationsSpeakingpracticehubResponseModel.fromMap(Map<String, dynamic> map) {
    return GetfacetofaceconversationsSpeakingpracticehubResponseModel(
      success: map['success'] ?? false,
      data: List<GetfacetofaceconversationsSpeakingpracticehubDataModel>.from(
        (map['data'] ?? []).map((item) => GetfacetofaceconversationsSpeakingpracticehubDataModel.fromMap(item)),
      ),
      message: map['message'] ?? '',
    );
  }

  factory GetfacetofaceconversationsSpeakingpracticehubResponseModel.fromJson(String str) =>
      GetfacetofaceconversationsSpeakingpracticehubResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data.map((item) => item.toMap()).toList(),
        'message': message,
      };
}

// Data Model for Grouped Conversations
class GetfacetofaceconversationsSpeakingpracticehubDataModel
    extends GetfacetofaceconversationsSpeakingpracticehubDataEntity {
  final String date;
  final List<GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel> conversations;

  GetfacetofaceconversationsSpeakingpracticehubDataModel({
    required this.date,
    required this.conversations,
  }) : super(date: date, conversations: conversations);

  factory GetfacetofaceconversationsSpeakingpracticehubDataModel.fromMap(Map<String, dynamic> map) {
    return GetfacetofaceconversationsSpeakingpracticehubDataModel(
      date: map['date'] ?? '',
      conversations: List<GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel>.from(
        (map['conversations'] ?? [])
            .map((item) => GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel.fromMap(item)),
      ),
    );
  }

  Map<String, dynamic> toMap() => {
        'date': date,
        'conversations': conversations.map((item) => item.toMap()).toList(),
      };

  factory GetfacetofaceconversationsSpeakingpracticehubDataModel.fromJson(String str) =>
      GetfacetofaceconversationsSpeakingpracticehubDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}

// Data Model for Individual Conversations
class GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel
    extends GetfacetofaceconversationsSpeakingpracticehubDataConversationsEntity {
  final int id;
  final String userId;
  final String preferredLanguage;
  final String learningLanguage;
  final String learningLanguageLevel;
  final String transcription;
  final String translation;
  final String suggestedResponsePreferred;
  final String suggestedResponseLearning;
  final String createdAt;

  GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel({
    required this.id,
    required this.userId,
    required this.preferredLanguage,
    required this.learningLanguage,
    required this.learningLanguageLevel,
    required this.transcription,
    required this.translation,
    required this.suggestedResponsePreferred,
    required this.suggestedResponseLearning,
    required this.createdAt,
  }) : super(
          id: id,
          userId: userId,
          preferredLanguage: preferredLanguage,
          learningLanguage: learningLanguage,
          learningLanguageLevel: learningLanguageLevel,
          transcription: transcription,
          translation: translation,
          suggestedResponsePreferred: suggestedResponsePreferred,
          suggestedResponseLearning: suggestedResponseLearning,
          createdAt: createdAt,
        );

  factory GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel.fromMap(Map<String, dynamic> map) {
    return GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel(
      id: map['id'],
      userId: map['user_id'],
      preferredLanguage: map['preferred_language'],
      learningLanguage: map['learning_language'],
      learningLanguageLevel: map['learning_language_level'],
      transcription: map['transcription'],
      translation: map['translation'],
      suggestedResponsePreferred: map['suggested_response_preferred'],
      suggestedResponseLearning: map['suggested_response_learning'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'preferred_language': preferredLanguage,
        'learning_language': learningLanguage,
        'learning_language_level': learningLanguageLevel,
        'transcription': transcription,
        'translation': translation,
        'suggested_response_preferred': suggestedResponsePreferred,
        'suggested_response_learning': suggestedResponseLearning,
        'created_at': createdAt,
      };

  factory GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel.fromJson(String str) =>
      GetfacetofaceconversationsSpeakingpracticehubDataConversationsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
}
