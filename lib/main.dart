import 'package:flutter/material.dart';
import 'package:lms1/components/widgets/loading_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization(null);
  runApp(const MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(Duration.zero);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Library Management App",
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: LoadingWidget(),
          ),
        ),
      ),
    );
  }
}
