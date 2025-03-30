import 'package:equatable/equatable.dart';

class GetsentencesbytopicListeningpracticehubParamsEntity extends Equatable {
    final String userId;
    final String topicId;

    const GetsentencesbytopicListeningpracticehubParamsEntity({required this.userId, required this.topicId});

    @override
    List<Object?> get props => [userId, topicId];
}