import 'package:equatable/equatable.dart';

class VerifyEmailUsersParamsEntity extends Equatable {
    final String email;
    final String code;

    const VerifyEmailUsersParamsEntity({required this.email, required this.code});

    @override
    List<Object?> get props => [email, code];
}