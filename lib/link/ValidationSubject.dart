class FormValidatorSubject {
  String? validateSubject(String value) {
    if (value.isEmpty) {
      return 'Please enter a username';
    }
    return null;
  }

  String? validateEMark(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    return null;
  }
}