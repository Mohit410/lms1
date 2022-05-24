import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUploadBulkBooks extends UseCase<BulkBookUploadResponse, PlatformFile> {
  final BookRepository _repository;

  GetUploadBulkBooks(this._repository);

  @override
  Future<Either<Failure, BulkBookUploadResponse>> call(PlatformFile params) async {
    return await _repository.uploadBulkBooks(params);
  }
}
