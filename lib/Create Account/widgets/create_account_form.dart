import 'package:e_commerce_app/Create%20Account/helper/methods.dart';
import 'package:e_commerce_app/Create%20Account/models/temp_user_model.dart';
import 'package:e_commerce_app/Create%20Account/services/email_service.dart';
import 'package:e_commerce_app/Create%20Account/views/verify_email_view.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({super.key});

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController passwordController = TextEditingController();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  String? userName, userEmail, pass, confirmPass;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Name",
              validator: (data) {
                return validateName(data);
              },
              onSaved: (data) {
                userName = data;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Email",
              validator: (data) {
                return validateEmail(data);
              },
              onSaved: (data) {
                userEmail = data;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              textController: passwordController,
              hintText: "Password",
              isPassword: true,
              validator: (data) {
                return validatePassword(data);
              },
              onSaved: (data) {
                pass = data;
              },
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              hintText: "Confirm Password",
              isPassword: true,
              isViewable: false,
              validator: (data) {
                return validateConfirmPassword(data, passwordController.text);
              },
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CustomLoadingIndicator()
                : CustomButton(
                  text: "Create Account",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      TempUserModel tempUserModel = TempUserModel(
                        name: userName!,
                        email: userEmail!,
                        password: pass!,
                        favList: [],
                        shoppingCart: {},
                      );
                      if (await EmailService.sendOTPWithPackage(
                        email: userEmail!,
                        triggerLoading: () {
                          setState(() {
                            isLoading = true;
                          });
                        },
                      )) {
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => VerifyEmailView(
                                  tempUserModel: tempUserModel,
                                ),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        isLoading = false;
                        autoValidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                ),
          ],
        ),
      ),
    );
  }
}
