import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/home/home_page.dart';
import 'package:lms1/presentation/screens/login/login.dart';

class LoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const LoginPage());

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: UserPreferences.getUserEmail());
    passwordController = TextEditingController();
    _isPasswordVisible = false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Login',
            style: GoogleFonts.pacifico(),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: buildBody(context),
      ),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          showSnackbar(state.message, context);
          await UserPreferences.setUserEmail(emailController.text);
          Navigator.of(buildContext).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
        if (state is LoginFailed) {
          showSnackbar(state.message, context);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const LoadingWidget();
        }
        return Padding(
          padding: const EdgeInsets.all(36.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                emailField(),
                const SizedBox(height: 20),
                passwordField(),
                const SizedBox(height: 35),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: loginButton(),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  emailField() => CustomTextField(
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter the email";
          }
          if (!Validator.isValidEmail(value)) {
            return "Please Enter a valid email";
          }
          return null;
        },
        prefixIcon: const Icon(Icons.email_rounded),
        hintText: 'Enter Email',
        labelText: 'Email',
        inputType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  passwordField() => CustomTextField(
        controller: passwordController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Please enter passwrod";
          }
          return null;
        },
        prefixIcon: const Icon(Icons.vpn_key_rounded),
        hintText: 'Enter Password',
        labelText: 'Password',
        inputType: TextInputType.text,
        isPasswordField: true,
        isObsecureText: !_isPasswordVisible,
        onPasswordshow: () => setState(
          () => _isPasswordVisible = !_isPasswordVisible,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  loginButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<LoginBloc>(context).add(
              LoginClicked(
                email: emailController.text,
                password: passwordController.text,
              ),
            );
          }
        },
        lable: 'Login',
        context: context,
        color: Colors.red,
        textColor: Colors.white,
      );
}
