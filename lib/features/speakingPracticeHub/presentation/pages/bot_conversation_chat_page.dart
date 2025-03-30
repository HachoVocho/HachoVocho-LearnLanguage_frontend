// bot_conversation_chat_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/bot_conversation_cubit.dart';
import '../cubit/bot_conversation_state.dart';

class BotConversationChatPage extends StatelessWidget {
  const BotConversationChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<BotConversationCubit, BotConversationState>(
      listener: (context, state) {
        // Handle any side effects if needed
      },
      child: BlocBuilder<BotConversationCubit, BotConversationState>(
        builder: (context, state) {
          final cubit = context.read<BotConversationCubit>(); // Access the cubit instance
          // Convert chatMessages -> widgets
          final messages = state.chatMessages.map((msg) {
            final type = msg["type"] as String;
            final content = msg["content"];

            switch (type) {
              case "loading":
                return _buildLoadingBubble();
              case "bot":
                // Bot message bubble (right side)
                if (content is Map<String, dynamic>) {
                  return _buildBotBubble(content, context);
                }
                return const SizedBox.shrink();
              case "orange":
                // Orange box on user side
                if (content is Map<String, dynamic>) {
                  return _buildOrangeBox(content, cubit);
                }
                return const SizedBox.shrink();
              case "user":
                // User message bubble (left side)
                final userText = content as String? ?? "";
                if (userText == "Audio Message Sent") {
                  return _buildUserAudioBubble(context);
                }
                return _buildUserBubble(userText);
              default:
                return const SizedBox.shrink();
            }
          }).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text("Bot Conversation",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.deepPurple,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    controller: cubit.scrollController,
                    children: messages,
                  ),
                ),
                // Optional: Input field and send button can be added here
              ],
            ),
          );
        },
      ),
    );
  }

  // ------------------------------------------------
  // 1) Loading Bubble (Bot is processing)
  // ------------------------------------------------
  Widget _buildLoadingBubble() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepPurple[200],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2)),
            SizedBox(width: 8),
            Text("Processing...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // 2) Bot Message Bubble (Right Side)
  // ------------------------------------------------
  Widget _buildBotBubble(Map<String, dynamic> content, BuildContext context) {
    final transcription = content["transcription"] ?? "";
    final translation = content["translation"] ?? "";
    final explanation = content["explanation"] ?? "";

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // German text with TTS button
            Row(
              children: [
                Expanded(
                  child: Text(
                    transcription,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.green),
                  onPressed: () {
                    // Trigger TTS for German transcription
                    context.read<BotConversationCubit>().speak(transcription, "de-DE");
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            // English text with TTS button
            Row(
              children: [
                Expanded(
                  child: Text(
                    translation,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.red),
                  onPressed: () {
                    // Trigger TTS for English translation
                    context.read<BotConversationCubit>().speak(translation, "en-US");
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Explanation Button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Trigger TTS for the explanation
                  context.read<BotConversationCubit>().speak(explanation, "en-US");
                },
                icon: const Icon(Icons.info, color: Colors.white),
                label: const Text(
                  "Explanation",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  // ------------------------------------------------
  // 3) Orange Box (Left Side) - Replay & Record
  // ------------------------------------------------
  Widget _buildOrangeBox(Map<String, dynamic> content, BotConversationCubit cubit) {
    final suggestedGerman = content["suggestedGerman"] ?? "";
    final suggestedEnglish = content["suggestedEnglish"] ?? "";
    final userAudio = content["userAudio"] ?? false; // True after user is done speaking

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Replay German suggestion
            Row(
              children: [
                Expanded(
                  child: Text(
                    suggestedGerman, // Suggested German text
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.green),
                  onPressed: () {
                    // Replay Bot's German transcription
                    cubit.speak(suggestedGerman, "de-DE");
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Replay English suggestion
            Row(
              children: [
                Expanded(
                  child: Text(
                    suggestedEnglish, // Suggested English text
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.red),
                  onPressed: () {
                    // Replay Bot's English translation
                    cubit.speak(suggestedEnglish, "en-US");
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Button to Start/Stop Recording
            ElevatedButton.icon(
              onPressed: () async {
                if (cubit.state.isRecording) {
                  await cubit.stopRecording();
                } else {
                  await cubit.startRecording();
                }
              },
              icon: Icon(
                cubit.state.isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
              ),
              label: Text(
                cubit.state.isRecording ? "Stop Speaking" : "Speak",
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: cubit.state.isRecording ? Colors.red : Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // If user is done speaking, show a mini 'audio bubble' inside the orange box
            if (userAudio == true)
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.only(top: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.audiotrack, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      "User's Audio",
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.blue),
                      onPressed: () {
                        // Playback user audio (Not implemented in this example)
                        //ScaffoldMessenger.of(context).showSnackBar(
                        //  const SnackBar(content: Text('Audio playback not implemented.')),
                        //);
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // 4) User Audio Bubble (Left Side, Old Flow)
  // ------------------------------------------------
  Widget _buildUserAudioBubble(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(maxWidth: 250),
        child: Row(
          children: [
            const Icon(Icons.audiotrack, color: Colors.blue),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                "Audio Message Sent",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.blue),
              onPressed: () {
                // Not implemented
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Audio playback not implemented.')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------
  // 5) User Bubble (Left Side) - Normal Text Messages
  // ------------------------------------------------
  Widget _buildUserBubble(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        constraints: const BoxConstraints(maxWidth: 300),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
    );
  }
}
