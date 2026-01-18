class UserModel {
  static final UserModel _userModel = UserModel._internal();
  factory UserModel() {
    return _userModel;
  }

  UserModel._internal();


  int? uid;
  String? token;
  String? tokenType;
  String? email;
  String? phoneNo;
  String? password;
  String? username;
  String? bio;
  String? gender;
  String? errorMessage;
  String? img;
  String? location;
  double? latitude;
  double? longitude;
  bool? success;
}
