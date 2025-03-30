
import 'package:equatable/equatable.dart';

                       
abstract class SplashState extends Equatable {
    @override
    List<Object?> get props => [];
}

class SplashLoading extends SplashState {}

class InitialSplashState extends SplashState {}

// Add other states as needed


class GetstaticstringsSplashSuccess extends SplashState {
  final String message;
  final Map data;

  GetstaticstringsSplashSuccess(this.message,this.data);

  @override
  List<Object?> get props => [message,data];
}

class GetstaticstringsSplashError extends SplashState {
  final String message;

  GetstaticstringsSplashError(this.message);

  @override
  List<Object?> get props => [message];
}
