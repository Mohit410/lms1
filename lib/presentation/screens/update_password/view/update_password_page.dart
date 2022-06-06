import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';

import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
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
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _bloc = BlocProvider.of<UpdatePasswordBloc>(context);
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return BlocConsumer<UpdatePasswordBloc, UpdatePasswordState>(
      listener: (context, state) async {
        if (state is PasswordUpdateSucsess) {
          showSnackbar(state.message, buildContext);
          await Future.delayed(const Duration(seconds: 2));
          if (widget.email == UserPreferences.userEmail) {
            await DashboardBloc.logout();
          }

          if (Navigator.of(buildContext).canPop()) {
            Navigator.pop(buildContext);
          } else {
            _oldPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
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
        return Scaffold(
          appBar: (UserPreferences.userRole == Role.admin.name)
              ? AppBar(
                  title: const Text('Update Password'),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                )
              : AppBar(
                  title: const Text('Update Password'),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                ),
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext buildContext) {
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
              _oldPasswordField(),
              const SizedBox(height: 20),
              _newPasswordField(),
              const SizedBox(height: 20),
              _confirmPasswordField(),
              const SizedBox(height: 40),
              const Spacer(),
              _updateButton(),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  _oldPasswordField() => CustomTextField(
        controller: _oldPasswordController,
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

  _newPasswordField() => CustomTextField(
        controller: _newPasswordController,
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

  _confirmPasswordField() => CustomTextField(
        controller: _confirmPasswordController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm new password';
          }
          if (value != _newPasswordController.text) {
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

  _updateButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _bloc.add(UpdatePasswordClicked(
              email: widget.email,
              role: widget.role,
              oldPassword: _oldPasswordController.text,
              newPassword: _newPasswordController.text,
              confirmPassword: _confirmPasswordController.text,
            ));
          }
        },
        lable: 'Update Password',
        context: context,
        color: Colors.red,
        textColor: Colors.white,
      );
}
