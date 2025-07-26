String? validateName(String? data) {
  if (data?.isEmpty ?? true) {
    return "This field is required";
  }
  bool isNotLetterOnly = !(data!.contains(RegExp(r'[a-zA-Z]+$')));
  if (isNotLetterOnly) {
    return "Name must contain letters only";
  }
  return null;
}

String? validateEmail(String? data) {
  if (data?.isEmpty ?? true) {
    return "This field is required";
  }
  bool isNotValidEmail = !(data!.contains("@") && data.contains("."));
  if (isNotValidEmail) {
    return "Invalid Email format";
  }
  return null;
}

String? validatePassword(String? data) {
  if (data?.isEmpty ?? true) {
    return "This field is required";
  }
  if (data!.length < 8) {
    return "Password must be at least 8 characters";
  }
  if (!data.contains(RegExp(r'[A-Z]'))) {
    return "Password must contain at least one uppercase letter";
  }
  if (!data.contains(RegExp(r'[a-z]'))) {
    return "Password must contain at least one lowercase letter";
  }
  if (!data.contains(RegExp(r'[0-9]'))) {
    return "Password must contain at least one number";
  }
  if (!data.contains(RegExp(r'[!@#$&*%^]'))) {
    return "Password must contain at least one special character";
  }
  return null;
}

String? validateConfirmPassword(String? data, String? pass) {
  if (data?.isEmpty ?? true) {
    return "This field is required";
  }
  bool isNotPassCorrect = !(data == pass);
  if (isNotPassCorrect) {
    return "Passwords doesn't match";
  }
  return null;
}
