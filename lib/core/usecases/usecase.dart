import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures/failures.dart';

abstract class UseCase<Type,T> {
  Stream<Either<Failure , Type>> call(T params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCase2<Type,T> {
  Stream<Either<Failure , Type>> call(T params,T params1,bool isSignUp,String endPoint);
}