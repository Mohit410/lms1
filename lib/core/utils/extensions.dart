import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/data/models/models.dart';

extension StringExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

extension UserListExtension on List<UserModel> {
  List<UserModel> getRoleBasedList(Role role) =>
      where((user) => user.role == role.name).toList();
}

extension HttpErrorsExtension on HttpErrors {
  int get code {
    switch (this) {
      case HttpErrors.success:
        return 200;
      case HttpErrors.created:
        return 201;
      case HttpErrors.badRequest:
        return 400;
      case HttpErrors.unauthorized:
        return 401;
      case HttpErrors.forbidded:
        return 403;
      case HttpErrors.notFound:
        return 404;
      case HttpErrors.internalServerError:
        return 500;
      case HttpErrors.badGateway:
        return 502;
      default:
        return 1;
    }
  }
}
