class FormValidator {
  String? validateUsername(String value) {
    if (value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length <8) {
      return 'the username less 8 characters';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    if (value.contains('@admin')) {
      return 'Please enter a valid email';
    }
    return null;
  }

 late String value2 = "";
  String? validatePassword(String value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password,';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password,Upper,Lower,Digit,Special character,Length';
      } else {
        value2 = value;
           return null;
      }
    }
  }
  String? validatePasswordAndRepeat(String value) {
         print(value2);
      if(value != value2){
        return "wrong password";
      }
      else{
        return null;
      }
  }
}
