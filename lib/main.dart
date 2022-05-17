import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/utils/user_preferences.dart';
import 'package:lms1/presentation/screens/admin_list/bloc/admin_list_bloc.dart';
import 'package:lms1/presentation/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';
import 'package:lms1/presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'injection_container.dart';
import 'presentation/screens/book_list/book_list.dart';
import 'presentation/screens/home/home.dart';
import 'presentation/screens/librarian_list/bloc/librarian_list_bloc.dart';
import 'presentation/screens/register/register.dart';
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
        BlocProvider(create: (context) => sl<LoginBloc>()),
        BlocProvider(create: (context) => sl<RegisterBloc>()),
        BlocProvider(create: (context) => sl<DashboardBloc>()),
        BlocProvider(create: (context) => sl<AdminListBloc>()),
        BlocProvider(create: (context) => sl<StudentListBloc>()),
        BlocProvider(create: (context) => sl<LibrarianListBloc>()),
        BlocProvider(create: (context) => sl<BookListBloc>()),
        BlocProvider(create: (context) => sl<UserDetailBloc>()),
        BlocProvider(create: (context) => sl<UpdatePasswordBloc>()),
        BlocProvider(create: (context) => sl<NavigationBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Library Management App",
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: LoginPage(),
            ),
          ),
        ),
      ),
    );
  }
}
