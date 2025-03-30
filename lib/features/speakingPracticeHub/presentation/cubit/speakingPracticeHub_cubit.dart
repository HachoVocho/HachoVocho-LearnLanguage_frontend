import '../../domain/entities/getFaceToFaceConversations_speakingPracticeHub_params_entity.dart';
import '../../domain/usecases/getFaceToFaceConversations_speakingPracticeHub_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './speakingPracticeHub_state.dart';

class SpeakingpracticehubCubit extends Cubit<SpeakingpracticehubState> {

  Future<void> getfacetofaceconversationsSpeakingpracticehub(GetfacetofaceconversationsSpeakingpracticehubParamsEntity params) async {
    emit(SpeakingpracticehubLoading());
    _getfacetofaceconversationsSpeakingpracticehubUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(GetfacetofaceconversationsSpeakingpracticehubError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        emit(GetfacetofaceconversationsSpeakingpracticehubSuccess(success));
      });
    });
  }

  final GetfacetofaceconversationsSpeakingpracticehubUseCase _getfacetofaceconversationsSpeakingpracticehubUseCase;

  // Initialize use cases or repository here

  SpeakingpracticehubCubit( this._getfacetofaceconversationsSpeakingpracticehubUseCase,) : super(InitialSpeakingpracticehubState());

  // Add methods here
}
