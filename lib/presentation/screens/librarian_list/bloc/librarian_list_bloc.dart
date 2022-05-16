import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/core/utils/extensions.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'librarian_list_event.dart';
part 'librarian_list_state.dart';

class LibrarianListBloc extends Bloc<LibrarianListEvent, LibrarianListState> {
  final GetUserList _getUserList;
  LibrarianListBloc(this._getUserList) : super(LibrarianListInitial()) {
    on<FetchLibrarianList>((event, emit) async {
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
            final librarianList =
                response.users.getRoleBasedList(Role.librarian);
            log("Total Librarian: ${librarianList.length}");
            if (librarianList.isEmpty) {
              emit(EmptyLibrarians());
            } else {
              emit(LibrariansLoaded(librarians: librarianList));
            }
          } else {
            emit(const Failed(message: 'No data'));
          }
        },
      );
    });
  }
}
