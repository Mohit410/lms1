part of 'student_list_bloc.dart';

abstract class StudentListState extends Equatable {
  const StudentListState();

  @override
  List<Object> get props => [];
}

class EmptyStudents extends StudentListState {}

class Loading extends StudentListState {}

class StudentsLoaded extends StudentListState {
  final List<UserModel> students;
  const StudentsLoaded({required this.students});

  @override
  List<Object> get props => [students];
}

class Failed extends StudentListState {
  final String message;
  const Failed({required this.message});

  @override
  List<Object> get props => [message];
}
