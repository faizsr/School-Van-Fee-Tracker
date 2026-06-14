class Validator {
  static String? name(String? value) {
    if (value!.isEmpty) {
      return 'Required Field';
    }
    if (value.length < 3) {
      return 'Enter a valid name';
    }
    return null;
  }

  static String? required(String? value) {
    if (value!.isEmpty) {
      return 'Required Field';
    }
    if (value.length < 3) {
      return 'Invalid entry';
    }
    return null;
  }

  static String? phone(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Required field';
    }

    final phoneRegex = RegExp(
      r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)',
    );
    if (!phoneRegex.hasMatch(phone)) {
      return 'Enter a valid phone number';
    }

    return null;
  }
}
