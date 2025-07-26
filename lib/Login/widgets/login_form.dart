import 'package:e_commerce_app/global/models/user_model.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Login/helper/methods.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/services/realm_preference_service.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:e_commerce_app/Login/widgets/custom_underlined_clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Main Screen/views/main_view.dart';

// ignore: must_be_immutable
class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, pass;
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
        autovalidateMode: autovalidateMode,
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              onSaved: (data) {
                email = data;
              },
              validator: (data) {
                return validateEmptyData(data);
              },
              hintText: "Email",
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
              onSaved: (data) {
                pass = data;
              },
              validator: (data) {
                return validateEmptyData(data);
              },
              hintText: "Password",
              isObscured: true,
            ),
            const SizedBox(height: 20),
            const CustomUnderlinedClickableText(),
            const SizedBox(height: 25),
            isLoading
                ? const CustomLoadingIndicator()
                : CustomButton(
                  text: "Login",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      UserModel? user = await AuthService.performLogin(
                        context,
                        email: email!,
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
                      bool loggedIn = user != null;
                      if (loggedIn) {
                        currentUser = user;
                        await realmPreferenceService.setRememberMePreference(
                          remember: true,
                          email: email!,
                        );
                        Navigator.pushReplacementNamed(context, MainView.route);
                      }
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
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
