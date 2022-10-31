import 'dart:typed_data';

class Validation {
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static String? validateEmail(String? email) {
    if (email!.isEmpty || (!emailRegExp.hasMatch(email)) || email.length > 50) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validateLoginPassword(String? password) {
    bool ok = false;
    // for (int i = 0; i < password.length; i++) {
    //   if (password[i] >= 'A' && password[i] <= 'Z') {
    //     ok = true;
    //     break;
    //   }
    // }
    if (password!.isEmpty) {
      return "Password can't be empty";
    }

    return null;
  }

  static String? validateRegisterPassword(String? password) {
    bool okUpper = false;
    bool okNumber = false;
    var array = password!.split('');
    array.forEach((element) {
      int char = element.codeUnitAt(0);
      int A = 'A'.codeUnitAt(0);
      int Z = 'Z'.codeUnitAt(0);
      if (char >= A && char <= Z) {
        okUpper = true;
      }
      int zero = '0'.codeUnitAt(0);
      int nine = '9'.codeUnitAt(0);
      if (char >= zero && char <= nine) {
        okNumber = true;
      }
      print(element); // iterating char by char
    });
    if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 7) {
      return "Password is too short";
    } else if (!okNumber && !okUpper) {
      return "Password must have Capital letters and numbers";
    } else if (!okNumber) {
      return "Password must have numbers ";
    } else if (password.length > 50) {
      return "password is too long";
    }
    return null;
  }

  static String? validateRegisterFullName(String? fullName) {
    if (fullName!.length > 25) {
      return "Full Name is too long";
    }
    if (fullName.isEmpty) {
      return "Full Name can't be empty";
    }
    return null;
  }

  static String? validateProductTitle(String? title) {
    if (title!.isEmpty) {
      return "Title can't be empty";
    }
    if (title.length > 50) {
      return "Title too long";
    }
    return null;
  }

  static String? validateProductCategory(String? category) {
    if (category!.isEmpty) {
      return "Category can't be empty";
    }
    if (category.length > 24) {
      return "Category too long";
    }
    return null;
  }

  static String? validateRegisterPhoneNumber(String? phoneNumber) {
    if (phoneNumber!.length != 10 || !Validation.isNumeric(phoneNumber)) {
      return "Invalid phone number";
    }
    return null;
  }

  static String? validateNumericField(String? s) {
    if (s!.isEmpty || !Validation.isNumeric(s) || double.parse(s) > 100000000) {
      return "Invalid value";
    }
    return null;
  }

  static String? validateDate(String? s) {
    if (s!.isEmpty) {
      return "Date can't be empty";
    }
    return null;
  }

  static bool isNumeric(String? s) {
    return double.tryParse(s!) != null;
  }
}
