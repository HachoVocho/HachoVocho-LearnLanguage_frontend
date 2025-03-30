import 'package:hachovocho_learn_language/features/speakingPracticeHub/presentation/cubit/face_to_face_conversation_cubit.dart';

import 'domain/usecases/getFaceToFaceConversations_speakingPracticeHub_usecase.dart';

    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/speakingPracticeHub_repository_imp.dart';
    import 'domain/repositories/speakingPracticeHub_repository.dart';
    import 'presentation/cubit/speakingPracticeHub_cubit.dart';

    final SpeakingpracticehubInstance = GetIt.instance;

    Future<void> init() async {
    // Data Sources
    SpeakingpracticehubInstance.registerLazySingleton<SpeakingpracticehubNetworkSource>(
        () => SpeakingpracticehubNetworkSourceImp(),
    );

    // Repositories
    SpeakingpracticehubInstance.registerLazySingleton<SpeakingpracticehubRepository>(
        () => SpeakingpracticehubRepositoryImp(SpeakingpracticehubInstance<SpeakingpracticehubNetworkSource>()),
    );
    
    // Use Cases
  SpeakingpracticehubInstance.registerLazySingleton(() => GetfacetofaceconversationsSpeakingpracticehubUseCase(SpeakingpracticehubInstance<SpeakingpracticehubRepository>()));

    // Cubits
    SpeakingpracticehubInstance.registerFactory(() => SpeakingpracticehubCubit(SpeakingpracticehubInstance<GetfacetofaceconversationsSpeakingpracticehubUseCase>(),));
    SpeakingpracticehubInstance.registerFactory(() => FaceToFaceConversationCubit());
    }
    