import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoPrams extends Equatable {
  @override
  List<Object?> get props => [];
}
