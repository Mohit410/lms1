import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetFineDetails extends UseCase<CollectFineDetailResposne, String> {
  final LibrarianRepository _repository;

  GetFineDetails(this._repository);

  @override
  Future<Either<Failure, CollectFineDetailResposne>> call(String params) async {
    return await _repository.getFineDetails(params);
  }
}
