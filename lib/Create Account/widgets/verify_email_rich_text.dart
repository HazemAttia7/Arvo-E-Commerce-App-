import 'package:flutter/material.dart';

class VerifyEmailRichText extends StatelessWidget {
  const VerifyEmailRichText({super.key, required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 167, 167, 167),
        ),
        children: [
          const TextSpan(text: "Enter the"),
          const TextSpan(
            text: " 6 digits code ",
            style: TextStyle(color: Colors.black),
          ),
          const TextSpan(text: "sent to your email"),
          const TextSpan(text: " address"),
          TextSpan(
            text: " ${getEmailEncrypted(email)} ",
            style: const TextStyle(color: Colors.black),
          ),
          const TextSpan(text: "below."),
        ],
      ),
    );
  }
}

String getEmailEncrypted(String email) {
  int atIndex = email.indexOf("@");

  if (atIndex <= 1) return email;

  String firstChar = email[0];
  String masked = '*' * (atIndex - 1);
  String domain = email.substring(atIndex);

  return '$firstChar$masked$domain';
}
