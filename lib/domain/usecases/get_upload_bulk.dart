import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUploadBulk extends UseCase<BulkUploadResponse, PlatformFile> {
  final UserRepository _repository;

  GetUploadBulk(this._repository);

  @override
  Future<Either<Failure, BulkUploadResponse>> call(PlatformFile params) async {
    return await _repository.uploadBulkUsers(params);
  }
}
