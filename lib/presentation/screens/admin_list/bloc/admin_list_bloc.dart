import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/core/usecase/usecase.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/core/utils/extensions.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/domain/usecases/usecases.dart';

part 'admin_list_event.dart';
part 'admin_list_state.dart';

class AdminListBloc extends Bloc<AdminListEvent, AdminListState> {
  final GetUserList _getUserList;
  AdminListBloc(this._getUserList) : super(EmptyAdmins()) {
    on<FetchAdminList>((event, emit) async {
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
            final adminList = response.users.getRoleBasedList(Role.admin);
            log("Total Admins: ${adminList.length}");
            if (adminList.isEmpty) {
              emit(EmptyAdmins());
            } else {
              emit(AdminsLoaded(admins: adminList));
            }
          } else {
            emit(const Failed(message: 'No data'));
          }
        },
      );
    });
  }
}
