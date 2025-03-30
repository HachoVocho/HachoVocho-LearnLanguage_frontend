
import 'package:equatable/equatable.dart';
                       
abstract class UsersState extends Equatable {
    @override
    List<Object?> get props => [];
}

class UsersLoading extends UsersState {}

class InitialUsersState extends UsersState {}

// Add other states as needed


class SignupUsersSuccess extends UsersState {
  final String message;

  SignupUsersSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class SignupUsersError extends UsersState {
  final String message;

  SignupUsersError(this.message);

  @override
  List<Object?> get props => [message];
}


class VerifyEmailUsersSuccess extends UsersState {
  final String message;

  VerifyEmailUsersSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyEmailUsersError extends UsersState {
  final String message;

  VerifyEmailUsersError(this.message);

  @override
  List<Object?> get props => [message];
}


class LoginUsersSuccess extends UsersState {
  final String message;

  LoginUsersSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class LoginUsersError extends UsersState {
  final String message;

  LoginUsersError(this.message);

  @override
  List<Object?> get props => [message];
}
