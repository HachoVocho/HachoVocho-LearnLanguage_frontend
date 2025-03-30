import 'domain/usecases/getStaticStrings_splash_usecase.dart';

    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/splash_repository_imp.dart';
    import 'domain/repositories/splash_repository.dart';
    import 'presentation/cubit/splash_cubit.dart';

    final SplashInstance = GetIt.instance;

    Future<void> init() async {
    // Data Sources
    SplashInstance.registerLazySingleton<SplashNetworkSource>(
        () => SplashNetworkSourceImp(),
    );

    // Repositories
    SplashInstance.registerLazySingleton<SplashRepository>(
        () => SplashRepositoryImp(SplashInstance<SplashNetworkSource>()),
    );
    // Use Cases
  SplashInstance.registerLazySingleton(() => GetstaticstringsSplashUseCase(SplashInstance<SplashRepository>()));

    // Cubits
    SplashInstance.registerFactory(() => SplashCubit(SplashInstance<GetstaticstringsSplashUseCase>(),));
    }
    