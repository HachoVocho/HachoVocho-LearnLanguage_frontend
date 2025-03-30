import 'package:equatable/equatable.dart';

    class LoginUsersResponseEntity extends Equatable {
    final bool success;
    final String message;
    final Map? data;

    const LoginUsersResponseEntity({
        required this.success,
        required this.message,
         this.data
    });

    @override
    List<Object?> get props => [success, message];
    }