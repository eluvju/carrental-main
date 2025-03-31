class CatergorywiseCar {
  String? response;
  List<Data>? data;
  String? message;

  CatergorywiseCar({this.response, this.data, this.message});

  CatergorywiseCar.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response'] = this.response;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? carId;
  String? carName;
  String? carColour;
  String? carMake;
  String? carManufacturer;
  String? userName;
  String? userimage;
  String? rating;
  String? carImage;
  String? carSeat;
  String? brandName;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? city;
  String? carInsurance;
  String? withDelivery;
  String? carCost;
  String? driverAge;
  String? priceType;
  String? pickLat1;
  String? pickLat2;
  String? pickLat3;
  String? pickLong1;
  String? pickLong2;
  String? pickLong3;
  String? pickAddress1;
  String? pickAddress2;
  String? pickAddress3;
  String? vehicleCategory;
  String? favStatus;
  String? specification;
  String? description;
  String? createdDate;

  Data(
      {this.carId,
        this.carName,
        this.carColour,
        this.carMake,
        this.carManufacturer,
        this.userName,
        this.userimage,
        this.rating,
        this.carImage,
        this.carSeat,
        this.brandName,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.city,
        this.carInsurance,
        this.withDelivery,
        this.carCost,
        this.driverAge,
        this.priceType,
        this.pickLat1,
        this.pickLat2,
        this.pickLat3,
        this.pickLong1,
        this.pickLong2,
        this.pickLong3,
        this.pickAddress1,
        this.pickAddress2,
        this.pickAddress3,
        this.vehicleCategory,
        this.favStatus,
        this.specification,
        this.description,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carName = json['car_name'];
    carColour = json['car_colour'];
    carMake = json['car_make'];
    rating = json['rating'];
    carManufacturer = json['car_manufacturer'];
    userName = json['user_name'];
    userimage = json['userimage'];
    carImage = json['car_image'];
    carSeat = json['car_seat'];
    brandName = json['brand_name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    city = json['city'];
    carInsurance = json['car_insurance'];
    withDelivery = json['with_delivery'];
    carCost = json['car_cost'];
    driverAge = json['driver_age'];
    priceType = json['price_type'];
    pickLat1 = json['pick_lat1'];
    pickLat2 = json['pick_lat2'];
    pickLat3 = json['pick_lat3'];
    pickLong1 = json['pick_long1'];
    pickLong2 = json['pick_long2'];
    pickLong3 = json['pick_long3'];
    pickAddress1 = json['pick_address1'];
    pickAddress2 = json['pick_address2'];
    pickAddress3 = json['pick_address3'];
    vehicleCategory = json['vehicle_category'];
    favStatus = json['fav_status'];
    specification = json['specification'];
    description = json['description'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['car_name'] = this.carName;
    data['car_colour'] = this.carColour;
    data['rating'] = this.rating;
    data['car_make'] = this.carMake;
    data['car_manufacturer'] = this.carManufacturer;
    data['user_name'] = this.userName;
    data['userimage'] = this.userimage;
    data['car_image'] = this.carImage;
    data['car_seat'] = this.carSeat;
    data['brand_name'] = this.brandName;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['city'] = this.city;
    data['car_insurance'] = this.carInsurance;
    data['with_delivery'] = this.withDelivery;
    data['car_cost'] = this.carCost;
    data['driver_age'] = this.driverAge;
    data['price_type'] = this.priceType;
    data['pick_lat1'] = this.pickLat1;
    data['pick_lat2'] = this.pickLat2;
    data['pick_lat3'] = this.pickLat3;
    data['pick_long1'] = this.pickLong1;
    data['pick_long2'] = this.pickLong2;
    data['pick_long3'] = this.pickLong3;
    data['pick_address1'] = this.pickAddress1;
    data['pick_address2'] = this.pickAddress2;
    data['pick_address3'] = this.pickAddress3;
    data['vehicle_category'] = this.vehicleCategory;
    data['fav_status'] = this.favStatus;
    data['specification'] = this.specification;
    data['description'] = this.description;
    data['created_date'] = this.createdDate;
    return data;
  }
}
