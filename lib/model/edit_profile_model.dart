class EditProfileModelNew {
  bool? response;
  String? message;
  Data? data;

  EditProfileModelNew({this.response, this.message, this.data});

  EditProfileModelNew.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? email;
  String? contact;
  String? image;

  Data({this.userId, this.userName, this.email, this.contact, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    email = json['email'];
    contact = json['contact'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['image'] = this.image;
    return data;
  }
}
