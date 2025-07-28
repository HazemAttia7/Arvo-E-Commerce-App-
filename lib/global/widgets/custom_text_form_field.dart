import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.validator,
    this.onSaved,
    this.textController,
    this.isPassword = false,
    this.isViewable = true,
  });

  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? textController;
  final bool isPassword;
  final bool isViewable;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObsecured;
  @override
  void initState() {
    _isObsecured = widget.isPassword && widget.isViewable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: widget.isPassword && _isObsecured,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword && widget.isViewable
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObsecured = !_isObsecured;
                    });
                  },
                  icon:
                      _isObsecured
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                )
                : null,
        errorMaxLines: 2,
        hintText: widget.hintText,
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
