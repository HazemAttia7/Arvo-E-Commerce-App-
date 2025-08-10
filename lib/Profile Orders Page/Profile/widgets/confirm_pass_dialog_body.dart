import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/edit_dialog_body.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ConfirmPassDialogBody extends StatefulWidget {
  const ConfirmPassDialogBody({super.key});

  @override
  State<ConfirmPassDialogBody> createState() => _ConfirmPassDialogBodyState();
}

class _ConfirmPassDialogBodyState extends State<ConfirmPassDialogBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String? pass, passwordError;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 340,
        height: 230,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 15,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    hintText: "Confirm Password",
                    isPassword: true,
                    validator: (data) {
                      if (data?.isEmpty ?? true) {
                        return "Field is required .";
                      }
                      return passwordError;
                    },
                    onSaved: (data) {
                      pass = data!;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child:
                      isLoading
                          ? const CustomLoadingIndicator()
                          : CustomButton(
                            text: "Confirm",
                            onTap: () async {
                              passwordError = null;
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                String? errorMessage =
                                    await AuthService.confirmPasswordWithEmail(
                                      context,
                                      password: pass!,
                                      triggerLoading: () {
                                        setState(() {
                                          isLoading = true;
                                        });
                                      },
                                    );
                                setState(() {
                                  isLoading = false;
                                  passwordError = errorMessage;
                                });
                                if (errorMessage == null) {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return EditDialogBody(pass: pass!,);
                                    },
                                  );
                                } else {
                                  _formKey.currentState!.validate();
                                }
                              } else {
                                setState(() {
                                  autovalidateMode = AutovalidateMode.always;
                                });
                              }
                            },
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
