import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  /* final dynamic error;

  ServerFailure({required this.error});

  @override
  List<Object?> get props => [error]; */
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
