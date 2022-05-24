import 'package:lms1/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class GetUpdateBook extends UseCase<CommonResponse, BookModel>{
final BookRepository _repository;

  GetUpdateBook(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(BookModel params) async{
    return await _repository.updateBook(params);
  }

  
  
}