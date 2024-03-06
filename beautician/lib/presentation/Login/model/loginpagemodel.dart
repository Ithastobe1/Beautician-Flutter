import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  User? user;
  String? message;
  String? accessToken;
  String? tokenType;

  LoginModel(
      {this.status, this.user, this.message, this.accessToken, this.tokenType});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
   
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? userImageUrl;
  String? mobileWithCode;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.userImageUrl,
      this.mobileWithCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    userImageUrl = json['user_image_url'];
    mobileWithCode = json['mobile_with_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['user_image_url'] = userImageUrl;
    data['mobile_with_code'] = mobileWithCode;
    return data;
  }
}
