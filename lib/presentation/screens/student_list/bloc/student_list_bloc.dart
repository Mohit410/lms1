import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/get_upload_bulk.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:lms1/core/utils/extensions.dart';
part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final GetUserList _getUserList;
  StudentListBloc(this._getUserList)
      : super(EmptyStudents()) {
    on<FetchStudentList>((event, emit) async {
      emit(Loading());
      final result = await _getUserList(NoParams());

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(Failed(message: failure.message));
          } else {
            emit(const Failed(message: 'Server Error'));
          }
        },
        (response) {
          if (response.success) {
            final studetList = response.users.getRoleBasedList(Role.student);
            log("Total Students: ${studetList.length}");
            if (studetList.isEmpty) {
              emit(EmptyStudents());
            } else {
              emit(StudentsLoaded(students: studetList));
            }
          } else {
            emit(const Failed(message: 'No data'));
          }
        },
      );
    });
  }
}
