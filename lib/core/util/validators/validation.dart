class MyValidator {
  // ✅ EMAIL
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp =
        RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$'); // ✅ correct regex

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address';
    }

    return null;
  }

  // ✅ PASSWORD
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Must contain at least one uppercase letter";
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Must contain at least one number";
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Must contain at least one special character";
    }

    return null;
  }

  // ✅ PHONE
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Enter valid 10-digit phone number';
    }

    return null;
  }

  // ✅ NAME
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  // ✅ USERNAME
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }

    return null;
  }
}