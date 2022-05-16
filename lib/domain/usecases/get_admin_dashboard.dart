import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetAdminDashboard extends UseCase<AdminDashboardResponse, NoParams> {
  final UserRepository _repository;

  GetAdminDashboard(this._repository);
  @override
  Future<Either<Failure, AdminDashboardResponse>> call(NoParams params) async {
    return await _repository.getAdminDashboardData();
  }
}
