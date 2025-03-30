import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../cubit/listeningPracticeHub_cubit.dart';
import '../cubit/listeningPracticeHub_state.dart';

class ListeningPracticePage extends StatelessWidget {
  final String userId;
  const ListeningPracticePage({super.key,required this.userId});

  @override
  Widget build(BuildContext t) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listening Practice',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<ListeningpracticehubCubit, ListeningpracticehubState>(
        listener: (context, state) {
          if (state is GetsentencesbytopicListeningpracticehubError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ListeningpracticehubLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetsentencesbytopicListeningpracticehubSuccess) {
            return ListeningPracticeContent(
              responseData: state.responseData,
              userId: userId,
            );
          } else {
            return const Center(
              child: Text("No data available."),
            );
          }
        },
      ),
    );
  }
}

class ListeningPracticeContent extends StatelessWidget {
  final GetsentencesbytopicListeningpracticehubResponseEntity responseData;
  final String userId;

  ListeningPracticeContent({super.key, required this.responseData, required this.userId});

  final PageController pageController = PageController();
  final Map<int, bool> playedSentences = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: PageView.builder(
            controller: pageController,
            itemCount: responseData.data!.length,
            itemBuilder: (context, index) {
              final item = responseData.data![index];
              final sentences = _splitSentences(item.sentence);
              print('item');
              print(index);
              print(item.isListened);
              playedSentences[index] = false;
              return Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Topic ${item.id}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: sentences.map((sentence) {
                        final text = sentence['text'];
                        return Text(
                          text!,
                          style: TextStyle(
                            fontSize: 16,
                            color: sentence['language'] == 'English'
                                ? Colors.black
                                : Colors.deepPurple,
                            fontWeight: sentence['language'] == 'German'
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (pageController.page!.toInt() > 0) {
                    pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Previous'),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final currentIndex = pageController.page!.toInt();
                  final currentItem = responseData.data![currentIndex];
                  final sentences = _splitSentences(currentItem.sentence);

                  // Use StatefulBuilder for localized state changes
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      // Update state when needed within this block
                      return ElevatedButton.icon(
                        onPressed: () async {
                          // Recursively speak all sentences
                          await _speakAllSentencesRecursively(
                            context,
                            currentItem,
                            sentences,
                            0,
                            responseData,
                            setState,
                            currentIndex,
                          );
                          // After speaking, update UI or perform state changes
                        },
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        label: const Text(
                          'Play',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.play_arrow, color: Colors.white),
                label: const Text(
                  'Play',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final currentIndex = pageController.page!.toInt();
                  final currentItem = responseData.data![currentIndex];
                  print('currentItem.isListened');
                  print(currentItem.isListened);
                  print(currentIndex);
                  if (!currentItem.isListened) {
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please listen to this sentence completely before proceeding.'),
                      ),
                    );
                      return;
                  }

                  if (pageController.page!.toInt() < responseData.data!.length - 1) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Recursively speak all sentences in [sentences], starting at index [i].
  /// This avoids concurrency issues often encountered with loops.
  Future<void> _speakAllSentencesRecursively(
    BuildContext context,
    GetsentencesbytopicListeningpracticehubDataEntity currentItem,
    List<Map<String, String>> sentences,
    int i,
    GetsentencesbytopicListeningpracticehubResponseEntity responseData,
    StateSetter setState,
    int currentIndex
  ) async {
    // Base Case: if i >= sentences.length, we are done.
    if (i >= sentences.length) {
      print('we are done');
      setState(() {
        // Example: Update some local state
        playedSentences[currentIndex] = true;
      });
      if (!currentItem.isListened) {
        context.read<ListeningpracticehubCubit>().marksentencelistenedListeningpracticehub(
          MarksentencelistenedListeningpracticehubParamsEntity(
            sentenceId: currentItem.id.toString(),
            userId: userId,
          ),
          responseData,
          pageController.page!.toInt()
        );
      }
      return;
    }

    // Speak the current sentence
    final text = sentences[i]['text'];
    final language = sentences[i]['language'] == 'English'
        ? currentItem.baseLanguage.translationCode
        : currentItem.learningLanguage.translationCode;
    print('text');
    print(text);
    // Wait for TTS to finish
    await context.read<ListeningpracticehubCubit>().speak(text!, language);

    // Move on to the next sentence
    await _speakAllSentencesRecursively(context, currentItem, sentences, i + 1,responseData,setState,currentIndex);
  }

  /// Splits the `sentence` field and identifies the language for each part.
  List<Map<String, String>> _splitSentences(String sentence) {
    final parts = sentence.split(' | ');
    final List<Map<String, String>> result = [];

    for (var part in parts) {
      final segments = part.split(': ');
      if (segments.length == 2) {
        result.add({
          'text': segments[0].trim(),
          'language': segments[1].trim(),
        });
      }
    }

    return result;
  }
}
