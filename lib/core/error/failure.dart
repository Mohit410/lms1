import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailureWithMessage<T> extends Failure {
  final String message;
  final T? data;

  ServerFailureWithMessage(this.message, {this.data});
}

class ServerFailure extends Failure {}

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
