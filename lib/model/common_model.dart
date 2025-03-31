class CommonModel {
  String? response;
  String? message;

  CommonModel({this.response, this.message});

  CommonModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    data['message'] = this.message;
    return data;
  }
}
