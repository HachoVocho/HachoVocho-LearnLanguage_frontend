import 'package:equatable/equatable.dart';

    class GetsentencesbytopicListeningpracticehubResponseEntity extends Equatable {
    final bool success;
      final List<GetsentencesbytopicListeningpracticehubDataEntity>? data;
  final String message;

    const GetsentencesbytopicListeningpracticehubResponseEntity({
        required this.success,
        this.data,
    required this.message,
    });

    @override
    List<Object?> get props => [success, data, message];
    }

    
// ignore: must_be_immutable
class GetsentencesbytopicListeningpracticehubDataEntity extends Equatable {
final int id;
  final String sentence;
  final GetsentencesbytopicListeningpracticehubDataBaseLanguageEntity baseLanguage;
  final GetsentencesbytopicListeningpracticehubDataLearningLanguageEntity learningLanguage;
  late bool isListened;

 GetsentencesbytopicListeningpracticehubDataEntity({required this.id, required this.sentence, required this.baseLanguage, required this.learningLanguage, required this.isListened});

@override
List<Object?> get props => [id, sentence, baseLanguage, learningLanguage, isListened];
}

class GetsentencesbytopicListeningpracticehubDataBaseLanguageEntity extends Equatable {
final String name;
  final String translationCode;

const GetsentencesbytopicListeningpracticehubDataBaseLanguageEntity({required this.name, required this.translationCode});

@override
List<Object?> get props => [name, translationCode];
}

class GetsentencesbytopicListeningpracticehubDataLearningLanguageEntity extends Equatable {
final String name;
  final String translationCode;

const GetsentencesbytopicListeningpracticehubDataLearningLanguageEntity({required this.name, required this.translationCode});

@override
List<Object?> get props => [name, translationCode];
}