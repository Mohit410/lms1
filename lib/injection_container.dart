import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/network/network_info.dart';
import 'package:lms1/core/utils/constants.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/repositories/repositories.dart';
import 'package:lms1/domain/repositories/repositories.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:lms1/presentation/screens/admin_list/bloc/admin_list_bloc.dart';
import 'package:lms1/presentation/screens/book_list/bloc/book_list_bloc.dart';
import 'package:lms1/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:lms1/presentation/screens/librarian_list/bloc/librarian_list_bloc.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/register/bloc/register_bloc.dart';
import 'package:lms1/presentation/screens/student_list/bloc/student_list_bloc.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';
import 'package:lms1/presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

initDI() async {
  final pref = await SharedPreferences.getInstance();

  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => HttpClient(dio: sl()));
  sl.registerLazySingleton(() => pref);
  sl.registerLazySingleton(() => DataConnectionChecker());
  //sl.registerLazySingleton(() => http.Client());

  // datasources
  sl.registerLazySingleton<RemoteDatasource>(
      () => RemoteDataSourceImpl(client: sl()));

  // repositories
  sl.registerFactory<BookRepository>(() => BookRepositoryImpl(sl()));
  sl.registerFactory<UserRepository>(() => UserReposiotryImpl(sl()));
  sl.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()));

  //  usecases
  sl.registerFactory(() => GetAdminDashboard(sl()));
  sl.registerFactory(() => GetBookList(sl()));
  sl.registerFactory(() => GetUserList(sl()));
  sl.registerFactory(() => CreateUser(sl()));
  sl.registerFactory(() => GetLogin(sl()));
  sl.registerFactory(() => GetStudentDetails(sl()));
  sl.registerFactory(() => GetUpdateUser(sl()));
  sl.registerFactory(() => GetUpdatePassword(sl()));

  // blocs
  sl.registerLazySingleton(() => UserDetailBloc(sl()));
  sl.registerLazySingleton(() => StudentListBloc(sl()));
  sl.registerLazySingleton(() => LibrarianListBloc(sl()));
  sl.registerLazySingleton(() => AdminListBloc(sl()));
  sl.registerLazySingleton(() => DashboardBloc(sl()));
  sl.registerLazySingleton(() => BookListBloc(sl()));
  sl.registerLazySingleton(() => LoginBloc(sl()));
  sl.registerLazySingleton(() => RegisterBloc(sl(), sl()));
  sl.registerLazySingleton(() => UpdatePasswordBloc(sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
