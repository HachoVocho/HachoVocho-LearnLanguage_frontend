import '../../domain/entities/markSentenceListened_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/markSentenceListened_listeningPracticeHub_response_entity.dart';import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getSentencesByTopic_listeningPracticeHub_response_entity.dart';import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_params_entity.dart';
import '../../domain/entities/getUserTopicsProgress_listeningPracticeHub_response_entity.dart';import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../../domain/repositories/listeningPracticeHub_repository.dart';
import '../datasource/network_source.dart';

class ListeningpracticehubRepositoryImp extends ListeningpracticehubRepository {
  final ListeningpracticehubNetworkSource _networkSource;

  ListeningpracticehubRepositoryImp(this._networkSource);
      @override
      Stream<Either<Failure, MarksentencelistenedListeningpracticehubResponseEntity>> marksentencelistenedListeningpracticehub(MarksentencelistenedListeningpracticehubParamsEntity marksentencelistenedListeningpracticehubParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.marksentencelistenedListeningpracticehub(marksentencelistenedListeningpracticehubParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    
      @override
      Stream<Either<Failure, GetsentencesbytopicListeningpracticehubResponseEntity>> getsentencesbytopicListeningpracticehub(GetsentencesbytopicListeningpracticehubParamsEntity getsentencesbytopicListeningpracticehubParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.getsentencesbytopicListeningpracticehub(getsentencesbytopicListeningpracticehubParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
    
      @override
      Stream<Either<Failure, GetusertopicsprogressListeningpracticehubResponseEntity>> getusertopicsprogressListeningpracticehub(GetusertopicsprogressListeningpracticehubParamsEntity getusertopicsprogressListeningpracticehubParamsEntity) async* {
        try {
          final responseFromNetwork = await _networkSource.getusertopicsprogressListeningpracticehub(getusertopicsprogressListeningpracticehubParamsEntity);
          yield Right(responseFromNetwork);
        } on Failure catch (failure) {
          yield Left(failure);
        } catch (e) {
          yield Left(FailureMessage());
        }
      }
  
  
  // Implement repository methods here
}
