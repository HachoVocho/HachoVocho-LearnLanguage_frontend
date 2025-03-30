import 'package:equatable/equatable.dart';

class GetstaticstringsSplashParamsEntity extends Equatable {
    final String lang;

    const GetstaticstringsSplashParamsEntity({required this.lang});

    @override
    List<Object?> get props => [lang];
}