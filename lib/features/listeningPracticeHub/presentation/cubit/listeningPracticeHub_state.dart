import 'package:equatable/equatable.dart';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';
                       
abstract class ListeningpracticehubState extends Equatable {
    @override
    List<Object?> get props => [];
}

class ListeningpracticehubLoading extends ListeningpracticehubState {}

class InitialListeningpracticehubState extends ListeningpracticehubState {}

// Add other states as needed

class UsertopicsprogressListeningpracticehubError extends ListeningpracticehubState {
  final String message;

  UsertopicsprogressListeningpracticehubError(this.message);

  @override
  List<Object?> get props => [message];
}


class GetusertopicsprogressListeningpracticehubSuccess extends ListeningpracticehubState {
  final GetusertopicsprogressListeningpracticehubResponseEntity success;

  GetusertopicsprogressListeningpracticehubSuccess(this.success);

  @override
  List<Object?> get props => [success];
}

class GetusertopicsprogressListeningpracticehubError extends ListeningpracticehubState {
  final String message;

  GetusertopicsprogressListeningpracticehubError(this.message);

  @override
  List<Object?> get props => [message];
}


class GetsentencesbytopicListeningpracticehubSuccess extends ListeningpracticehubState {
  final GetsentencesbytopicListeningpracticehubResponseEntity responseData;
  final String? sentenceId;
  final DateTime? emittedAt;
  GetsentencesbytopicListeningpracticehubSuccess(this.responseData,{this.sentenceId,this.emittedAt});

  @override
  List<Object?> get props => [responseData,sentenceId,emittedAt];
}

class GetsentencesbytopicListeningpracticehubError extends ListeningpracticehubState {
  final String message;

  GetsentencesbytopicListeningpracticehubError(this.message);

  @override
  List<Object?> get props => [message];
}


class MarksentencelistenedListeningpracticehubSuccess extends ListeningpracticehubState {
  final String message;

  MarksentencelistenedListeningpracticehubSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class MarksentencelistenedListeningpracticehubError extends ListeningpracticehubState {
  final String message;

  MarksentencelistenedListeningpracticehubError(this.message);

  @override
  List<Object?> get props => [message];
}
