import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

class EmailService {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseFunctions functions = FirebaseFunctions.instance;

  static EmailOTP myauth = EmailOTP();

  static Future<bool> sendOTPWithPackage({
    required String email,
    VoidCallback? triggerLoading,
  }) async {
    try {
      triggerLoading?.call();
      myauth.setConfig(
        appEmail: "ArvoSupport@gmail.com",
        appName: "Arvo",
        userEmail: email,
        otpLength: 6,
        otpType: OTPType.digitsOnly,
      );
      bool result = await myauth.sendOTP();
      return result;
    } catch (e) {
      print('Error sending OTP with package: $e');
      return false;
    }
  }

  static Future<bool> verifyOTPWithPackage(
    String otp, {
    required VoidCallback triggerLoading,
  }) async {
    try {
      triggerLoading();
      bool result = await myauth.verifyOTP(otp: otp);
      return result;
    } catch (e) {
      return false;
    }
  }
}
