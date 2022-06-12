import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/presentation/screens/screens.dart';
import 'package:lms1/core/network/http_client.dart';
import 'package:lms1/core/utils/utils.dart';
import 'injection_container.dart';

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
        theme: lightTheme(context),
        title: "Library Management App",
        darkTheme: darkTheme(context),
        home: const SplashScreen(),
      ),
    );
  }

  lightTheme(BuildContext context) => ThemeData.light().copyWith(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          //elevation: 1,
          //color: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54),
          actionsIconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        colorScheme: const ColorScheme.light().copyWith(),
        navigationBarTheme: NavigationBarThemeData(
          //elevation: 1,
          backgroundColor: Colors.white,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              overflow: TextOverflow.clip,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo.shade500,
          foregroundColor: Colors.white,
        ),
      );

  darkTheme(BuildContext context) => ThemeData.dark().copyWith(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          elevation: 1,
          backgroundColor: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline5,
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.indigo,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(
              overflow: TextOverflow.clip,
            ),
          ),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        ),
        colorScheme: const ColorScheme.dark().copyWith(),
      );
}

class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: UserPreferences.userToken == null
              ? const LoginPage()
              : const HomePage(),
        ),
      ),
    );
  }
}
