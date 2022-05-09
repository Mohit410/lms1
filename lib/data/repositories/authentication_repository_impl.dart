import 'package:lms1/data/datasources/remote_datasource.dart';
import 'package:lms1/domain/repositories/repositories.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final RemoteDatasource datasource;

  AuthenticationRepositoryImpl({required this.datasource});
}
