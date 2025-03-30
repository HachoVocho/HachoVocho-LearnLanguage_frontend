// listening_practice_state.dart

import 'package:equatable/equatable.dart';

// Define a Paragraph class
class Paragraph {
  final String title; // Optional: e.g., 'Greetings'
  final List<Sentence> sentences;

  Paragraph({
    required this.title,
    required this.sentences,
  });
}

class Sentence {
  final String text;
  final String language; // 'de-DE' for German, 'en-US' for English

  Sentence({
    required this.text,
    required this.language,
  });
}
class ListeningPracticeState extends Equatable {
  final bool isPracticeStarted;
  final int currentParagraphIndex;
  final int timerSeconds;
  final List<Paragraph> paragraphs;

  const ListeningPracticeState({
    this.isPracticeStarted = false,
    this.currentParagraphIndex = 0,
    this.timerSeconds = 1800, // 30 minutes
    this.paragraphs = const [],
  });

  ListeningPracticeState copyWith({
    bool? isPracticeStarted,
    int? currentParagraphIndex,
    int? timerSeconds,
    List<Paragraph>? paragraphs,
  }) {
    return ListeningPracticeState(
      isPracticeStarted: isPracticeStarted ?? this.isPracticeStarted,
      currentParagraphIndex: currentParagraphIndex ?? this.currentParagraphIndex,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      paragraphs: paragraphs ?? this.paragraphs,
    );
  }

  @override
  List<Object?> get props => [
        isPracticeStarted,
        currentParagraphIndex,
        timerSeconds,
        paragraphs,
      ];
}
