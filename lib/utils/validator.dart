class Validator {
  static String? cityNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter city name';
    }

    return null;
  }
}
