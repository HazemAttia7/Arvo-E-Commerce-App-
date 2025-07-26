import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.isObscured = false,
    this.validator,
    this.onSaved, this.textController,
  });
 
  final String hintText;
  final bool isObscured;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? textController;
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      onSaved: onSaved,
      validator: validator,
      obscureText: isObscured,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xff757575), fontSize: 18),
        border: getBorder(),
        enabledBorder: getBorder(),
        focusedBorder: getBorder(),
      ),
    );
  }

  OutlineInputBorder getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xffE0E0E0)),
    );
  }
}
