import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:lms1/core/error/exception.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/response/response.dart';
import 'package:lms1/data/models/book_list_response.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class RemoteDataSourceImpl implements RemoteDatasource {
  final HttpClient client;

  RemoteDataSourceImpl({required this.client});

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
  Future<BulkUploadResponse> uploadBulk(
      String filePath, String fileName) async {
    final formData = FormData.fromMap({
      'excelfile': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    final response = await dio.post('bulkUpload', data: formData);

    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return BulkUploadResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage<List<ExcelRowResponse>>(
        response.data['message'],
        data: List<ExcelRowResponse>.from(
          response.data['data']?.map((x) => ExcelRowResponse.fromMap(x)),
        ),
      );
    }
  }

  @override
  Future<BookDetailsResponse> getBookDetails(String bookId) async {
    final response = await dio.get('appListIssuedBooks/$bookId');

    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return BookDetailsResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<DashboardResponse> getLibrarianDashboardData() async {
    final response = await dio.get('appLibrarianDashboard');
    if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return LibrarianDashboardResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage(response.data['message']);
    }
  }

  @override
  Future<CommonResponse> addBook(AddNewBookModel book) async {
    final response = await dio.post(
      "appAddBook",
      data: book.toMap(),
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
  Future<CommonResponse> updateBook(BookModel book) async {
    final response = await dio.post(
      "appUpdateBook/${book.bookId}",
      data: book.toMap(),
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
  Future<BulkBookUploadResponse> uploadBooksInBulk(
      String filePath, String fileName) async {
    final formData = FormData.fromMap({
      'excelbookfile':
          await MultipartFile.fromFile(filePath, filename: fileName)
    });
    final response = await dio.post('bulkBookUpload', data: formData);

     if (response.statusCode != 200) {
      throw ServerException();
    } else if (response.data['success'] == true) {
      log(response.data.toString());
      return BulkBookUploadResponse.fromMap(response.data);
    } else {
      throw ServerExceptionWithMessage<List<BookRowResponse>>(
        response.data['message'],
        data: List<BookRowResponse>.from(response.data['data']?.map((x) => BookRowResponse.fromMap(x))),
      );
    }
  }
}

abstract class RemoteDatasource {
  // authentication
  Future<LoginResponse> login(LoginBody loginBody);

  // user
  Future<CommonResponse> createUser(RegisterUserModel user);
  Future<BulkUploadResponse> uploadBulk(String filePath, String fileName);
  Future<UserListResponse> getUserList();
  Future<DashboardResponse> getAdminDashboardData();
  Future<StudentDetailResponse> getStudentDetails(String email);
  Future<CommonResponse> updateUser(String role, UserModel body);
  Future<CommonResponse> updatePassword(
      UpdatePasswordBody body, String email, String role);

  // books
  Future<BookListResponse> getBooks();
  Future<BookDetailsResponse> getBookDetails(String bookId);

  // librarian
  Future<DashboardResponse> getLibrarianDashboardData();
  Future<CommonResponse> addBook(AddNewBookModel book);

  Future<CommonResponse> updateBook(BookModel book);
  Future<BulkBookUploadResponse> uploadBooksInBulk(
      String filePath, String fileName);
}
