import 'package:e_commerce_app/Create%20Account/helper/methods.dart';
import 'package:e_commerce_app/Home%20Page/widgets/custom_back_button.dart';
import 'package:e_commerce_app/Landing%20Page/widgets/custom_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/helper/name_notifier.dart';
import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:e_commerce_app/global/services/auth_service.dart';
import 'package:e_commerce_app/global/widgets/custom_dialog.dart';
import 'package:e_commerce_app/global/widgets/custom_loading_indicator.dart';
import 'package:e_commerce_app/global/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditNameDialogBody extends StatefulWidget {
  const EditNameDialogBody({super.key});

  @override
  State<EditNameDialogBody> createState() => _EditNameDialogBodyState();
}

class _EditNameDialogBodyState extends State<EditNameDialogBody> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool isLoading = false;
  String? name, nameError;
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
                          "Edit Name",
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
                    hintText: currentUser?.name ?? "Guest",
                    validator: (data) {
                      String? validationMessage = validateName(data);
                      if (validationMessage != null) return validationMessage;
                      return nameError;
                    },
                    onSaved: (data) {
                      name = data!;
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
                                nameError = null;
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  String? errorMessage =
                                      await AuthService.editName(
                                        newName: name!,
                                        triggerLoading: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                        },
                                      );
                                  setState(() {
                                    isLoading = false;
                                    nameError = errorMessage;
                                  });
                                  if (errorMessage == null) {
                                    await showCustomDialog(
                                      context,
                                      title: "Name",
                                      subtitle: "Changed Successfully !",
                                      image: "assets/images/success.png",
                                      state: enState.success,
                                    );
                                    Navigator.pop(context);
                                    NameNotifier.updateName(context);
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
      ),
    );
  }
}
