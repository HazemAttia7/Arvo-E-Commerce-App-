import 'package:e_commerce_app/Create%20Account/helper/methods.dart';
import 'package:e_commerce_app/Main%20Screen/views/main_view.dart';
import 'package:e_commerce_app/global/models/user_model.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      UserModel userData = UserModel(
                        name: userName!,
                        email: userEmail!,
                        favList: [],
                        shoppingCart: {},
                      );
                      bool accountCreated =
                          await AuthService.performCreateAccount(
                            context,
                            userData: userData,
                            password: pass!,
                            triggerLoading: () {
                              setState(() {
                                isLoading = true;
                              });
                            },
                          );
                      setState(() {
                        isLoading = false;
                      });
                      if (accountCreated) {
                        currentUser = UserModel(
                          name: userName!,
                          email: userEmail!,
                          favList: [],
                          shoppingCart: {},
                        );
                        await realmPreferenceService.setRememberMePreference(
                          remember: true,
                          email: userEmail!,
                        );
                        Navigator.pushReplacementNamed(context, MainView.route);
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
}
