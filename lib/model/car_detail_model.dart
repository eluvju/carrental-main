class CarDetailsModel {
  bool? response;
  Data? data;
  String? message;

  CarDetailsModel({this.response, this.data, this.message});

  CarDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? carType;
  String? userProfile;
  String? carNumber;
  String? brandName;
  String? vehicle_category;
  String? carSeat;
  String? rating;
  String? supplierId;
  String? priceType;
  String? lat;
  String? lon;
  String? fulyType;
  int? totalRating;
  String? userName;
  String? carId;
  String? carName;
  String? carManufacturer;
  String? carMake;
  String? carColour;
  String? seatCapacity;
  List<CarImage>? carImage;
  String? city;
  String? description;
  String? address;
  String? pickLat1;
  String? pickLat2;
  String? pickLat3;
  String? pickLong1;
  String? pickLong2;
  String? pickLong3;
  String? pickAddress1;
  String? pickAddress2;
  String? pickAddress3;
  String? airBooking;
  String? specification;
  String? automaticTransmission;
  String? safetyRaring;
  String? carCost;
  String? status;

  Data(
      {this.carType,
        this.userProfile,
        this.carNumber,
        this.brandName,
        this.carSeat,
        this.rating,
        this.supplierId,
        this.priceType,
        this.lat,
        this.lon,
        this.fulyType,
        this.vehicle_category,
        this.totalRating,
        this.userName,
        this.carId,
        this.carName,
        this.carManufacturer,
        this.carMake,
        this.carColour,
        this.seatCapacity,
        this.carImage,
        this.city,
        this.description,
        this.address,
        this.pickLat1,
        this.pickLat2,
        this.pickLat3,
        this.pickLong1,
        this.pickLong2,
        this.pickLong3,
        this.pickAddress1,
        this.pickAddress2,
        this.pickAddress3,
        this.airBooking,
        this.specification,
        this.automaticTransmission,
        this.safetyRaring,
        this.carCost,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    carType = json['car_type'];
    userProfile = json['user_profile'];
    carNumber = json['car_number'];
    brandName = json['brand_name'];
    vehicle_category = json['vehicle_category'];
    carSeat = json['car_seat'];
    rating = json['rating'];
    supplierId = json['supplier_id'];
    priceType = json['price_type'];
    lat = json['lat'];
    lon = json['lon'];
    fulyType = json['fuly_type'];
    totalRating = json['total_rating'];
    userName = json['user_name'];
    carId = json['car_id'];
    carName = json['car_name'];
    carManufacturer = json['car_manufacturer'];
    carMake = json['car_make'];
    carColour = json['car_colour'];
    seatCapacity = json['seat_capacity'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    city = json['city'];
    description = json['description'];
    address = json['address'];
    pickLat1 = json['pick_lat1'];
    pickLat2 = json['pick_lat2'];
    pickLat3 = json['pick_lat3'];
    pickLong1 = json['pick_long1'];
    pickLong2 = json['pick_long2'];
    pickLong3 = json['pick_long3'];
    pickAddress1 = json['pick_address1'];
    pickAddress2 = json['pick_address2'];
    pickAddress3 = json['pick_address3'];
    airBooking = json['air_booking'];
    specification = json['specification'];
    automaticTransmission = json['automatic_transmission'];
    safetyRaring = json['safety_raring'];
    carCost = json['car_cost'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_type'] = this.carType;
    data['user_profile'] = this.userProfile;
    data['car_number'] = this.carNumber;
    data['brand_name'] = this.brandName;
    data['vehicle_category'] = this.vehicle_category;
    data['car_seat'] = this.carSeat;
    data['rating'] = this.rating;
    data['supplier_id'] = this.supplierId;
    data['price_type'] = this.priceType;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['fuly_type'] = this.fulyType;
    data['total_rating'] = this.totalRating;
    data['user_name'] = this.userName;
    data['car_id'] = this.carId;
    data['car_name'] = this.carName;
    data['car_manufacturer'] = this.carManufacturer;
    data['car_make'] = this.carMake;
    data['car_colour'] = this.carColour;
    data['seat_capacity'] = this.seatCapacity;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    data['city'] = this.city;
    data['description'] = this.description;
    data['address'] = this.address;
    data['pick_lat1'] = this.pickLat1;
    data['pick_lat2'] = this.pickLat2;
    data['pick_lat3'] = this.pickLat3;
    data['pick_long1'] = this.pickLong1;
    data['pick_long2'] = this.pickLong2;
    data['pick_long3'] = this.pickLong3;
    data['pick_address1'] = this.pickAddress1;
    data['pick_address2'] = this.pickAddress2;
    data['pick_address3'] = this.pickAddress3;
    data['air_booking'] = this.airBooking;
    data['specification'] = this.specification;
    data['automatic_transmission'] = this.automaticTransmission;
    data['safety_raring'] = this.safetyRaring;
    data['car_cost'] = this.carCost;
    data['status'] = this.status;
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
