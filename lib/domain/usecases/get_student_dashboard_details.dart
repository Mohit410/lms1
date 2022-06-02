import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetStudentDashboard
    extends UseCase<DashboardResponse, NoParams> {
  final StudentRepository _repository;

  GetStudentDashboard(this._repository);

  @override
  Future<Either<Failure, DashboardResponse>> call(NoParams params) async {
    return await _repository.getStudentDashbaordData();
  }
}