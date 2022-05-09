import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/presentation/screens/home/home_page.dart';
import 'package:lms1/presentation/screens/login/bloc/login_bloc.dart';

import 'injection_container.dart';
import 'presentation/screens/register/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await initDI();
  await Future.delayed(Duration.zero);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<RegisterBloc>()),
        BlocProvider(create: (context) => sl<LoginBloc>()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Library Management App",
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: HomePage(),
            ),
          ),
        ),
      ),
    );
  }
}
