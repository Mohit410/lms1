import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/network/network_info.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/repositories/repositories.dart';
import 'package:lms1/domain/repositories/repositories.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:lms1/presentation/screens/add_new_book/add_new_book.dart';
import 'package:lms1/presentation/screens/admin_list/admin_list.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';
import 'package:lms1/presentation/screens/collect_fine/collect_fine.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/home/home.dart';
import 'package:lms1/presentation/screens/librarian_list/librarian_list.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/register/register.dart';
import 'package:lms1/presentation/screens/return_book/return_book.dart';
import 'package:lms1/presentation/screens/student_list/student_list.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';
import 'package:lms1/presentation/screens/user_detail/user_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

initDI() async {
  final pref = await SharedPreferences.getInstance();

  //External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => HttpClient(dio: sl()));
  sl.registerLazySingleton(() => pref);
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  // datasources
  sl.registerLazySingleton<RemoteDatasource>(
      () => RemoteDataSourceImpl(client: sl()));

  // repositories
  sl.registerFactory<BookRepository>(() => BookRepositoryImpl(sl(), sl()));
  sl.registerFactory<UserRepository>(() => UserReposiotryImpl(sl(), sl()));
  sl.registerFactory<LibrarianRepository>(
      () => LibrarianRepositoryImpl(sl(), sl()));
  sl.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl(), sl()));
  sl.registerFactory<StudentRepository>(
      () => StudentRepositoryImpl(sl(), sl()));

  //  usecases
  sl.registerFactory(() => GetAdminDashboard(sl()));
  sl.registerFactory(() => GetBookList(sl()));
  sl.registerFactory(() => GetUserList(sl()));
  sl.registerFactory(() => CreateUser(sl()));
  sl.registerFactory(() => GetLogin(sl()));
  sl.registerFactory(() => GetStudentDetails(sl()));
  sl.registerFactory(() => GetUpdateUser(sl()));
  sl.registerFactory(() => GetUpdatePassword(sl()));
  sl.registerFactory(() => GetUploadBulk(sl()));
  sl.registerFactory(() => GetBookDetails(sl()));
  sl.registerFactory(() => GetLibrarianDashBoard(sl()));
  sl.registerFactory(() => GetAddBook(sl()));
  sl.registerFactory(() => GetUploadBulkBooks(sl()));
  sl.registerFactory(() => GetUpdateBook(sl()));
  sl.registerFactory(() => GetReturnBook(sl()));
  sl.registerFactory(() => GetIssuedBookDetails(sl()));
  sl.registerFactory(() => GetFineDetails(sl()));
  sl.registerFactory(() => GetStudentDashboard(sl()));
  sl.registerFactory(() => GetIssueBook(sl()));
  sl.registerFactory(() => GetPayFine(sl()));

  // blocs
  sl.registerLazySingleton(() => UserDetailBloc(sl()));
  sl.registerLazySingleton(() => StudentListBloc(sl()));
  sl.registerLazySingleton(() => LibrarianListBloc(sl()));
  sl.registerLazySingleton(() => AdminListBloc(sl()));
  sl.registerLazySingleton(() => DashboardBloc(sl(), sl(), sl()));
  sl.registerLazySingleton(() => BookListBloc(sl(), sl()));
  sl.registerLazySingleton(() => LoginBloc(sl()));
  sl.registerLazySingleton(() => RegisterBloc(sl(), sl()));
  sl.registerLazySingleton(() => UpdatePasswordBloc(sl()));
  sl.registerLazySingleton(() => NavigationBloc(sl(), sl()));
  sl.registerLazySingleton(() => BookDetailsBloc(sl()));
  sl.registerLazySingleton(() => AddNewBookBloc(sl(), sl()));
  sl.registerLazySingleton(() => ReturnBookBloc(sl(), sl()));
  sl.registerLazySingleton(() => CollectFineBloc(sl(), sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
