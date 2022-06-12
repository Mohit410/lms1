part of 'student_list_bloc.dart';

abstract class StudentListState extends Equatable {
  const StudentListState();

  @override
  List<Object> get props => [];
}

class EmptyStudents extends StudentListState {}

class StudentListLoading extends StudentListState {}

class StudentListLoaded extends StudentListState {
  final List<UserModel> students;
  const StudentListLoaded({required this.students});

  @override
  List<Object> get props => [students];
}

class StudentListFailed extends StudentListState {
  final String message;
  const StudentListFailed({required this.message});

  @override
  List<Object> get props => [message];
}
