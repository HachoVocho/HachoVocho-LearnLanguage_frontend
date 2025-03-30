import 'package:equatable/equatable.dart';

class LoginUsersParamsEntity extends Equatable {
    final String email;
    final String password;

    const LoginUsersParamsEntity({required this.email, required this.password});

    @override
    List<Object?> get props => [email, password];
}