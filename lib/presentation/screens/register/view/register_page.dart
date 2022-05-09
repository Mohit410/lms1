import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/core/utils/validator.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/injection_container.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/register/register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late RegisterBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController mobileNoController;
  late TextEditingController stateController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController pincodeController;
  late String _userRole;

  @override
  void initState() {
    super.initState();
    _bloc = sl<RegisterBloc>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileNoController = TextEditingController();
    stateController = TextEditingController();
    addressController = TextEditingController();
    pincodeController = TextEditingController();
    cityController = TextEditingController();
    _userRole = "";
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    stateController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          titleText: 'Register',
          context: context,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              _bloc.close();
            },
            icon: const Icon(Icons.arrow_back),
          )),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          showSnackbar(state.message, context);
          _bloc.close();
          Navigator.of(buildContext).pop();
        }
        if (state is RegisterFailed) {
          showSnackbar(state.message, context);
        }
      },
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const Center(child: LoadingWidget());
        }
        return SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    nameField(),
                    const SizedBox(height: 20),
                    emailField(),
                    const SizedBox(height: 20),
                    mobileNoField(),
                    const SizedBox(height: 20),
                    addressField(),
                    const SizedBox(height: 20),
                    stateField(),
                    const SizedBox(height: 20),
                    cityField(),
                    const SizedBox(height: 20),
                    pincodeField(),
                    const SizedBox(height: 20),
                    roleDropDown(),
                    const SizedBox(height: 35),
                    registerButton(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  registerButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final userModel = UserModel(
              name: nameController.text,
              email: emailController.text,
              mobileNo: mobileNoController.text,
              address: addressController.text,
              state: stateController.text,
              city: cityController.text,
              pincode: pincodeController.text,
              role: _userRole.toLowerCase(),
            );

            BlocProvider.of<RegisterBloc>(context)
                .add(RegisterClicked(userModel: userModel));
          }
        },
        lable: 'Register',
        context: context,
        color: Colors.red,
        textColor: Colors.white,
      );

  nameField() => CustomTextField(
        controller: nameController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the name";
          } else {
            return null;
          }
        },
        prefixIcon: const Icon(Icons.person_rounded),
        hintText: 'Enter Name',
        labelText: 'Name',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

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

  mobileNoField() => CustomTextField(
        controller: mobileNoController,
        validator: (value) {
          if (value != null && value.length < 10) {
            return "Enter a valid 10 digit mobile number";
          }
          final regex = RegExp(r"^[6-9]\d{9}$");
          if (!regex.hasMatch(value!)) {
            return "Enter a valid Indian mobile number";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.phone_rounded),
        hintText: 'Enter Mobile No',
        labelText: 'Mobile No',
        inputType: TextInputType.phone,
        prefixText: '+91',
        inputFormators: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        maxLength: 10,
      );

  addressField() => CustomTextField(
        controller: addressController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the address";
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.my_location_rounded),
        hintText: 'Enter Address',
        labelText: 'Address',
        inputType: TextInputType.streetAddress,
      );

  cityField() => CustomTextField(
        controller: cityController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the city";
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.location_city_rounded),
        hintText: 'Enter City',
        labelText: 'City',
        inputType: TextInputType.streetAddress,
      );

  pincodeField() => CustomTextField(
        controller: pincodeController,
        validator: (value) {
          RegExp regex = RegExp(r"^.{6,}$");
          if (value!.isEmpty) {
            return "Please enter the pincode";
          } else if (!regex.hasMatch(value)) {
            return 'Please enter a valid pincode';
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormators: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.singleLineFormatter,
        ],
        prefixIcon: const Icon(Icons.pin_drop_rounded),
        hintText: 'Enter Pincode',
        labelText: 'Pincode',
        inputType: TextInputType.number,
        maxLength: 6,
      );

  stateField() => CustomTextField(
        controller: stateController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the state";
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.location_city_rounded),
        hintText: 'Enter State',
        labelText: 'State',
        inputType: TextInputType.name,
      );

  roleDropDown() => CustomDropDownFormField(
        itemList: const ['Student', 'Librarian', 'Admin'],
        onItemChanged: onRoleChanged,
        currentValue: _userRole == "" ? null : _userRole,
        hint: 'Select A Role',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a role";
          }
          return null;
        },
      );

  onRoleChanged(String role) {
    setState(() {
      _userRole = role;
    });
  }
}
