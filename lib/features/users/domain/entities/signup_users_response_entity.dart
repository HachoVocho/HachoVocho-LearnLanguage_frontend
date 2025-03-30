import 'package:equatable/equatable.dart';

    class SignupUsersResponseEntity extends Equatable {
    final bool success;
      final String message;

    const SignupUsersResponseEntity({
        required this.success,
        required this.message,
    });

    @override
    List<Object?> get props => [success, message];
    }