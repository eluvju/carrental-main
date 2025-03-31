class AllCarsModel {
  bool? response;
  List<Data>? data;
  String? message;

  AllCarsModel({this.response, this.data, this.message});

  AllCarsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? userName;
  String? userimage;
  String? rating;
  String? carName;
  String? priceType;
  String? carManufacturer;
  String? carMake;
  String? carColour;
  String? carSeat;
  String? city;
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
  String? carCost;
  String? price;
  String? brandName;
  String? description;
  String? specification;
  String? rentHour;
  String? favStatus;
  String? carInsurance;
  String? driverAge;
  String? withDelivery;
  List<CarImage>? carImage;

  Data(
      {this.carId,
        this.userId,
        this.userName,
        this.userimage,
        this.rating,
        this.carName,
        this.priceType,
        this.carManufacturer,
        this.carMake,
        this.carColour,
        this.carSeat,
        this.city,
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
        this.carCost,
        this.price,
        this.brandName,
        this.description,
        this.specification,
        this.rentHour,
        this.favStatus,
        this.carInsurance,
        this.driverAge,
        this.withDelivery,
        this.carImage});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userimage = json['userimage'];
    rating = json['rating'];
    carName = json['car_name'];
    priceType = json['price_type'];
    carManufacturer = json['car_manufacturer'];
    carMake = json['car_make'];
    carColour = json['car_colour'];
    carSeat = json['car_seat'];
    city = json['city'];
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
    carCost = json['car_cost'];
    price = json['price'];
    brandName = json['brand_name'];
    description = json['description'];
    specification = json['specification'];
    rentHour = json['Rent_hour'];
    favStatus = json['fav_status'];
    carInsurance = json['car_insurance'];
    driverAge = json['driver_age'];
    withDelivery = json['with_delivery'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['userimage'] = this.userimage;
    data['rating'] = this.rating;
    data['car_name'] = this.carName;
    data['price_type'] = this.priceType;
    data['car_manufacturer'] = this.carManufacturer;
    data['car_make'] = this.carMake;
    data['car_colour'] = this.carColour;
    data['car_seat'] = this.carSeat;
    data['city'] = this.city;
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
    data['car_cost'] = this.carCost;
    data['price'] = this.price;
    data['brand_name'] = this.brandName;
    data['description'] = this.description;
    data['specification'] = this.specification;
    data['Rent_hour'] = this.rentHour;
    data['fav_status'] = this.favStatus;
    data['car_insurance'] = this.carInsurance;
    data['driver_age'] = this.driverAge;
    data['with_delivery'] = this.withDelivery;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
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
