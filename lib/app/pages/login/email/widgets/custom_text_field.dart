import 'package:exclusive_diary/app/core/theme/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField.email({
    required this.textEditingController,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    Key? key,
    this.validator,
  }) : super(key: key);

  const CustomTextField.password({
    required this.textEditingController,
    required this.hintText,
    this.obscureText = true,
    this.suffixIcon,
    Key? key,
    this.validator,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool pwdVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        style: AppStyle.regularText,
        controller: widget.textEditingController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: AppStyle.primaryColor,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppStyle.primaryColor),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppStyle.primaryColor, width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppStyle.primaryColor, width: 1.2),
            borderRadius: BorderRadius.circular(25.0),
          ),
          suffixIcon: widget.suffixIcon,
        ),
        validator: widget.validator,
      ),
    );
  }
}
