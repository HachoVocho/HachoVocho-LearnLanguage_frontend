import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  String toString() {
    return message ?? "";
  }

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  @override
  String? message;
  ServerFailure({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class BadRequestFailure extends Failure {
  @override
  String? message = "";
  BadRequestFailure({this.message});

  @override
  String toString() {
    return message ?? "Invalid Request !!!";
  }
}

class UnauthorizedFailure extends Failure {
  @override
  String? message = "";
  UnauthorizedFailure({this.message});

  @override
  String toString() {
    return message ?? "Unauthorised !!!";
  }
}

class FailureMessage extends Failure {
  @override
  String? message = "";
  FailureMessage({this.message});
  @override
  String toString() {
    return message ?? "Something went wrong !!!";
  }
}

class CacheFailure extends Failure {
  @override
  String? message = "";
  CacheFailure({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class AuthFailure extends Failure {
  @override
  String? message = "";
  AuthFailure({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class NoDataFailure extends Failure {
  @override
  String? message = "";
  NoDataFailure({this.message});

  @override
  String toString() {
    return message ?? "No data found !!";
  }
}

class InternetFailure extends Failure {
  @override
  String? message = "";
  InternetFailure({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}

class DataExists<T> extends Failure {
  @override
  String? message = "";
  DataExists({this.message});

  @override
  String toString() {
    return message ?? "";
  }
}