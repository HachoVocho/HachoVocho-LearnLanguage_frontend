import 'package:equatable/equatable.dart';

class GetusertopicsprogressListeningpracticehubResponseEntity extends Equatable {
  final bool success;
  final List<GetusertopicsprogressListeningpracticehubTopicEntity>? data;
  final String message;

  const GetusertopicsprogressListeningpracticehubResponseEntity({
    required this.success,
    this.data,
    required this.message,
  });

  @override
  List<Object?> get props => [success, data, message];
}

class GetusertopicsprogressListeningpracticehubTopicEntity extends Equatable {
  final String topicName;
  final String topicId;
  final String description;
  final GetusertopicsprogressListeningpracticehubModuleEntity module;
  final List<GetusertopicsprogressListeningpracticehubLevelEntity> levelsProgress;

  const GetusertopicsprogressListeningpracticehubTopicEntity({
    required this.topicName,
    required this.topicId,
    required this.description,
    required this.module,
    required this.levelsProgress,
  });

  @override
  List<Object?> get props => [topicName,topicId, description, module, levelsProgress];
}

class GetusertopicsprogressListeningpracticehubModuleEntity extends Equatable {
  final int id;
  final String name;

  const GetusertopicsprogressListeningpracticehubModuleEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}

class GetusertopicsprogressListeningpracticehubLevelEntity extends Equatable {
  final String levelName;
  final double progressPercentage;
  final int completedSentences;
  final int totalSentences;
  final bool didListenStory;

  const GetusertopicsprogressListeningpracticehubLevelEntity({
    required this.levelName,
    required this.progressPercentage,
    required this.completedSentences,
    required this.totalSentences,
    required this.didListenStory,
  });

  @override
  List<Object?> get props =>
      [levelName, progressPercentage, completedSentences, totalSentences, didListenStory];
}
