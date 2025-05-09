import 'package:equatable/equatable.dart';

    class VerifyEmailUsersResponseEntity extends Equatable {
    final bool success;
      final String message;

    const VerifyEmailUsersResponseEntity({
        required this.success,
        required this.message,
    });

    @override
    List<Object?> get props => [success, message];
    }