import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';

import 'face_to_face_conversation_state.dart';

class FaceToFaceConversationCubit extends Cubit<FaceToFaceConversationState> {
  FaceToFaceConversationCubit() : super(FaceToFaceConversationState()) {
    _speech = stt.SpeechToText();
    _flutterTts = FlutterTts();
    _initializeTts();
    _initializeScrollController();
    initializeWebSocket();
  }

  // Platform channel for starting/stopping native recording
  static const MethodChannel _platform =
      MethodChannel('com.example.hachovocho_learn_language/audio');

  late stt.SpeechToText _speech;
  late FlutterTts _flutterTts;
  WebSocket? _socket;
  late ScrollController _scrollController;

  // Expose the scrollController for the UI
  ScrollController get scrollController => _scrollController;

  // --------------------------------------
  // Initialization
  // --------------------------------------
  void _initializeTts() async {
    await _flutterTts.setLanguage("de-DE");
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  void _initializeScrollController() {
    _scrollController = ScrollController();
  }

  Future<void> initializeWebSocket() async {
    try {
      _socket = await WebSocket.connect(
          "wss://51.20.255.49/ws/audio/",
          //"wss://b8ac-2001-9e8-73e-6b00-89d9-4ebd-2a75-c69.ngrok-free.app/ws/audio/"
          );
      _socket?.listen((data) {
        _handleWebSocketResponse(data);
      }, onDone: () {
        print("WebSocket closed");
      }, onError: (error) {
        print("WebSocket error: $error");
      });
    } catch (e) {
      print("Error connecting to WebSocket: $e");
    }
  }

  // --------------------------------------
  // TTS Methods
  // --------------------------------------
  Future<void> speak(String text, String languageCode) async {
    try {
      await _flutterTts.setLanguage(languageCode);
      await _flutterTts.setPitch(1.0);
      await _flutterTts.setSpeechRate(0.4);
      await _flutterTts.speak(text);
    } catch (e) {
      print("Error in TTS: $e");
      // Handle error (e.g., show a snackbar) in the UI if desired
    }
  }

  // --------------------------------------
  // WebSocket Response Handling
  // --------------------------------------
  void _handleWebSocketResponse(dynamic data) {
    final response = json.decode(data) as Map<String, dynamic>;

    // Remove "loading" message if present
    final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages);
    if (updatedMessages.isNotEmpty && updatedMessages.last["type"] == "loading") {
      updatedMessages.removeLast();
    }

    // Add the bot message
    updatedMessages.add({
      "type": "bot",
      "transcription": response["transcription"],
      "translation": response["translation"],
      "suggestedLearningLanguageResponse": response["suggestedLearningLanguageResponse"],
      "suggestedPreferredLanguageResponse": response["suggestedPreferredLanguageResponse"],
      'learning_language_code': response["learning_language_code"],
      'preferred_language_code':response["preferred_language_code"],
    });

    emit(state.copyWith(
      isLoading: false,
      chatMessages: updatedMessages,
    ));

    _scrollToBottom();
  }

  // --------------------------------------
  // Recording Methods
  // --------------------------------------
  Future<void> startRecording() async {
    try {
      final result = await _platform.invokeMethod('startRecording');
      if (result == "Recording started") {
        final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages);
        updatedMessages.add({"type": "user", "content": "Recording..."});
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

  Future<void> stopRecording(String preferredLanguage,String learningLanguage,String learningLanguageLevel,String userId) async {
    try {
      final Uint8List? audioData =
          await _platform.invokeMethod('stopRecording') as Uint8List?;
      if (audioData != null) {
        final updatedMessages = List<Map<String, dynamic>>.from(state.chatMessages);

        // Replace "Recording..." with "Audio Message Sent"
        if (updatedMessages.isNotEmpty &&
            updatedMessages.last["content"] == "Recording...") {
          updatedMessages.removeLast();
        }
        updatedMessages.add({"type": "user", "content": "Audio Message Sent"});
        updatedMessages.add({"type": "loading", "content": "Processing..."});

        emit(
          state.copyWith(
            isRecording: false,
            isLoading: true,
            chatMessages: updatedMessages,
          ),
        );
        _scrollToBottom();

        if (_socket != null && _socket!.readyState == WebSocket.open) {
          final metadata = jsonEncode({
            'preferredLanguage': preferredLanguage,
            'learningLanguage': learningLanguage,
            'learningLanguageLevel': learningLanguageLevel,
            'userId' : userId
          });
          print('metadata');
          print(metadata);
          // Combine metadata and audio data
          final metadataBytes = utf8.encode(metadata); // Convert metadata to bytes
          final separator = utf8.encode('|'); // Add a separator between metadata and audio
          final combinedData = Uint8List.fromList([
            ...metadataBytes,
            ...separator,
            ...audioData,
          ]);
          _socket!.add(combinedData);
        } else {
          print("WebSocket connection not established");
          // Remove loading message if the socket isn't open
          final newMessages = List<Map<String, dynamic>>.from(updatedMessages);
          if (newMessages.isNotEmpty && newMessages.last["type"] == "loading") {
            newMessages.removeLast();
          }
          emit(state.copyWith(isLoading: false, chatMessages: newMessages));
        }
      }
    } on PlatformException catch (e) {
      print("Failed to stop recording: '${e.message}'.");
    }
  }

  // --------------------------------------
  // Helper: Scroll to bottom
  // --------------------------------------
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
