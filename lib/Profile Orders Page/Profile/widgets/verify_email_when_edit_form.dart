import 'package:e_commerce_app/Create%20Account/services/email_service.dart';
import 'package:e_commerce_app/Create%20Account/widgets/code_expiration_text.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/helper/email_notifier.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/widgets/custom_dialog.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class VerifyEmailWhenEditForm extends StatefulWidget {
  const VerifyEmailWhenEditForm({
    super.key,
    required this.email,
    required this.pass,
  });
  final String email;
  final String pass;

  @override
  State<VerifyEmailWhenEditForm> createState() =>
      _VerifyEmailWhenEditFormState();
}

class _VerifyEmailWhenEditFormState extends State<VerifyEmailWhenEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<CodeExpirationTextState> _codeTimerKey = GlobalKey();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  bool isLoading = false;
  bool _canResendCode = false;

  void onChanged(String val, int index) {
    if (val.length == 1) {
      FocusScope.of(context).nextFocus();
      if (index == 5) {
        setState(() {
          _selectedTextFieldIndex = -1;
        });
      }
    } else if (val.isEmpty) {
      FocusScope.of(context).previousFocus();
    }
  }

  int _selectedTextFieldIndex = -1;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(6, (index) {
      final node = FocusNode();
      node.addListener(() {
        if (node.hasFocus) {
          setState(() {
            _selectedTextFieldIndex = index;
          });
        }
      });
      return node;
    });
  }

  @override
  Widget build(BuildContext context) {
    final realmPreferenceService = Provider.of<RealmPreferenceService>(
      context,
      listen: false,
    );
    return AbsorbPointer(
      absorbing: isLoading,
      child: Form(
        key: _formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            Row(
              spacing: 10,
              children: List.generate(6, (index) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: CustomTextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      textController: controllers[index],
                      borderColor:
                          _selectedTextFieldIndex == index
                              ? Colors.black
                              : Colors.grey,
                      onChanged: (val) => onChanged(val, index),
                      validator:
                          (data) => data == null || data.isEmpty ? "" : null,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            CodeExpirationText(
              key: _codeTimerKey,
              durationInSeconds: 180,
              onTimerEnd: () {
                setState(() {
                  _canResendCode = true;
                });
              },
              onTimerStart: () {
                _canResendCode = false;
              },
            ),
            const SizedBox(height: 30),
            RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  const TextSpan(
                    text: "Didn't get code? ",
                    style: TextStyle(color: Color.fromARGB(255, 167, 167, 167)),
                  ),
                  TextSpan(
                    text: "Resend Code",
                    style: TextStyle(
                      color: _canResendCode ? Colors.black : Colors.black45,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer:
                        _canResendCode
                            ? (TapGestureRecognizer()
                              ..onTap = () {
                                _codeTimerKey.currentState?.restartTimer();
                                setState(() {
                                  _canResendCode = false;
                                });
                                EmailService.sendOTPWithPackage(
                                  email: widget.email,
                                );
                              })
                            : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            isLoading
                ? const CustomLoadingIndicator()
                : CustomButton(
                  text: "Verify Email Address",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final otpCode = getOtpFromControllers();
                      if (await EmailService.verifyOTPWithPackage(
                        otpCode,
                        triggerLoading: () {
                          setState(() {
                            isLoading = true;
                          });
                        },
                      )) {
                        // For email editing, we need to update the user's email
                        String? errorMessage = await AuthService.editEmail(
                          password: widget.pass,
                          newEmail: widget.email,
                          triggerLoading: () {
                            setState(() {
                              isLoading = true;
                            });
                          },
                        );
                        await realmPreferenceService.setEmail(
                          email: widget.email,
                        );
                        setState(() {
                          isLoading = false;
                        });

                        if (errorMessage == null) {
                          await showCustomDialog(
                            context,
                            title: "Email",
                            subtitle: "Changed Successfully !",
                            image: "assets/images/success.png",
                            state: enState.success,
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                          EmailNotifier.updateEmail(context);
                        } else {
                          // Error updating email
                          ScaffoldMessenger.of(context).showSnackBar(
                            buildCustomSnackBar(
                              title: 'Failed!',
                              message: errorMessage,
                              backColor: const Color(0xFFF16B61),
                            ),
                          );
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          buildCustomSnackBar(
                            title: 'Failed!',
                            message: "Please enter valid OTP code",
                            backColor: const Color(0xFFF16B61),
                          ),
                        );
                      }
                    } else {
                      setState(() {
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

  String getOtpFromControllers() {
    return controllers.map((c) => c.text).join();
  }
}
