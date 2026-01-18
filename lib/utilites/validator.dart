import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';

void showToast(String toast) {
  Fluttertoast.showToast(
    msg: toast,
    gravity: ToastGravity.CENTER,
    backgroundColor: blackColor,
    textColor: whiteColor,
  );
}

String? NameField(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent!.isEmpty) {
    return 'Invalid User Name';
  }
  return null;
}

String? lastNameField(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent!.isEmpty) {
    return 'Invalid Last Name';
  }
  return null;
}

String? emailField(String? fieldContent) {
  String pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
  RegExp regExp = RegExp(pattern);

  if (fieldContent == null || fieldContent.isEmpty) {
    return "Invalid email";
  } else if (!regExp.hasMatch(fieldContent)) {
    return "Invalid email";
  }

  return null;
}

// String? emailField(String? fieldContent) { //<-- add String? as a return type
//   String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regExp = new RegExp(pattern);
//   if(fieldContent!.isEmpty) {
//     return "Invalid email";
//   }else if(fieldContent.isNotEmpty){
//     if(!regExp.hasMatch(fieldContent)){
//       return "Invalid email";
//     }
//   }
//   return null;
// }
String? phoneField(String? fieldContent) {
  //<-- add String? as a return type
  if (fieldContent!.isEmpty) {
    return 'Invalid Phone Number';
  }
  return null;
}

String? validateCurrentPassword(String? value) {
  if (value!.isEmpty) {
    return 'Invalid password';
  } else if (value.length < 6) {
    return "Password should be between 6-20 characters";
  } else {
    return null;
  }
}

String? oldPassValue;
String? validatePassword(String? value) {
  oldPassValue = value;
  if (value!.isEmpty) {
    return 'Invalid password';
  } else if (value.length < 6) {
    return "Password should be between 6-20 characters";
  } else {
    return null;
  }
}

String? validateRepeatPassword(String? value) {
  if (value!.isEmpty) {
    return 'Invalid password';
  } else if (value.length < 6) {
    return "Password should be between 6-20 characters";
  } else if (!value.contains(oldPassValue.toString())) {
    return "Password not matched";
  } else {
    return null;
  }
}
