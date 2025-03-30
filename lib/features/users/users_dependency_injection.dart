import 'domain/usecases/login_users_usecase.dart';
import 'domain/usecases/verify_email_users_usecase.dart';
import 'domain/usecases/signup_users_usecase.dart';

    import 'package:get_it/get_it.dart';

    import 'data/datasource/network_source.dart';
    import 'data/datasource/network_source_imp.dart';
    import 'data/repositories/users_repository_imp.dart';
    import 'domain/repositories/users_repository.dart';
    import 'presentation/cubit/users_cubit.dart';

    final UsersInstance = GetIt.instance;

    Future<void> init() async {
  // Data Sources (only one registration)
  UsersInstance.registerLazySingleton<UsersNetworkSource>(
    () => UsersNetworkSourceImp(),
  );

  // Repository depends on the interface
  UsersInstance.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImp(UsersInstance<UsersNetworkSource>()),
  );
    
  // Use Cases
  UsersInstance.registerLazySingleton(() => LoginUsersUseCase(UsersInstance<UsersRepository>()));
  UsersInstance.registerLazySingleton(() => VerifyEmailUsersUseCase(UsersInstance<UsersRepository>()));
  UsersInstance.registerLazySingleton(() => SignupUsersUseCase(UsersInstance<UsersRepository>()));
    
    // Cubits
    UsersInstance.registerFactory(() => UsersCubit(UsersInstance<SignupUsersUseCase>(),UsersInstance<VerifyEmailUsersUseCase>(),UsersInstance<LoginUsersUseCase>(),));
    }
    