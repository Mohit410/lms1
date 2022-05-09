import 'package:dio/dio.dart';
import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/data/models/user_model.dart';

class RemoteDataSourceImpl implements RemoteDatasource {
  final Dio client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<CommonResponse> createUser(UserModel user) async {
    final response = await client.post(
      "$BASEURL/register",
      data: user.toMap(),
      options: Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    if (response.statusCode == 200) {
      print(response.data);
      return CommonResponse.fromMap(response.data);
    } else {
      throw ServerException;
    }
  }
}

abstract class RemoteDatasource {
  Future<CommonResponse> createUser(UserModel user);
}
