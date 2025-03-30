import 'package:equatable/equatable.dart';

    class GetstaticstringsSplashResponseEntity extends Equatable {
    final bool success;
      final Map? data;
  final String message;

    const GetstaticstringsSplashResponseEntity({
        required this.success,
        this.data,
    required this.message,
    });

    @override
    List<Object?> get props => [success, data, message];
    }

