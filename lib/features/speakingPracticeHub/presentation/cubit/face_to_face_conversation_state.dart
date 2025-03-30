import 'package:equatable/equatable.dart';

class FaceToFaceConversationState extends Equatable {
  final bool isRecording;
  final bool isLoading;
  final List<Map<String, dynamic>> chatMessages;

  const FaceToFaceConversationState({
    this.isRecording = false,
    this.isLoading = false,
    this.chatMessages = const [],
  });

  // CopyWith method to update fields when emitting new states
  FaceToFaceConversationState copyWith({
    bool? isRecording,
    bool? isLoading,
    List<Map<String, dynamic>>? chatMessages,
  }) {
    return FaceToFaceConversationState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      chatMessages: chatMessages ?? this.chatMessages,
    );
  }

  @override
  List<Object> get props => [isRecording, isLoading, chatMessages];
}
