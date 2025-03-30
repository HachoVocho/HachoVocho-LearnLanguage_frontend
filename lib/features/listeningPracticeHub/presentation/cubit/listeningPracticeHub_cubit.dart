import 'dart:async';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../../domain/usecases/markSentenceListened_listeningPracticeHub_usecase.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../../domain/usecases/getSentencesByTopic_listeningPracticeHub_usecase.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../../domain/usecases/getUserTopicsProgress_listeningPracticeHub_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './listeningPracticeHub_state.dart';

class ListeningpracticehubCubit extends Cubit<ListeningpracticehubState> {
  Future<void> marksentencelistenedListeningpracticehub(MarksentencelistenedListeningpracticehubParamsEntity params,GetsentencesbytopicListeningpracticehubResponseEntity responseData,int currentPage) async {
    //emit(ListeningpracticehubLoading());
    _marksentencelistenedListeningpracticehubUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(MarksentencelistenedListeningpracticehubError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        print(currentPage);
        responseData.data![currentPage].isListened = true;
        emit(GetsentencesbytopicListeningpracticehubSuccess(responseData,sentenceId: params.sentenceId,emittedAt: DateTime.now()));
      });
    });
  }


  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _configureTts() async {
    await _flutterTts.setSpeechRate(0.5); // Adjust speech rate
    await _flutterTts.setPitch(1.0); // Adjust pitch
    await _flutterTts.setVolume(1.0); // Set volume (0.0 to 1.0)
  }

  Future<void> speak(String text, String language) async {
    final completer = Completer<void>();
    try {
      print('language');
      print(language);
      await _flutterTts.setLanguage(language);
      _flutterTts.setCompletionHandler(() {
        print('Speech completed');
        completer.complete(); // Notify completion
      });
      await _flutterTts.speak(text);
      await completer.future; // Wait for completion
    } catch (e) {
      completer.completeError(e); // Handle errors
      print('Error during TTS: $e');
      emit(GetsentencesbytopicListeningpracticehubError("Failed to play TTS: ${e.toString()}"));
    }
  }


  Future<void> getsentencesbytopicListeningpracticehub(GetsentencesbytopicListeningpracticehubParamsEntity params) async {
    _getsentencesbytopicListeningpracticehubUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(GetsentencesbytopicListeningpracticehubError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        emit(GetsentencesbytopicListeningpracticehubSuccess(success));
        _configureTts();
      });
    });
  }

  @override
  Future<void> close() {
    _flutterTts.stop(); // Stop TTS on Cubit close
    return super.close();
  }

  Future<void> getusertopicsprogressListeningpracticehub(GetusertopicsprogressListeningpracticehubParamsEntity params) async {
    _getusertopicsprogressListeningpracticehubUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(GetusertopicsprogressListeningpracticehubError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        emit(GetusertopicsprogressListeningpracticehubSuccess(success));
      });
    });
  }


  final GetusertopicsprogressListeningpracticehubUseCase _getusertopicsprogressListeningpracticehubUseCase;

  final GetsentencesbytopicListeningpracticehubUseCase _getsentencesbytopicListeningpracticehubUseCase;

  final MarksentencelistenedListeningpracticehubUseCase _marksentencelistenedListeningpracticehubUseCase;

  // Initialize use cases or repository here

  ListeningpracticehubCubit(this._getusertopicsprogressListeningpracticehubUseCase, this._getsentencesbytopicListeningpracticehubUseCase,this._marksentencelistenedListeningpracticehubUseCase) : super(ListeningpracticehubLoading());

  // Add methods here
}
