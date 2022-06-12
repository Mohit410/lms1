import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:lms1/core/utils/extensions.dart';
part 'student_list_event.dart';
part 'student_list_state.dart';

class StudentListBloc extends Bloc<StudentListEvent, StudentListState> {
  final GetUserList _getUserList;
  StudentListBloc(this._getUserList) : super(EmptyStudents()) {
    on<FetchStudentList>((event, emit) async {
      emit(StudentListLoading());
      final result = await _getUserList(NoParams());

      result.fold(
        (failure) {
          if (failure is ServerFailureWithMessage) {
            emit(StudentListFailed(message: failure.message));
          } else {
            emit(const StudentListFailed(message: 'Server Error'));
          }
        },
        (response) {
          if (response.success) {
            final studetList = response.users.getRoleBasedList(Role.student);
            log("Total Students: ${studetList.length}");
            if (studetList.isEmpty) {
              emit(EmptyStudents());
            } else {
              emit(StudentListLoaded(students: studetList));
            }
          } else {
            emit(const StudentListFailed(message: 'No data'));
          }
        },
      );
    });
  }
}
