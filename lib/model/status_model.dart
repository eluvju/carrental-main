class StatusModel {
  String? result;
  String? data;
  String? message;

  StatusModel({this.result, this.data, this.message});

  StatusModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = json['data'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
