import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailureWithMessage extends Failure {
  final String message;

  ServerFailureWithMessage(this.message);
}

class ServerFailure extends Failure {

}

class CacheFailure extends Failure {
  final dynamic error;

  CacheFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AnotherFailure extends Failure {
  final dynamic error;

  AnotherFailure({required this.error});

  @override
  List<Object> get props => [error];
}
