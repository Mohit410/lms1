import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:lms1/presentation/screens/add_new_book/add_new_book.dart';
import 'package:lms1/presentation/screens/admin_list/bloc/admin_list_bloc.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';
import 'package:lms1/presentation/screens/collect_fine/collect_fine.dart';
import 'package:lms1/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';
import 'package:lms1/presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'injection_container.dart';
import 'presentation/screens/book_list/book_list.dart';
import 'presentation/screens/home/home.dart';
import 'presentation/screens/librarian_list/bloc/librarian_list_bloc.dart';
import 'presentation/screens/register/register.dart';
import 'presentation/screens/return_book/return_book.dart';
import 'presentation/screens/student_list/student_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await initDI();
  sl<HttpClient>().init();
  await UserPreferences.init();
  await Future.delayed(Duration.zero);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LoginBloc>()),
        BlocProvider(create: (_) => sl<RegisterBloc>()),
        BlocProvider(create: (_) => sl<DashboardBloc>()),
        BlocProvider(create: (_) => sl<AdminListBloc>()),
        BlocProvider(create: (_) => sl<StudentListBloc>()),
        BlocProvider(create: (_) => sl<LibrarianListBloc>()),
        BlocProvider(create: (_) => sl<BookListBloc>()),
        BlocProvider(create: (_) => sl<UserDetailBloc>()),
        BlocProvider(create: (_) => sl<UpdatePasswordBloc>()),
        BlocProvider(create: (_) => sl<NavigationBloc>()),
        BlocProvider(create: (_) => sl<BookDetailsBloc>()),
        BlocProvider(create: (_) => sl<AddNewBookBloc>()),
        BlocProvider(create: (_) => sl<ReturnBookBloc>()),
        BlocProvider(create: (_) => sl<CollectFineBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true).copyWith(),
        title: "Library Management App",
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: UserPreferences.userToken == null
                  ? const LoginPage()
                  : const HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
