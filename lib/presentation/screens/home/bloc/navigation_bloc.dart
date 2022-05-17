import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:lms1/core/error/failure.dart';
import 'package:lms1/domain/usecases/get_upload_bulk.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final GetUploadBulk _getUploadBulk;
  NavigationBloc(this._getUploadBulk) : super(NavigationInitial()) {
    on<UploadBulkUsers>((event, emit) async {
      final result = await _getUploadBulk(event.file);

      result.fold((failure) {
        if (failure is ServerFailureWithMessage) {
          emit(UploadFailed(failure.message));
        } else {
          emit(const UploadFailed('Server Error'));
        }
      }, (response) => emit(UploadSuccess(response.message)));
    });
  }
}
