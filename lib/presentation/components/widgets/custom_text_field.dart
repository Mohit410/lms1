import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) validator;
  final Widget? prefixIcon;
  final String hintText;
  final String labelText;
  final TextInputType inputType;
  final String? prefixText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormators;
  final AutovalidateMode? autovalidateMode;
  final bool? isObsecureText;
  final VoidCallback? onPasswordshow;
  final bool? isPasswordField;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.validator,
    required this.prefixIcon,
    required this.hintText,
    required this.labelText,
    required this.inputType,
    this.prefixText,
    this.maxLength,
    this.inputFormators,
    this.autovalidateMode,
    this.isObsecureText = false,
    this.onPasswordshow,
    this.isPasswordField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      onSaved: (value) {
        controller.text = value!;
      },
      obscureText: isObsecureText ?? false,
      autovalidateMode: autovalidateMode,
      validator: (value) => validator(value),
      textInputAction: TextInputAction.next,
      maxLength: maxLength,
      decoration: InputDecoration(
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: (isPasswordField!)
              ? IconButton(
                  onPressed: onPasswordshow,
                  icon: Icon(
                    isObsecureText!
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: hintText,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
