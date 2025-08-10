import 'package:e_commerce_app/global/helper/data.dart';
import 'package:e_commerce_app/global/helper/methods.dart';
import 'package:flutter/material.dart';

class EmailNotifier {
  static final ValueNotifier<String> userEmail = ValueNotifier<String>(
    getEmailEncrypted(currentUser?.email ?? ""),
  );

  static Future<void> updateEmail(BuildContext context) async {
    userEmail.value = getEmailEncrypted(currentUser!.email);
  }
}
