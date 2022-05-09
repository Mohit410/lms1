import 'package:flutter/material.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/login/login.dart';
import 'package:lms1/presentation/screens/register/register.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          titleText: 'Home', context: context, leading: null, noLeading: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Register Page"),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Login Page"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
