
    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/dashboard_repository_imp.dart';
    import 'domain/repositories/dashboard_repository.dart';
    import 'presentation/cubit/dashboard_cubit.dart';

    final DashboardInstance = GetIt.instance;

    Future<void> init() async {
    // Data Sources
    DashboardInstance.registerLazySingleton<DashboardNetworkSource>(
        () => DashboardNetworkSourceImp(),
    );

    // Repositories
    DashboardInstance.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImp(DashboardInstance<DashboardNetworkSourceImp>()),
    );
    
    // Use Cases

    // Cubits
    DashboardInstance.registerFactory(() => DashboardCubit());
    }
    