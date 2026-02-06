class LoginValidators {
  static String? emailValidator(String? email) {
    final RegExp regExp = RegExp(
        r"^[\w.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z]{2,}$");
    if (email == null || email.isEmpty) {
      return 'Email is required!';
    } else if (!regExp.hasMatch(email.trim())) {
      return 'Email is invalid!';
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'Password is required';
    } else if (name.length < 6) {
      return 'Minimum 6 characters are required!';
    } else {
      return null;
    }
  }

  static String? phoneValidator(String? phone) {
    final RegExp regExp = RegExp(r'^[0-9]{10}$');
    // Now requires exactly 10 digits
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required!';
    } else if (!regExp.hasMatch(phone.trim())) {
      return 'Phone number must be exactly 10 digits!';
    } else {
      return null;
    }
  }

  static String? nameValidator(String? name, String field) {
    if (name == null || name.isEmpty) {
      return '$field is required';
    } else {
      return null;
    }
  }
}
