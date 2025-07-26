String? validateEmptyData(String? data) {
  if (data?.isEmpty ?? true) {
    return "This field is required";
  }
  return null;
}
