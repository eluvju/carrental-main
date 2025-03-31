class GoogleSignInModel {
  String? result;
  String? requestKey;
  Data? data;
  String? message;

  GoogleSignInModel({this.result, this.requestKey, this.data, this.message});

  GoogleSignInModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    requestKey = json['requestKey'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['requestKey'] = this.requestKey;
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
  String? contact;
  String? gender;
  String? userType;
  String? countryCode;
  String? socialType;
  String? userName;
  String? verifystatus;
  String? userProfilePic;

  Data(
      {this.email,
        this.userId,
        this.otp,
        this.contact,
        this.gender,
        this.userType,
        this.countryCode,
        this.socialType,
        this.userName,
        this.verifystatus,
        this.userProfilePic});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userId = json['user_id'];
    otp = json['otp'];
    contact = json['contact'];
    gender = json['gender'];
    userType = json['user_type'];
    countryCode = json['country_code'];
    socialType = json['social_type'];
    userName = json['user_name'];
    verifystatus = json['verifystatus'];
    userProfilePic = json['user_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['otp'] = this.otp;
    data['contact'] = this.contact;
    data['gender'] = this.gender;
    data['user_type'] = this.userType;
    data['country_code'] = this.countryCode;
    data['social_type'] = this.socialType;
    data['user_name'] = this.userName;
    data['verifystatus'] = this.verifystatus;
    data['user_profile_pic'] = this.userProfilePic;
    return data;
  }
}
