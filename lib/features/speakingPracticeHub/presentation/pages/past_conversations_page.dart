import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/globally_used_widgets.dart';
import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_response_entity.dart';
import '../cubit/face_to_face_conversation_cubit.dart';
import '../cubit/speakingPracticeHub_cubit.dart';
import '../cubit/speakingPracticeHub_state.dart';

class PastConversationsPage extends StatelessWidget {
  final String userId;
  const PastConversationsPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Past Conversations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<SpeakingpracticehubCubit, SpeakingpracticehubState>(
        builder: (context, state) {
          if (state is SpeakingpracticehubLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetfacetofaceconversationsSpeakingpracticehubError) {
            return Center(child: Text(state.message));
          } else if (state is GetfacetofaceconversationsSpeakingpracticehubSuccess) {
            List<GetfacetofaceconversationsSpeakingpracticehubDataEntity>? conversations = state.success.data;
            if (conversations!.isEmpty) {
              return const Center(child: Text("No conversations found."));
            }
            final cubit = context.read<FaceToFaceConversationCubit>();
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversation = conversations[index].conversations;
                // Common card decoration with shadow
                final cardDecoration = BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                );
                final String dateString = conversations[index].date; // Example: "11 January 2025"
                return Column(
                  children: [
                    // Centered Date Header
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          dateString,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: conversation.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, subIndex) {
                        final eachConversation = conversation[subIndex];
                        return Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: cardDecoration,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      buildTextWithIcon(
                                        icon: Icons.volume_up,
                                        label: "Transcription:",
                                        text: eachConversation.transcription,
                                        languageCode: eachConversation.learningLanguage.split(',')[1],
                                        textColor: Colors.red,
                                        onTapWord: (word) => cubit.speak(word, eachConversation.learningLanguage.split(',')[1]),
                                      ),
                                      const SizedBox(height: 12),
                                      buildTextWithIcon(
                                        icon: Icons.volume_up,
                                        label: "",
                                        text: eachConversation.translation,
                                        languageCode: eachConversation.preferredLanguage.split(',')[1],
                                        textColor: Colors.green,
                                        onTapWord: (word) => cubit.speak(word, eachConversation.preferredLanguage.split(',')[1]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Suggested Response Card
                            Align(
                              alignment: Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 300,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  padding: const EdgeInsets.all(16),
                                  decoration: cardDecoration,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      buildTextWithIcon(
                                        icon: Icons.volume_up,
                                        label: "Suggested Response :",
                                        text: eachConversation.suggestedResponseLearning,
                                        languageCode: eachConversation.learningLanguage.split(',')[1],
                                        textColor: Colors.red,
                                        onTapWord: (word) => cubit.speak(word, eachConversation.learningLanguage.split(',')[1]),
                                      ),
                                      const SizedBox(height: 4),
                                      buildTextWithIcon(
                                        icon: Icons.volume_up,
                                        label: "",
                                        text: eachConversation.suggestedResponsePreferred,
                                        languageCode: eachConversation.preferredLanguage.split(',')[1],
                                        textColor: Colors.green,
                                        onTapWord: (word) => cubit.speak(word, eachConversation.preferredLanguage.split(',')[1]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // Divider Line After Outer List Item
                    if (index < conversations.length - 1) // Don't add after the last item
                      const Divider(
                        thickness: 2,
                        color: Colors.black26,
                        indent: 10,
                        endIndent: 10,
                      ),
                  ],
                );
              },
            );

          }
          return Container();
        },
      ),
    );
  }
}
