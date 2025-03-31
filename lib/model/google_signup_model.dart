class SignupGoogle {
  String? result;
  String? error;
  String? message;
  Data? data;

  SignupGoogle({this.result, this.error, this.message, this.data});

  SignupGoogle.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    error = json['error'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  String? firstname;
  String? lastname;
  String? email;
  String? userType;
  String? profileImage;
  String? deviceToken;

  Data(
      {this.userId,
        this.firstname,
        this.lastname,
        this.email,
        this.userType,
        this.profileImage,
        this.deviceToken});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    userType = json['user_type'];
    profileImage = json['profile_image'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['user_type'] = this.userType;
    data['profile_image'] = this.profileImage;
    data['device_token'] = this.deviceToken;
    return data;
  }
}
