import 'package:flutter_bloc/flutter_bloc.dart';
import 'face_to_face_state.dart';

class FaceToFaceCubit extends Cubit<FaceToFaceState> {
  FaceToFaceCubit() : super(const FaceToFaceState());

  void updatePreferredLanguage(String? lang) {
    emit(state.copyWith(preferredLanguage: lang));
  }

  void updateLearningLanguage(String? lang) {
    emit(state.copyWith(learningLanguage: lang));
  }

  void updateLevel(String? lvl) {
    emit(state.copyWith(level: lvl));
  }

  void updateTopic(String? top) {
    emit(state.copyWith(topic: top));
  }
}
