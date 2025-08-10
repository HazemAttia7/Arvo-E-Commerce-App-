import 'package:e_commerce_app/global/helper/data.dart';
import 'package:flutter/material.dart';

class NameNotifier {
  static final ValueNotifier<String> userName = ValueNotifier<String>(
    currentUser?.name ?? "Guest",
  );

  static Future<void> updateName(BuildContext context) async {
    userName.value = currentUser!.name;
  }
}
