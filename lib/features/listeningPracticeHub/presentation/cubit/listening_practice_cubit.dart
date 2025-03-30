import 'package:flutter_bloc/flutter_bloc.dart';
import 'listening_practice_state.dart';

class ListeningPracticeCubit extends Cubit<ListeningPracticeState> {

  ListeningPracticeCubit() : super(const ListeningPracticeState());

  // Initialize paragraphs (this could be fetched from a backend or defined locally)
  void initializeParagraphs(List<Paragraph> paragraphs) {
    emit(state.copyWith(
      paragraphs: paragraphs,
      currentParagraphIndex: 0,
    ));
  }

  // Start the practice session
  void startPractice() {
    if (state.isPracticeStarted) return;

    emit(state.copyWith(isPracticeStarted: true));

  }

  // Update the current paragraph index (e.g., when user swipes)
  void updateIndex(int newIndex) {
    if (newIndex >= 0 && newIndex < state.paragraphs.length) {
      emit(state.copyWith(currentParagraphIndex: newIndex));
    }
  }

  // Navigate to next paragraph
  void nextParagraph() {
    if (state.currentParagraphIndex < state.paragraphs.length - 1) {
      emit(state.copyWith(currentParagraphIndex: state.currentParagraphIndex + 1));
    }
  }

  // Navigate to previous paragraph
  void previousParagraph() {
    if (state.currentParagraphIndex > 0) {
      emit(state.copyWith(currentParagraphIndex: state.currentParagraphIndex - 1));
    }
  }

}
