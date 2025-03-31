class RegisterModel {
  bool? response;
  Data? data;
  String? message;

  RegisterModel({this.response, this.data, this.message});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? email;
  String? userId;
  String? otp;
  String? userType;
  String? password;
  String? userName;
  String? contact;

  Data(
      {this.email,
        this.userId,
        this.otp,
        this.userType,
        this.password,
        this.userName,
        this.contact});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['user_id'];
    otp = json['otp'];
    userType = json['user_type'];
    password = json['password'];
    userName = json['user_name'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['otp'] = this.otp;
    data['user_type'] = this.userType;
    data['password'] = this.password;
    data['user_name'] = this.userName;
    data['contact'] = this.contact;
    return data;
  }
}
