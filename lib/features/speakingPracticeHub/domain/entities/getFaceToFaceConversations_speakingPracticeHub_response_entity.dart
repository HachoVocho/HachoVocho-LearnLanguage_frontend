import 'package:equatable/equatable.dart';

    class GetfacetofaceconversationsSpeakingpracticehubResponseEntity extends Equatable {
    final bool success;
      final List<GetfacetofaceconversationsSpeakingpracticehubDataEntity>? data;
  final String message;

    const GetfacetofaceconversationsSpeakingpracticehubResponseEntity({
        required this.success,
        this.data,
    required this.message,
    });

    @override
    List<Object?> get props => [success, data, message];
    }

    
class GetfacetofaceconversationsSpeakingpracticehubDataEntity extends Equatable {
final String date;
  final List<GetfacetofaceconversationsSpeakingpracticehubDataConversationsEntity> conversations;

const GetfacetofaceconversationsSpeakingpracticehubDataEntity({required this.date, required this.conversations});

@override
List<Object?> get props => [date, conversations];
}

class GetfacetofaceconversationsSpeakingpracticehubDataConversationsEntity extends Equatable {
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

const GetfacetofaceconversationsSpeakingpracticehubDataConversationsEntity({required this.id, required this.userId, required this.preferredLanguage, required this.learningLanguage, required this.learningLanguageLevel, required this.transcription, required this.translation, required this.suggestedResponsePreferred, required this.suggestedResponseLearning, required this.createdAt});

@override
List<Object?> get props => [id, userId, preferredLanguage, learningLanguage, learningLanguageLevel, transcription, translation, suggestedResponsePreferred, suggestedResponseLearning, createdAt];
}