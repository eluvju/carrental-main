class PromocodeApplied {
  String? result;
  String? message;
  String? fare;
  String? discount;

  PromocodeApplied({this.result, this.message, this.fare, this.discount});

  PromocodeApplied.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    fare = json['fare'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    data['fare'] = this.fare;
    data['discount'] = this.discount;
    return data;
  }
}
