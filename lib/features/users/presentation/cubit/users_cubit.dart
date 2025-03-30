import '../../../../core/widgets/globally_used_widgets.dart';
import '../../domain/entities/login_users_params_entity.dart';
import '../../domain/usecases/login_users_usecase.dart';
import '../../domain/entities/verify_email_users_params_entity.dart';
import '../../domain/usecases/verify_email_users_usecase.dart';
import '../../domain/entities/signup_users_params_entity.dart';
import '../../domain/usecases/signup_users_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import './users_state.dart';

class UsersCubit extends Cubit<UsersState> {

  Future<void> loginUsers(LoginUsersParamsEntity params) async {
    emit(UsersLoading());
    _loginUsersUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(LoginUsersError(fail.toString()));
      }, (success) async {
        print('success');
        print(success.message);
        await storeBoolInSharedPreference('is_user_logged_in',true);
        await storeStringsInSharedPreference('user_id',success.data!['user_id'].toString());
        emit(LoginUsersSuccess(success.message));
      });
    });
  }

  Future<void> verifyEmailUsers(VerifyEmailUsersParamsEntity params) async {
    emit(UsersLoading());
    _verifyEmailUsersUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(VerifyEmailUsersError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        emit(VerifyEmailUsersSuccess(success.message));
      });
    });
  }

  Future<void> signupUsers(SignupUsersParamsEntity params) async {
    emit(UsersLoading());
    _signupUsersUseCase.call(params).listen((event) {
      event.fold((fail) {
        emit(SignupUsersError(fail.toString()));
      }, (success) {
        print('success');
        print(success.message);
        emit(SignupUsersSuccess(success.message));
      });
    });
  }

  final SignupUsersUseCase _signupUsersUseCase;

  final VerifyEmailUsersUseCase _verifyEmailUsersUseCase;

  final LoginUsersUseCase _loginUsersUseCase;

  // Initialize use cases or repository here

  UsersCubit(this._signupUsersUseCase, this._verifyEmailUsersUseCase, this._loginUsersUseCase,) : super(InitialUsersState());

  // Add methods here
}
