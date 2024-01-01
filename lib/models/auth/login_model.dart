class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() {
    return{
      'email' : email,
      'password' : password
    };
  }
}

class LoginResponseModel {
  String? message;
  String? token;

  LoginResponseModel({this.message, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
    );
  }
}

class LogoutResponseModel {
  final String? message;

  LogoutResponseModel({this.message});

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) {
    return LogoutResponseModel(
      message: json['message'] ?? '',
    );
  }
}