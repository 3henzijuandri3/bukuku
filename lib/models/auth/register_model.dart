import 'package:bukuku/models/auth/user.dart';

class RegisterRequestModel {
  final String? name;
  final String? email;
  final String? password;
  final String? passwordConfirmation;

  RegisterRequestModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}

class RegisterResponseModel {
  final String? message;
  final UserModel? user;

  RegisterResponseModel({
    this.message,
    this.user,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}