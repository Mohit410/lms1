import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';

import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';

class UpdatePasswordPage extends StatefulWidget {
  static Route route(String email, String role) => MaterialPageRoute(
      builder: (_) => UpdatePasswordPage(email: email, role: role));

  final String email;
  final String role;
  const UpdatePasswordPage({
    Key? key,
    required this.email,
    required this.role,
  }) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late UpdatePasswordBloc _bloc;
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    _bloc = BlocProvider.of<UpdatePasswordBloc>(context);
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (UserPreferences.userRole == Role.admin.name)
          ? AppBar(
              title: Text(
                'Update Password',
                style: GoogleFonts.pacifico(),
              ),
              foregroundColor: Colors.black87,
              backgroundColor: Colors.white,
              elevation: 1,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            )
          : AppBar(
              title: Text(
                'Update Password',
                style: GoogleFonts.pacifico(),
              ),
              centerTitle: true,
              foregroundColor: Colors.black87,
              backgroundColor: Colors.white,
              elevation: 1,
              automaticallyImplyLeading: false,
            ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
      listener: (context, state) {
        if (state is PasswordUpdateSucsess) {
          showSnackbar(state.message, buildContext);
          if (Navigator.of(buildContext).canPop()) {
            Navigator.pop(buildContext);
          } else {
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
          }
        }
        if (state is PasswordUpdateFailed) {
          showSnackbar(state.message, buildContext);
        }
      },
      builder: (context, state) {
        if (state is PasswordUpdateLoading) {
          return const Center(child: LoadingWidget());
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  oldPasswordField(),
                  const SizedBox(height: 20),
                  newPasswordField(),
                  const SizedBox(height: 20),
                  confirmPasswordField(),
                  const SizedBox(height: 40),
                  const Spacer(),
                  updateButton(),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  oldPasswordField() => CustomTextField(
        controller: oldPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter old password';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Enter Old Password',
        labelText: 'Old Password',
        inputType: TextInputType.text,
        isObsecureText: true,
      );

  newPasswordField() => CustomTextField(
        controller: newPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter new password';
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Enter New Password',
        labelText: 'New Password',
        inputType: TextInputType.text,
        isObsecureText: true,
      );

  confirmPasswordField() => CustomTextField(
        controller: confirmPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm new password';
          }
          if (value != newPasswordController.text) {
            return "Password doesn't match";
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.vpn_key),
        hintText: 'Confirm New Password',
        labelText: 'Confirm Password',
        inputType: TextInputType.text,
        isObsecureText: false,
      );

  updateButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _bloc.add(UpdatePasswordClicked(
              email: widget.email,
              role: widget.role,
              oldPassword: oldPasswordController.text,
              newPassword: newPasswordController.text,
              confirmPassword: confirmPasswordController.text,
            ));
          }
        },
        lable: 'Update Password',
        context: context,
        color: Colors.red,
        textColor: Colors.white,
      );
}
