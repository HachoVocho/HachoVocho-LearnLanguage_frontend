import 'package:equatable/equatable.dart';

class MarksentencelistenedListeningpracticehubParamsEntity extends Equatable {
    final String userId;
    final String sentenceId;

    const MarksentencelistenedListeningpracticehubParamsEntity({required this.userId, required this.sentenceId});

    @override
    List<Object?> get props => [userId, sentenceId];
}