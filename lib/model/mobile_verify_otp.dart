class MobileveriftModelotp {
  String? result;
  String? error;
  String? message;
  Data? data;

  MobileveriftModelotp({this.result, this.error, this.message, this.data});

  MobileveriftModelotp.fromJson(Map<String, dynamic> json) {
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
  String? verifystatus;
  String? userId;
  String? countryCode;
  String? username;
  String? email;
  String? contact;
  String? userType;
  String? vehicleType;

  Data(
      {this.verifystatus,
        this.userId,
        this.countryCode,
        this.username,
        this.email,
        this.contact,
        this.userType,
        this.vehicleType});

  Data.fromJson(Map<String, dynamic> json) {
    verifystatus = json['verifystatus'];
    userId = json['user_id'];
    countryCode = json['country_code'];
    username = json['username'];
    email = json['email'];
    contact = json['contact'];
    userType = json['user_type'];
    vehicleType = json['vehicle_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verifystatus'] = this.verifystatus;
    data['user_id'] = this.userId;
    data['country_code'] = this.countryCode;
    data['username'] = this.username;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['user_type'] = this.userType;
    data['vehicle_type'] = this.vehicleType;
    return data;
  }
}
