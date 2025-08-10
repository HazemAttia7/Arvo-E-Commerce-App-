import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/edit_button.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/edit_email_dialog_body.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/edit_name_dialog_body.dart';
import 'package:e_commerce_app/Profile%20Orders%20Page/Profile/widgets/edit_password_dialog_body.dart';
import 'package:flutter/material.dart';

class EditDialogBody extends StatelessWidget {
  const EditDialogBody({super.key, required this.pass});
  final String pass;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 340,
        height: 265,
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
        child: Column(
          spacing: 10,
          children: [
            const Text(
              "Edit",
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontWeight: FontWeight.w500,
              ),
            ),
            EditButton(
              text: 'Name',
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return const EditNameDialogBody();
                  },
                );
              },
            ),
            EditButton(
              text: 'Email',
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return EditEmailDialogBody(pass: pass);
                  },
                );
              },
            ),
            EditButton(text: 'Password', onTap: () {showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return EditPasswordDialogBody(pass: pass);
                  },
                );}),
          ],
        ),
      ),
    );
  }
}
