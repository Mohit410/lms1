import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:lms1/core/network/network_info.dart';
import 'package:lms1/data/datasources/datasources.dart';
import 'package:lms1/data/repositories/repositories.dart';
import 'package:lms1/data/repositories/user_repository_impl.dart';
import 'package:lms1/domain/repositories/repositories.dart';
import 'package:lms1/domain/usecases/usecases.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/register/bloc/register_bloc.dart';

final sl = GetIt.instance;

initDI() async {
  //final pref = await SharedPref

  //External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => Dio());
  //sl.registerLazySingleton(() => http.Client());

  // datasources
  sl.registerLazySingleton<RemoteDatasource>(
      () => RemoteDataSourceImpl(client: sl()));

  // repositories
  sl.registerFactory<UserRepository>(() => UserReposiotryImpl(sl()));
  sl.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(datasource: sl()));

  //  usecases
  sl.registerFactory(() => CreateUser(repository: sl()));
  sl.registerFactory(() => GetLogin(repository: sl()));

  // blocs
  sl.registerLazySingleton(() => LoginBloc(getLogin: sl()));
  sl.registerLazySingleton(() => RegisterBloc(sl()));

  // core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}
