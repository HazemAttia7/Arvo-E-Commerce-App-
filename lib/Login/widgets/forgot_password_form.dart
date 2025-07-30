import 'package:e_commerce_app/Create%20Account/helper/methods.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/widgets/custom_dialog.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  String userEmail = "";
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidateMode,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CustomTextFormField(
            hintText: "Email",
            validator: (data) {
              return validateEmail(data);
            },
            onSaved: (data) {
              userEmail = data!;
            },
          ),
          const SizedBox(height: 15),
          isLoading
              ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: CustomLoadingIndicator(),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: CustomButton(
                  text: "Find Email",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      setState(() {
                        isLoading = true;
                      });
                      if (await AuthService.isEmailExist(
                        context,
                        email: userEmail,
                      )) {
                        if (await AuthService.sendPasswordReset(
                          context: context,
                          email: userEmail,
                          triggerLoading: () {
                            setState(() {
                              isLoading = true;
                            });
                          },
                        )) {
                          setState(() {
                            isLoading = false;
                          });
                          await showCustomDialog(
                            context,
                            title: "Password Reset",
                            subtitle: "Email Sent Successfully",
                            state: enState.success,
                            image: 'assets/images/success.png',
                          );
                          Navigator.pop(context);
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        autoValidateMode = AutovalidateMode.always;
                      }
                    }
                  },
                ),
              ),
        ],
      ),
    );
  }
}
