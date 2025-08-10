import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/widgets/custom_dialog.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class EditPasswordDialogBody extends StatefulWidget {
  const EditPasswordDialogBody({super.key, required this.pass});
  final String pass;

  @override
  State<EditPasswordDialogBody> createState() => _EditPasswordDialogBodyState();
}

class _EditPasswordDialogBodyState extends State<EditPasswordDialogBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String? pass, passError;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 340,
        height: 150,
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
                  const Text(
                    "Are you sure you want to change password ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    spacing: 10,
                    children: [
                      isLoading
                          ? const Expanded(child: CustomLoadingIndicator())
                          : Expanded(
                            child: CustomButton(
                              text: "Yes",
                              onTap: () async {
                                passError = null;
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  if (await AuthService.sendPasswordReset(
                                    triggerLoading: () {
                                      setState(() {
                                        isLoading = true;
                                      });
                                    },
                                    context: context,
                                  )) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    await showCustomDialog(
                                      context,
                                      title: "Password Reset",
                                      subtitle: "Email Sent Successfully !",
                                      image: "assets/images/success.png",
                                      state: enState.success,
                                    );
                                    Navigator.pop(context);
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
                      Expanded(
                        child: CustomButton(
                          text: "Cancel",
                          textColor: Colors.black,
                          backColor: const Color(0xffE9E9E9),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
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
