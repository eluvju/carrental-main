class FavListModel {
  bool? response;
  List<Data>? data;
  String? message;

  FavListModel({this.response, this.data, this.message});

  FavListModel.fromJson(Map<String, dynamic> json) {
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
  String? rating;
  List<CarImage>? carImage;
  String? carName;
  String? priceType;
  String? carManufacturer;
  String? carMake;
  String? carColour;
  String? carSeat;
  String? city;
  String? vehicleCategory;
  String? carCost;
  String? carInsurance;
  String? driverAge;
  String? withDelivery;
  String? pickAddress1;
  String? pickAddress2;
  String? pickAddress3;
  String? pickLat1;
  String? pickLat2;
  String? pickLat3;
  String? pickLong1;
  String? pickLong2;
  String? pickLong3;
  String? favStatus;
  String? brandName;
  String? specification;

  Data(
      {this.carId,
        this.rating,
        this.carImage,
        this.carName,
        this.priceType,
        this.carManufacturer,
        this.carMake,
        this.carColour,
        this.carSeat,
        this.city,
        this.vehicleCategory,
        this.carCost,
        this.carInsurance,
        this.driverAge,
        this.withDelivery,
        this.pickAddress1,
        this.pickAddress2,
        this.pickAddress3,
        this.pickLat1,
        this.pickLat2,
        this.pickLat3,
        this.pickLong1,
        this.pickLong2,
        this.pickLong3,
        this.favStatus,
        this.brandName,
        this.specification});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    rating = json['rating'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    carName = json['car_name'];
    priceType = json['price_type'];
    carManufacturer = json['car_manufacturer'];
    carMake = json['car_make'];
    carColour = json['car_colour'];
    carSeat = json['car_seat'];
    city = json['city'];
    vehicleCategory = json['vehicle_category'];
    carCost = json['car_cost'];
    carInsurance = json['car_insurance'];
    driverAge = json['driver_age'];
    withDelivery = json['with_delivery'];
    pickAddress1 = json['pick_address1'];
    pickAddress2 = json['pick_address2'];
    pickAddress3 = json['pick_address3'];
    pickLat1 = json['pick_lat1'];
    pickLat2 = json['pick_lat2'];
    pickLat3 = json['pick_lat3'];
    pickLong1 = json['pick_long1'];
    pickLong2 = json['pick_long2'];
    pickLong3 = json['pick_long3'];
    favStatus = json['fav_status'];
    brandName = json['brand_name'];
    specification = json['specification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['rating'] = this.rating;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    data['car_name'] = this.carName;
    data['price_type'] = this.priceType;
    data['car_manufacturer'] = this.carManufacturer;
    data['car_make'] = this.carMake;
    data['car_colour'] = this.carColour;
    data['car_seat'] = this.carSeat;
    data['city'] = this.city;
    data['vehicle_category'] = this.vehicleCategory;
    data['car_cost'] = this.carCost;
    data['car_insurance'] = this.carInsurance;
    data['driver_age'] = this.driverAge;
    data['with_delivery'] = this.withDelivery;
    data['pick_address1'] = this.pickAddress1;
    data['pick_address2'] = this.pickAddress2;
    data['pick_address3'] = this.pickAddress3;
    data['pick_lat1'] = this.pickLat1;
    data['pick_lat2'] = this.pickLat2;
    data['pick_lat3'] = this.pickLat3;
    data['pick_long1'] = this.pickLong1;
    data['pick_long2'] = this.pickLong2;
    data['pick_long3'] = this.pickLong3;
    data['fav_status'] = this.favStatus;
    data['brand_name'] = this.brandName;
    data['specification'] = this.specification;
    return data;
  }
}

class CarImage {
  String? id;
  String? carId;
  String? image;
  String? createdAt;

  CarImage({this.id, this.carId, this.image, this.createdAt});

  CarImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carId = json['car_id'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_id'] = this.carId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    return data;
  }
}
