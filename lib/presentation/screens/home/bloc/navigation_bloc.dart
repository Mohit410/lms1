import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GetUploadBulk _getUploadBulk;
  final GetUploadBulkBooks _getUploadBulkBooks;
  NavigationBloc(this._getUploadBulk, this._getUploadBulkBooks)
      : super(NavigationInitial()) {
    on<UploadBulkUsers>((event, emit) async {
      emit(Uploading());
      final result = await _getUploadBulk(event.file);

      result.fold((failure) async {
        if (failure is ServerFailureWithMessage) {
          emit(UploadFailed(failure.message));
          Future.delayed(
            const Duration(seconds: 2),
            () async => await createExcelForUsers(failure.data),
          );
        } else {
          emit(const UploadFailed('Server Error'));
        }
      }, (response) => emit(UploadSuccess(response.message)));
    });

    on<UploadBulkBooks>((event, emit) async {
      emit(Uploading());
      final result = await _getUploadBulkBooks(event.file);

      result.fold((failure) async {
        if (failure is ServerFailureWithMessage) {
          emit(UploadFailed(failure.message));
          Future.delayed(
            const Duration(seconds: 2),
            () async => await createExcelForBooks(failure.data),
          );
        } else {
          emit(const UploadFailed('Server Error'));
        }
      }, (response) => emit(UploadSuccess(response.message)));
    });
  }

  createExcelForBooks(List<BookRowResponse> errorList) {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    sheet.appendRow([
      "id",
      "title",
      "name",
      "publisher",
      "author",
      "total copies",
      "category",
      "price",
      "errors"
    ]);

    for (var row in errorList) {
      sheet.appendRow([
        row.id,
        row.title,
        row.name,
        row.publisher,
        row.author,
        row.totalCopies,
        row.category,
        row.price,
        row.error,
      ]);
    }

    saveExcel(excel, 'book_details.xlsx');
  }

  createExcelForUsers(List<ExcelRowResponse> errorList) {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    sheet.appendRow([
      "name",
      "email",
      "phone",
      "address",
      "city",
      "state",
      "pincode",
      "role",
      "error",
    ]);

    for (var row in errorList) {
      sheet.appendRow([
        row.name,
        row.email,
        row.mobileNo,
        row.address,
        row.city,
        row.state,
        row.pincode,
        row.role,
        row.error,
      ]);
    }

    saveExcel(excel, 'registration_details.xlsx');
  }

  saveExcel(Excel excel, String fileName) async {
    var res = await Permission.storage.request();

    if (res.isGranted) {
      final file = await writeExcel(excel, fileName);
      openFile(file);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeExcel(Excel excel, String fileName) async {
    final file = await _localFile(fileName);
    return await file.writeAsBytes(excel.encode()!);
  }

  openFile(File file) async {
    final result = await OpenFile.open(file.path);
  }
}
