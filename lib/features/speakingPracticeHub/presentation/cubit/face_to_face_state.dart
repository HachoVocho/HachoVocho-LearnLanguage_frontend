import 'package:equatable/equatable.dart';

class FaceToFaceState extends Equatable {
  final String? preferredLanguage;
  final String? learningLanguage;
  final String? level;
  final String? topic;

  const FaceToFaceState({
    this.preferredLanguage,
    this.learningLanguage,
    this.level,
    this.topic,
  });

  FaceToFaceState copyWith({
    String? preferredLanguage,
    String? learningLanguage,
    String? level,
    String? topic,
  }) {
    return FaceToFaceState(
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      learningLanguage: learningLanguage ?? this.learningLanguage,
      level: level ?? this.level,
      topic: topic ?? this.topic,
    );
  }

  @override
  List<Object?> get props => [
        preferredLanguage,
        learningLanguage,
        level,
        topic,
      ];
}
