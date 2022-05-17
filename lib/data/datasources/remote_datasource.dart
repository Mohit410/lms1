import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class RemoteDataSourceImpl implements RemoteDatasource {
  final HttpClient client;

  RemoteDataSourceImpl({required this.client});

  String? get token => UserPreferences.getUserToken();

  Dio get dio => client.dio;

  @override
  Future<CommonResponse> createUser(RegisterUserModel user) async {
    final response = await dio.post(
      "register",
      data: user.toMap(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      return CommonResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<LoginResponse> login(LoginBody loginBody) async {
    final response = await dio.post(
      "login",
      data: loginBody.toMap(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      return LoginResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<UserListResponse> getUserList() async {
    final response = await dio.get('appRegistrationDetails');
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      return UserListResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<BookListResponse> getBooks() async {
    final response = await dio.get('appGetBooks');
    if (response.data['success'] == true) {
      return BookListResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<AdminDashboardResponse> getAdminDashboardData() async {
    final response = await dio.get('appAdminDashboard');
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return AdminDashboardResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<StudentDetailResponse> getStudentDetails(String email) async {
    final response = await dio.get('appStudentDetails/$email');
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return StudentDetailResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<CommonResponse> updateUser(String role, UserModel body) async {
    final response = await dio.post(
      'appUpdateUser/$role',
      data: body.toMap(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return CommonResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<CommonResponse> updatePassword(
      UpdatePasswordBody body, String email, String role) async {
    final response = await dio.post(
      'appUpdatePassword/$email/$role',
      data: body.toMap(),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return CommonResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<CommonResponse> uploadBulk(String filePath,String fileName) async {
    final formData = FormData.fromMap({
      'excelfile': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    final response = await dio.post('bulkUpload', data: formData);

    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return CommonResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }
}

abstract class RemoteDatasource {
  // authentication
  Future<LoginResponse> login(LoginBody loginBody);

  // user
  Future<CommonResponse> createUser(RegisterUserModel user);
  Future<CommonResponse> uploadBulk(String filePath,String fileName);
  Future<UserListResponse> getUserList();
  Future<AdminDashboardResponse> getAdminDashboardData();
  Future<StudentDetailResponse> getStudentDetails(String email);
  Future<CommonResponse> updateUser(String role, UserModel body);
  Future<CommonResponse> updatePassword(
      UpdatePasswordBody body, String email, String role);

  // books
  Future<BookListResponse> getBooks();
}
