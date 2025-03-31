class UserProfileModel {
  bool? response;
  ProfileData? profileData;
  String? message;

  UserProfileModel({this.response, this.profileData, this.message});

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    profileData = json['profileData'] != null
        ? new ProfileData.fromJson(json['profileData'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.profileData != null) {
      data['profileData'] = this.profileData!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class ProfileData {
  String? userId;
  String? userName;
  String? contact;
  String? country_code;
  String? email;
  String? userProfilePic;

  ProfileData(
      {this.userId,
        this.userName,
        this.contact,
        this.country_code,
        this.email,
        this.userProfilePic});

  ProfileData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    contact = json['contact'];
    country_code = json['country_code'];
    email = json['email'];
    userProfilePic = json['user_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['contact'] = this.contact;
    data['country_code'] = this.country_code;
    data['email'] = this.email;
    data['user_profile_pic'] = this.userProfilePic;
    return data;
  }
}
