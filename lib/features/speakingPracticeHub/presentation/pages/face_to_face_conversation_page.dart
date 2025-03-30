import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/globally_used_widgets.dart';
import '../cubit/face_to_face_conversation_cubit.dart';
import '../cubit/face_to_face_conversation_state.dart';

class FaceToFaceConversationPage extends StatelessWidget {
    final String? preferredLanguage;
  final String? learningLanguage;
  final String? learningLanguageLevel;
  final String? userId;
  const FaceToFaceConversationPage({super.key,this.preferredLanguage,this.learningLanguage,this.learningLanguageLevel,this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaceToFaceConversationCubit(),
      child: BlocBuilder<FaceToFaceConversationCubit, FaceToFaceConversationState>(
        builder: (context, state) {
          // Access the cubit with flutter_bloc methods
          final cubit = context.read<FaceToFaceConversationCubit>();

          // Build chat messages
          final List<Widget> messageWidgets = [];
          for (var message in state.chatMessages) {
            if (message["type"] == "user") {
              messageWidgets.add(_buildUserMessage(message["content"]));
            } else if (message["type"] == "bot") {
              messageWidgets.add(buildBotMessage(cubit, message));
            } else if (message["type"] == "loading") {
              messageWidgets.add(_buildLoadingMessage());
            }
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Face-to-Face Conversation',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.deepPurple,
              centerTitle: true,
            ),
            body: Column(
              children: [
                // Chat Messages
                Expanded(
                  child: ListView(
                    controller: cubit.scrollController,
                    children: messageWidgets,
                  ),
                ),

                // Recording Section with Enhanced UI
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (state.isRecording) {
                        cubit.stopRecording(preferredLanguage!,learningLanguage!,learningLanguageLevel!,userId!);
                      } else {
                        cubit.startRecording();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: state.isRecording ? Colors.red[300] : Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                state.isRecording ? Icons.stop : Icons.mic,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                state.isRecording ? 'Stop Speaking' : 'Start Speaking',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (!state.isRecording)
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Tell your friend to speak on tap",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (state.isRecording)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  width: 5,
                                  height: (10 + (index % 2 == 0 ? 10 : 5)).toDouble(),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --------------------------------------
  // UI Helper Widgets
  // --------------------------------------
  Widget _buildUserMessage(String content) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.graphic_eq, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  content,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.chat_bubble_outline,
                  color: Colors.deepPurple, size: 20),
              const SizedBox(width: 8),
              const Text(
                "Processing...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBotMessage(
    FaceToFaceConversationCubit cubit,
    Map<String, dynamic> content,
  ) {
    print('content');
    print(content);
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Transcription
              buildTextWithIcon(
                icon: Icons.volume_up,
                label: "Transcription:",
                text: content["transcription"] ?? "",
                languageCode: content['learning_language_code'],
                textColor: Colors.red,
                onTapWord: (word) => cubit.speak(word, content['learning_language_code']),
              ),
              const SizedBox(height: 12),
              // Translation
              buildTextWithIcon(
                icon: Icons.volume_up,
                label: "Translation:",
                text: content["translation"] ?? "",
                languageCode: content['preferred_language_code'],
                textColor: Colors.green,
                onTapWord: (word) => cubit.speak(word, content['preferred_language_code']),
              ),
              const SizedBox(height: 12),
              // Suggested Response - German
              buildTextWithIcon(
                icon: Icons.volume_up,
                label: "Suggested Response ($learningLanguage):",
                text: content["suggestedLearningLanguageResponse"] ?? "",
                languageCode: content["learning_language_code"],
                textColor: Colors.red,
                onTapWord: (word) => cubit.speak(word, content["learning_language_code"]),
              ),
              const SizedBox(height: 4),
              // Suggested Response - English
              buildTextWithIcon(
                icon: Icons.volume_up,
                label: "Suggested Response $preferredLanguage:",
                text: content["suggestedPreferredLanguageResponse"] ?? "",
                languageCode: content['preferred_language_code'],
                textColor: Colors.green,
                onTapWord: (word) => cubit.speak(word, content['preferred_language_code']),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
