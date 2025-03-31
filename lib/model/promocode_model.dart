class Promocode {
  String? result;
  String? message;
  List<Deliverydata>? deliverydata;

  Promocode({this.result, this.message, this.deliverydata});

  Promocode.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    message = json['message'];
    if (json['deliverydata'] != null) {
      deliverydata = <Deliverydata>[];
      json['deliverydata'].forEach((v) {
        deliverydata!.add(new Deliverydata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['message'] = this.message;
    if (this.deliverydata != null) {
      data['deliverydata'] = this.deliverydata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Deliverydata {
  String? sno;
  String? couponName;
  String? couponCode;
  String? image;
  String? maxCoupon;
  String? percentage;
  String? couponVaildF;
  String? couponVaildT;
  String? couponType;
  String? description;
  String? users;
  String? car;
  String? createdAt;

  Deliverydata(
      {this.sno,
        this.couponName,
        this.couponCode,
        this.image,
        this.maxCoupon,
        this.percentage,
        this.couponVaildF,
        this.couponVaildT,
        this.couponType,
        this.description,
        this.users,
        this.car,
        this.createdAt});

  Deliverydata.fromJson(Map<String, dynamic> json) {
    sno = json['sno'];
    couponName = json['coupon_name'];
    couponCode = json['coupon_code'];
    image = json['image'];
    maxCoupon = json['max_coupon'];
    percentage = json['percentage'];
    couponVaildF = json['coupon_vaild_f'];
    couponVaildT = json['coupon_vaild_t'];
    couponType = json['coupon_type'];
    description = json['description'];
    users = json['users'];
    car = json['car'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sno;
    data['coupon_name'] = this.couponName;
    data['coupon_code'] = this.couponCode;
    data['image'] = this.image;
    data['max_coupon'] = this.maxCoupon;
    data['percentage'] = this.percentage;
    data['coupon_vaild_f'] = this.couponVaildF;
    data['coupon_vaild_t'] = this.couponVaildT;
    data['coupon_type'] = this.couponType;
    data['description'] = this.description;
    data['users'] = this.users;
    data['car'] = this.car;
    data['created_at'] = this.createdAt;
    return data;
  }
}
