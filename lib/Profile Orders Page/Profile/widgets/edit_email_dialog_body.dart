import 'package:e_commerce_app/Create%20Account/helper/methods.dart';
import 'package:e_commerce_app/Create%20Account/services/email_service.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/views/verify_email_when_edit_view.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditEmailDialogBody extends StatefulWidget {
  const EditEmailDialogBody({super.key, required this.pass});
  final String pass;

  @override
  State<EditEmailDialogBody> createState() => _EditEmailDialogBodyState();
}

class _EditEmailDialogBodyState extends State<EditEmailDialogBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String? email, emailError;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  const Stack(
                    children: [
                      Center(
                        child: Text(
                          "Edit Email",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        ),
                      ),
                      Positioned(left: 0, top: 0, child: CustomBackButton()),
                    ],
                  ),
                  const SizedBox(height: 15),
                  CustomTextFormField(
                    hintText: currentUser?.email ?? "Guest@gmail.com",
                    validator: (data) {
                      String? validationMessage = validateEmail(data);
                      if (validationMessage != null) return validationMessage;
                      return emailError;
                    },
                    onSaved: (data) {
                      email = data!;
                    },
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child:
                        isLoading
                            ? const CustomLoadingIndicator()
                            : CustomButton(
                              text: "Edit",
                              onTap: () async {
                                emailError = null;
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (await EmailService.sendOTPWithPackage(
                                    triggerLoading: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    email: email!,
                                  )) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                VerifyEmailWhenEditView(
                                                  email: email!,
                                                  pass: widget.pass,
                                                ),
                                      ),
                                    );
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
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
      ),
    );
  }
}