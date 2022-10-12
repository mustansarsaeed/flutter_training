class ValidationMixin {
  String? validatePassword(value) {
    if (value != null && value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  String? validateEmail(value) {
    return (value != null && value.contains("@")) ? null : "Enter valid email.";
  }
}
