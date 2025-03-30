
import 'dart:convert';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';

class GetsentencesbytopicListeningpracticehubResponseModel extends GetsentencesbytopicListeningpracticehubResponseEntity {
  
        @override
  final List<GetsentencesbytopicListeningpracticehubDataModel> data;
        
        const GetsentencesbytopicListeningpracticehubResponseModel({
            required super.success,
            required this.data,
            required super.message,
        }) : super(
                data: data,
            );
        
        factory GetsentencesbytopicListeningpracticehubResponseModel.fromMap(Map<String, dynamic> map) {
            return GetsentencesbytopicListeningpracticehubResponseModel(
            success: map['success'] ?? false,
            data: List<GetsentencesbytopicListeningpracticehubDataModel>.from(
                (map['data'] ?? []).map((item) => GetsentencesbytopicListeningpracticehubDataModel.fromMap(item))
            ),
            message: map['message'] ?? '',
            );
        }
        

  factory GetsentencesbytopicListeningpracticehubResponseModel.fromJson(String str) =>
      GetsentencesbytopicListeningpracticehubResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    'data': data.map((item) => item.toMap()).toList(),
    'message': message,
  };
}


class GetsentencesbytopicListeningpracticehubDataModel extends GetsentencesbytopicListeningpracticehubDataEntity{
@override
  final int id;
  @override
  final String sentence;
  @override
  final GetsentencesbytopicListeningpracticehubDataBaseLanguageModel baseLanguage;
  @override
  final GetsentencesbytopicListeningpracticehubDataLearningLanguageModel learningLanguage;
  @override
  final bool isListened;

GetsentencesbytopicListeningpracticehubDataModel({required this.id, required this.sentence, required this.baseLanguage, required this.learningLanguage, required this.isListened}): super(
    id: id, sentence: sentence, baseLanguage: baseLanguage, learningLanguage: learningLanguage, isListened: isListened
);

factory GetsentencesbytopicListeningpracticehubDataModel.fromMap(Map<String, dynamic> map) {
    return GetsentencesbytopicListeningpracticehubDataModel(
    id: map['id'],
      sentence: map['sentence'],
      baseLanguage: GetsentencesbytopicListeningpracticehubDataBaseLanguageModel.fromMap(map['base_language'] ?? {}),
      learningLanguage: GetsentencesbytopicListeningpracticehubDataLearningLanguageModel.fromMap(map['learning_language'] ?? {}),
      isListened: map['is_listened']
    );
}

factory GetsentencesbytopicListeningpracticehubDataModel.fromJson(String str) => GetsentencesbytopicListeningpracticehubDataModel.fromMap(json.decode(str));

String toJson() => json.encode(toMap());

Map<String, dynamic> toMap() => {
    'id': id,
    'sentence': sentence,
    'base_language': baseLanguage.toMap(),
    'learning_language': learningLanguage.toMap(),
    'is_listened': isListened
};
}

class GetsentencesbytopicListeningpracticehubDataBaseLanguageModel extends GetsentencesbytopicListeningpracticehubDataBaseLanguageEntity{
const GetsentencesbytopicListeningpracticehubDataBaseLanguageModel({required this.name, required this.translationCode}) : super(
    name: name, translationCode: translationCode
);
@override
  final String name;
  @override
  final String translationCode;
    
factory GetsentencesbytopicListeningpracticehubDataBaseLanguageModel.fromMap(Map<String, dynamic> map) {
    return GetsentencesbytopicListeningpracticehubDataBaseLanguageModel(
    name: map['name'],
      translationCode: map['translation_code']
    );
}

factory GetsentencesbytopicListeningpracticehubDataBaseLanguageModel.fromJson(String str) => GetsentencesbytopicListeningpracticehubDataBaseLanguageModel.fromMap(json.decode(str));

String toJson() => json.encode(toMap());

Map<String, dynamic> toMap() => {
    'name': name,
    'translation_code': translationCode
};
}

class GetsentencesbytopicListeningpracticehubDataLearningLanguageModel extends GetsentencesbytopicListeningpracticehubDataLearningLanguageEntity{
const GetsentencesbytopicListeningpracticehubDataLearningLanguageModel({required this.name, required this.translationCode}) : super(
    name: name, translationCode: translationCode
);
@override
  final String name;
  @override
  final String translationCode;
    
factory GetsentencesbytopicListeningpracticehubDataLearningLanguageModel.fromMap(Map<String, dynamic> map) {
    return GetsentencesbytopicListeningpracticehubDataLearningLanguageModel(
    name: map['name'],
      translationCode: map['translation_code']
    );
}

factory GetsentencesbytopicListeningpracticehubDataLearningLanguageModel.fromJson(String str) => GetsentencesbytopicListeningpracticehubDataLearningLanguageModel.fromMap(json.decode(str));

String toJson() => json.encode(toMap());

Map<String, dynamic> toMap() => {
    'name': name,
    'translation_code': translationCode
};
}

