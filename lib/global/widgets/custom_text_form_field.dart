import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.textController,
    this.isPassword = false,
    this.isViewable = true,
    this.borderColor = const Color(0xffE0E0E0),
    this.enabled,
    this.onChanged,
    this.inputFormatters,
    this.textAlign = TextAlign.start, this.focusNode,
  });

  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? textController;
  final bool isPassword;
  final bool isViewable;
  final Color borderColor;
  final bool? enabled;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final FocusNode? focusNode;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;
  @override
  void initState() {
    _isObscured = widget.isPassword && widget.isViewable;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      controller: widget.textController,
      onSaved: widget.onSaved,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      obscureText:
          widget.isPassword ? (widget.isViewable ? _isObscured : true) : false,
      decoration: InputDecoration(
        suffixIcon:
            widget.isPassword && widget.isViewable
                ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                  icon:
                      _isObscured
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
      borderSide: BorderSide(color: widget.borderColor),
    );
  }
}
