import 'dart:convert';

import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';

class GetusertopicsprogressListeningpracticehubResponseModel
    extends GetusertopicsprogressListeningpracticehubResponseEntity {
  @override
  final List<GetusertopicsprogressListeningpracticehubTopicModel> data;

  const GetusertopicsprogressListeningpracticehubResponseModel({
    required super.success,
    required this.data,
    required super.message,
  }) : super(
          data: data,
        );

  factory GetusertopicsprogressListeningpracticehubResponseModel.fromMap(Map<String, dynamic> map) {
    return GetusertopicsprogressListeningpracticehubResponseModel(
      success: map['success'] ?? false,
      data: List<GetusertopicsprogressListeningpracticehubTopicModel>.from(
          (map['data'] ?? []).map((item) => GetusertopicsprogressListeningpracticehubTopicModel.fromMap(item))),
      message: map['message'] ?? '',
    );
  }

  factory GetusertopicsprogressListeningpracticehubResponseModel.fromJson(String str) =>
      GetusertopicsprogressListeningpracticehubResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data.map((item) => item.toMap()).toList(),
        'message': message,
      };
}

class GetusertopicsprogressListeningpracticehubTopicModel
    extends GetusertopicsprogressListeningpracticehubTopicEntity {
  @override
  final String topicName;
  @override
  final String topicId;
  @override
  final String description;
  @override
  final GetusertopicsprogressListeningpracticehubModuleModel module;
  @override
  final List<GetusertopicsprogressListeningpracticehubLevelModel> levelsProgress;

  const GetusertopicsprogressListeningpracticehubTopicModel({
    required this.topicName,
    required this.topicId,
    required this.description,
    required this.module,
    required this.levelsProgress,
  }) : super(
          topicName: topicName,
          topicId: topicId,
          description: description,
          module: module,
          levelsProgress: levelsProgress,
        );

  factory GetusertopicsprogressListeningpracticehubTopicModel.fromMap(Map<String, dynamic> map) {
    return GetusertopicsprogressListeningpracticehubTopicModel(
      topicName: map['topic_name'] ?? '',
      topicId: map['topic_id'] ?? '',
      description: map['description'] ?? '',
      module: GetusertopicsprogressListeningpracticehubModuleModel.fromMap(map['module']),
      levelsProgress: List<GetusertopicsprogressListeningpracticehubLevelModel>.from(
          (map['levels_progress'] ?? [])
              .map((item) => GetusertopicsprogressListeningpracticehubLevelModel.fromMap(item))),
    );
  }

  Map<String, dynamic> toMap() => {
        'topic_name': topicName,
        'topic_id': topicId,
        'description': description,
        'module': module.toMap(),
        'levels_progress': levelsProgress.map((item) => item.toMap()).toList(),
      };
}

class GetusertopicsprogressListeningpracticehubModuleModel
    extends GetusertopicsprogressListeningpracticehubModuleEntity {
  const GetusertopicsprogressListeningpracticehubModuleModel({
    required super.id,
    required super.name,
  });

  factory GetusertopicsprogressListeningpracticehubModuleModel.fromMap(Map<String, dynamic> map) {
    return GetusertopicsprogressListeningpracticehubModuleModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };
}

class GetusertopicsprogressListeningpracticehubLevelModel
    extends GetusertopicsprogressListeningpracticehubLevelEntity {
  const GetusertopicsprogressListeningpracticehubLevelModel({
    required super.levelName,
    required super.progressPercentage,
    required super.completedSentences,
    required super.totalSentences,
    required super.didListenStory,
  });

  factory GetusertopicsprogressListeningpracticehubLevelModel.fromMap(Map<String, dynamic> map) {
    return GetusertopicsprogressListeningpracticehubLevelModel(
      levelName: map['level_name'] ?? '',
      progressPercentage: (map['progress_percentage'] ?? 0.0).toDouble(),
      completedSentences: map['completed_sentences'] ?? 0,
      totalSentences: map['total_sentences'] ?? 0,
      didListenStory: map['did_listen_story'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
        'level_name': levelName,
        'progress_percentage': progressPercentage,
        'completed_sentences': completedSentences,
        'total_sentences': totalSentences,
        'did_listen_story': didListenStory,
      };
}
