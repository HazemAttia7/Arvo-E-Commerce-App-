import 'package:e_commerce_app/global/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

Future<dynamic> showAlertCustomDialog(
  BuildContext context, {
  required String title,
}) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
            child: Text(title,textAlign: TextAlign.center,),
          ),
        ),
  );
}

void showErrorMessage(
  BuildContext context, {
  required String title,
  required String message,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(buildCustomSnackBar(title: title, message: message));
}

SnackBar buildCustomSnackBar({
  required String title,
  required String message,
  Color backColor = const Color(0xFFF16B61),
}) {
  return SnackBar(
    duration: const Duration(seconds: 2),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text(
          message,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: backColor,
  );
}

String getErrorMessage(e) {
  String errorMessage;
  switch (e.code) {
    case 'email-already-in-use':
      errorMessage = 'The email is already in use.';
      break;
    case 'invalid-email':
      errorMessage = 'The email address is badly formatted.';
      break;
    case 'user-disabled':
      errorMessage = 'This account has been disabled.';
      break;
    case 'too-many-requests':
      errorMessage = 'Too many attempts. Try again later.';
      break;
    case 'invalid-credential':
      errorMessage = 'Invalid email or password.';
      break;
    default:
      errorMessage = 'Oops something went wrong. Please try again.';
  }
  return errorMessage;
}

void showDefaultErrorMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Oops something went wrong. Please try again."),
    ),
  );
}

Future<dynamic> showCustomDialog(
  BuildContext context, {
  required String title,
  required String subtitle,
  required String image,
  required enState state,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true, // Allow dismissing by tapping outside
    builder: (BuildContext context) {
      return CustomDialog(title: title, subtitle: subtitle, image: image, state: state,);
    },
  );
}

String getEmailEncrypted(String email) {
  int atIndex = email.indexOf("@");

  if (atIndex <= 1) return email;

  String firstChar = email[0];
  String masked = '*' * (atIndex - 1);
  String domain = email.substring(atIndex);

  return '$firstChar$masked$domain';
}