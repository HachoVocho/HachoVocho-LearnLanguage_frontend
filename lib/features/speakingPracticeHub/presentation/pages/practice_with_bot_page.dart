// practice_with_bot_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/hachovocho_learn_language_routes_name.dart';
import '../cubit/bot_conversation_cubit.dart';
import '../cubit/bot_conversation_state.dart';

class PracticeWithBotPage extends StatelessWidget {
  final BotConversationCubit cubit; // Accept the cubit instance

  const PracticeWithBotPage({required this.cubit, super.key});

  final List<String> topics = const ['Greetings', 'Food', 'Travel', 'Work'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit, // Provide the passed cubit instance
      child: BlocListener<BotConversationCubit, BotConversationState>(
        listener: (context, state) {
          // Optional: Handle state changes if needed
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Practice with Bot'),
            backgroundColor: Colors.deepPurple,
          ),
          body: BlocBuilder<BotConversationCubit, BotConversationState>(
            builder: (context, state) {
              // Trigger WebSocket connection once when the widget builds
              if (!state.websocketConnected && !state.isLoading) {
                cubit.connectWebSocket();
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Select Topic',
                      ),
                      value: state.selectedTopic,
                      items: topics
                          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                          .toList(),
                      onChanged: (topic) {
                        cubit.setTopic(topic!);
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (state.selectedTopic != null) {
                          cubit.startConversation();
                          debugPrint('cubit');
                          debugPrint(cubit.toString());
                          Navigator.of(context).pushNamed(
                            HachoVochoLearnLanguageRoutesName.botConversationChat,
                            arguments: cubit, // Pass the cubit instance
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a topic')),
                          );
                        }
                      },
                      child: const Text('Start Conversation'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
