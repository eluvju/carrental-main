class AddFavourite {
  bool? response;
  Data? data;
  String? message;

  AddFavourite({this.response, this.data, this.message});

  AddFavourite.fromJson(Map<String, dynamic> json) {
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
  String? carId;
  String? userId;

  Data({this.carId, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['user_id'] = this.userId;
    return data;
  }
}
