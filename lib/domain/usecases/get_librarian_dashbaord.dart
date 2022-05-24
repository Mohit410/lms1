import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetLibrarianDashBoard extends UseCase<DashboardResponse, NoParams> {
  final LibrarianRepository _repository;

  GetLibrarianDashBoard(this._repository);

  @override
  Future<Either<Failure, DashboardResponse>> call(NoParams params) async {
    return await _repository.getDashboardData();
  }
}
