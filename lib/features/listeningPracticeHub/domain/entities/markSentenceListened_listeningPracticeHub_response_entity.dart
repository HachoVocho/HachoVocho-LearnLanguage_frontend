import 'package:equatable/equatable.dart';

    class MarksentencelistenedListeningpracticehubResponseEntity extends Equatable {
    final bool success;
      final String message;

    const MarksentencelistenedListeningpracticehubResponseEntity({
        required this.success,
        required this.message,
    });

    @override
    List<Object?> get props => [success, message];
    }