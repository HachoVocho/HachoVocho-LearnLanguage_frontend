// bot_conversation_state.dart

import 'package:equatable/equatable.dart';

class BotConversationState extends Equatable {
  final List<Map<String, dynamic>> chatMessages;
  final bool isRecording;
  final bool websocketConnected;
  final bool isLoading;
  final String? selectedTopic; // Add selectedTopic here

  const BotConversationState({
    this.chatMessages = const [],
    this.isRecording = false,
    this.websocketConnected = false,
    this.isLoading = false,
    this.selectedTopic, // Initialize selectedTopic as nullable
  });

  BotConversationState copyWith({
    List<Map<String, dynamic>>? chatMessages,
    bool? isRecording,
    bool? websocketConnected,
    bool? isLoading,
    String? selectedTopic, // Add selectedTopic to copyWith
  }) {
    return BotConversationState(
      chatMessages: chatMessages ?? this.chatMessages,
      isRecording: isRecording ?? this.isRecording,
      websocketConnected: websocketConnected ?? this.websocketConnected,
      isLoading: isLoading ?? this.isLoading,
      selectedTopic: selectedTopic ?? this.selectedTopic, // Copy the selected topic
    );
  }

  @override
  List<Object?> get props =>
      [chatMessages, isRecording, websocketConnected, isLoading, selectedTopic];
}
