// bot_conversation_cubit.dart

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'bot_conversation_state.dart';

class BotConversationCubit extends Cubit<BotConversationState> {
  BotConversationCubit() : super(const BotConversationState()) {
    _initTts();
  }

  WebSocket? _socket;
  static const MethodChannel _platform =
      MethodChannel('com.example.hachovocho_learn_language/audio');

  final FlutterTts _flutterTts = FlutterTts();

  // Initialize TTS settings
  Future<void> _initTts() async {
    await _flutterTts.setLanguage("de-DE");
    await _flutterTts.setPitch(1.0);
  }

  // Scroll controller for the chat
  final scrollController = ScrollController();

  /// Connect to WebSocket
  Future<void> connectWebSocket() async {
    if (state.websocketConnected) return; // Avoid reconnecting
    try {
      _socket = await WebSocket.connect(
          "wss://51.20.255.49:443/ws/bot_conversation/",
          //"wss://b8ac-2001-9e8-73e-6b00-89d9-4ebd-2a75-c69.ngrok-free.app/ws/bot_conversation/"
          );
      emit(state.copyWith(websocketConnected: true));

      _socket?.listen(_handleWebSocketResponse, onDone: () {
        print("WebSocket closed");
        emit(state.copyWith(websocketConnected: false)); // Mark as disconnected
      }, onError: (error) {
        print("WebSocket error: $error");
        emit(state.copyWith(websocketConnected: false)); // Handle reconnection if needed
      });
    } catch (e) {
      print("Error connecting WebSocket: $e");
      emit(state.copyWith(websocketConnected: false));
    }
  }

  /// Reset Cubit to initial state
  void reset() {
    _socket?.close();
    emit(const BotConversationState());
  }

  /// Set conversation topic
  void setTopic(String topic) {
    emit(state.copyWith(selectedTopic: topic));
  }

  /// Start the conversation by sending the topic
  void startConversation() {
    if (state.selectedTopic == null) return;
    final msg = {
      "action": "start_conversation",
      "topic": state.selectedTopic,
    };
    _socket?.add(json.encode(msg));
    // Optionally, add a user message indicating conversation start
    addUserMessage("Starting conversation on '${state.selectedTopic}'");
  }

  /// Handle incoming WebSocket responses
  void _handleWebSocketResponse(dynamic data) {
    final response = json.decode(data) as Map<String, dynamic>;
    debugPrint('Received response: $response');
    final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages);

    // If there's a "loading" at the end, remove it
    if (updatedMessages.isNotEmpty && updatedMessages.last["type"] == "loading") {
      updatedMessages.removeLast();
    }

    if (response.containsKey("error")) {
      // Show an error message from the server
      updatedMessages.add({
        "type": "bot",
        "content": {
          "transcription": "Error from server: ${response["error"]}",
          "translation": "",
          "suggestedResponseGerman": "",
          "suggestedResponseEnglish": "",
          "explanation":"explanation"
        },
      });
      emit(state.copyWith(isLoading: false, chatMessages: updatedMessages));
    } else {
      // Add bot message
      updatedMessages.add({
        "type": "bot",
        "content": response,
      });
      emit(state.copyWith(isLoading: false, chatMessages: updatedMessages));

      // Trigger TTS and add orange box for every bot message
      if (response.containsKey("transcription") && response.containsKey("translation")) {
        _handleBotMessage(response);
      }
    }
    _scrollToBottom();
  }

  /// Handle bot message: Trigger TTS and add orange box
  Future<void> _handleBotMessage(Map<String, dynamic> message) async {
    final transcription = message["transcription"] ?? "";
    final suggestedGerman = message["suggestedResponseGerman"] ?? "";
    final suggestedEnglish = message["suggestedResponseEnglish"] ?? "";

    // Trigger TTS for German
    await speak(transcription, "de-DE");
    // After TTS, add the orange box for user interaction
    addOrangeMessage(
      germanToReplay: transcription,
      suggestedGerman: suggestedGerman,
      suggestedEnglish: suggestedEnglish,
    );
  }

  /// Add user text message
  void addUserMessage(String text) {
    final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages)
      ..add({"type": "user", "content": text});
    emit(state.copyWith(chatMessages: updatedMessages));
    _scrollToBottom();
  }

  /// Send user text message
  void sendUserText(String text) {
    if (_socket == null) return;
    addUserMessage(text);
    final payload = {
      "action": "text_message",
      "text": text,
      "topic": state.selectedTopic,
    };
    _socket?.add(json.encode(payload));
  }

  /// Start recording audio
  Future<void> startRecording() async {
    try {
      final result = await _platform.invokeMethod('startRecording');
      if (result == "Recording started") {
        final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages)
          ..add({"type": "user", "content": "Recording..."});
        emit(
          state.copyWith(
            isRecording: true,
            chatMessages: updatedMessages,
          ),
        );
        _scrollToBottom();
      }
    } on PlatformException catch (e) {
      print("Failed to start recording: '${e.message}'.");
    }
  }

  /// Stop recording audio and send it
  Future<void> stopRecording() async {
    try {
      final Uint8List? audioData =
          await _platform.invokeMethod('stopRecording') as Uint8List?;
      if (audioData != null) {
        final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages);
        // Remove "Recording..." message
        if (updatedMessages.isNotEmpty &&
            updatedMessages.last["content"] == "Recording...") {
          updatedMessages.removeLast();
        }
        // Add "Audio Message Sent" with a loading indicator
        updatedMessages.add({"type": "user", "content": "Audio Message Sent"});
        updatedMessages.add({"type": "loading", "content": "Processing..."});

        emit(state.copyWith(isRecording: false, isLoading: true, chatMessages: updatedMessages));

        // Send audio data
        if (_socket != null && _socket!.readyState == WebSocket.open) {
          _socket!.add(audioData);
        } else {
          print("WebSocket not open for BotConversation");
          // Remove loading
          updatedMessages.removeLast();
          emit(state.copyWith(isLoading: false, chatMessages: updatedMessages));
        }
        _scrollToBottom();
      }
    } on PlatformException catch (e) {
      print("Failed to stop recording: '${e.message}'.");
    }
  }

  /// Speak text using TTS
  Future<void> speak(String text, String languageCode) async {
    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.3);
    await _flutterTts.speak(text);
  }

  /// Scroll to the bottom of the chat
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Close the WebSocket and dispose the controller
  @override
  Future<void> close() {
    _socket?.close();
    scrollController.dispose();
    _flutterTts.stop();
    return super.close();
  }

  /// Add the orange box message after the bot finishes speaking
  void addOrangeMessage({
    required String germanToReplay,
    required String suggestedGerman,
    required String suggestedEnglish,
  }) {
    final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages)
      ..add({
        "type": "orange",
        "content": {
          "germanToReplay": germanToReplay,
          "suggestedGerman": suggestedGerman,
          "suggestedEnglish": suggestedEnglish,
          "userAudio": false, // Initially, no user audio is recorded
        },
      });

    emit(state.copyWith(chatMessages: updatedMessages));
  }
}
