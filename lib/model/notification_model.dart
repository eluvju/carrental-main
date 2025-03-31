class NotificationModel {
  bool? response;
  String? message;
  List<Data>? data;

  NotificationModel({this.response, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? bookingId;
  String? startDate;
  String? endDate;
  String? address;
  String? profileImage;
  String? username;
  String? message;
  String? createdAt;

  Data(
      {this.bookingId,
        this.startDate,
        this.endDate,
        this.address,
        this.profileImage,
        this.username,
        this.message,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    address = json['address'];
    profileImage = json['profile_image'];
    username = json['username'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['booking_id'] = this.bookingId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['address'] = this.address;
    data['profile_image'] = this.profileImage;
    data['username'] = this.username;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}
