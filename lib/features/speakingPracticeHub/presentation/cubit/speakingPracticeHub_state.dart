
import 'package:equatable/equatable.dart';

import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
                       
abstract class SpeakingpracticehubState extends Equatable {
    @override
    List<Object?> get props => [];
}

class SpeakingpracticehubLoading extends SpeakingpracticehubState {}

class InitialSpeakingpracticehubState extends SpeakingpracticehubState {}

// Add other states as needed


class GetfacetofaceconversationsSpeakingpracticehubSuccess extends SpeakingpracticehubState {
  final GetfacetofaceconversationsSpeakingpracticehubResponseEntity success;

  GetfacetofaceconversationsSpeakingpracticehubSuccess(this.success);

  @override
  List<Object?> get props => [success];
}

class GetfacetofaceconversationsSpeakingpracticehubError extends SpeakingpracticehubState {
  final String message;

  GetfacetofaceconversationsSpeakingpracticehubError(this.message);

  @override
  List<Object?> get props => [message];
}
