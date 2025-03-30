import 'domain/usecases/markSentenceListened_listeningPracticeHub_usecase.dart';
import 'domain/usecases/getSentencesByTopic_listeningPracticeHub_usecase.dart';
import 'domain/usecases/getUserTopicsProgress_listeningPracticeHub_usecase.dart';

    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/listeningPracticeHub_repository_imp.dart';
    import 'domain/repositories/listeningPracticeHub_repository.dart';
    import 'presentation/cubit/listeningPracticeHub_cubit.dart';

    final ListeningpracticehubInstance = GetIt.instance;

    Future<void> init() async {
    // Data Sources
    ListeningpracticehubInstance.registerLazySingleton<ListeningpracticehubNetworkSource>(
        () => ListeningpracticehubNetworkSourceImp(),
    );

    // Repositories
    ListeningpracticehubInstance.registerLazySingleton<ListeningpracticehubRepository>(
        () => ListeningpracticehubRepositoryImp(ListeningpracticehubInstance<ListeningpracticehubNetworkSource>()),
    );
    
    // Use Cases
  ListeningpracticehubInstance.registerLazySingleton(() => MarksentencelistenedListeningpracticehubUseCase(ListeningpracticehubInstance<ListeningpracticehubRepository>()));
  ListeningpracticehubInstance.registerLazySingleton(() => GetsentencesbytopicListeningpracticehubUseCase(ListeningpracticehubInstance<ListeningpracticehubRepository>()));
  ListeningpracticehubInstance.registerLazySingleton(() => GetusertopicsprogressListeningpracticehubUseCase(ListeningpracticehubInstance<ListeningpracticehubRepository>()));

    // Cubits
    ListeningpracticehubInstance.registerFactory(() => ListeningpracticehubCubit(ListeningpracticehubInstance<GetusertopicsprogressListeningpracticehubUseCase>(),ListeningpracticehubInstance<GetsentencesbytopicListeningpracticehubUseCase>(),ListeningpracticehubInstance<MarksentencelistenedListeningpracticehubUseCase>()));
    }
    