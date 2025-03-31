class AvailableCarFilter {
  bool? response;
  List<Data>? data;
  String? message;

  AvailableCarFilter({this.response, this.data, this.message});

  AvailableCarFilter.fromJson(Map<String, dynamic> json) {
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
  String? vehicleCategory;
  List<CarImage>? carImage;
  String? pickLat1;
  String? pickLat2;
  String? pickLat3;
  String? pickLong1;
  String? pickLong2;
  String? pickLong3;
  String? pickAddress1;
  String? pickAddress2;
  String? pickAddress3;
  String? carCost;
  String? priceType;
  String? carName;
  String? carColour;
  String? carMake;
  String? carManufacturer;
  String? carSeat;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? city;
  String? supplierId;
  String? lat;
  String? long;
  String? address;
  String? carInsurance;
  String? withDelivery;
  String? driverAge;
  String? createdDate;
  String? airBooking;
  String? description;

  Data(
      {this.carId,
        this.rating,
        this.vehicleCategory,
        this.carImage,
        this.pickLat1,
        this.pickLat2,
        this.pickLat3,
        this.pickLong1,
        this.pickLong2,
        this.pickLong3,
        this.pickAddress1,
        this.pickAddress2,
        this.pickAddress3,
        this.carCost,
        this.priceType,
        this.carName,
        this.carColour,
        this.carMake,
        this.carManufacturer,
        this.carSeat,
        this.startDate,
        this.endDate,
        this.startTime,
        this.endTime,
        this.city,
        this.supplierId,
        this.lat,
        this.long,
        this.address,
        this.carInsurance,
        this.withDelivery,
        this.driverAge,
        this.createdDate,
        this.airBooking,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    rating = json['rating'];
    vehicleCategory = json['vehicle_category'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    pickLat1 = json['pick_lat1'];
    pickLat2 = json['pick_lat2'];
    pickLat3 = json['pick_lat3'];
    pickLong1 = json['pick_long1'];
    pickLong2 = json['pick_long2'];
    pickLong3 = json['pick_long3'];
    pickAddress1 = json['pick_address1'];
    pickAddress2 = json['pick_address2'];
    pickAddress3 = json['pick_address3'];
    carCost = json['car_cost'];
    priceType = json['price_type'];
    carName = json['car_name'];
    carColour = json['car_colour'];
    carMake = json['car_make'];
    carManufacturer = json['car_manufacturer'];
    carSeat = json['car_seat'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    city = json['city'];
    supplierId = json['supplier_id'];
    lat = json['lat'];
    long = json['long'];
    address = json['address'];
    carInsurance = json['car_insurance'];
    withDelivery = json['with_delivery'];
    driverAge = json['driver_age'];
    createdDate = json['created_date'];
    airBooking = json['air_booking'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['rating'] = this.rating;
    data['vehicle_category'] = this.vehicleCategory;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    data['pick_lat1'] = this.pickLat1;
    data['pick_lat2'] = this.pickLat2;
    data['pick_lat3'] = this.pickLat3;
    data['pick_long1'] = this.pickLong1;
    data['pick_long2'] = this.pickLong2;
    data['pick_long3'] = this.pickLong3;
    data['pick_address1'] = this.pickAddress1;
    data['pick_address2'] = this.pickAddress2;
    data['pick_address3'] = this.pickAddress3;
    data['car_cost'] = this.carCost;
    data['price_type'] = this.priceType;
    data['car_name'] = this.carName;
    data['car_colour'] = this.carColour;
    data['car_make'] = this.carMake;
    data['car_manufacturer'] = this.carManufacturer;
    data['car_seat'] = this.carSeat;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['city'] = this.city;
    data['supplier_id'] = this.supplierId;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['address'] = this.address;
    data['car_insurance'] = this.carInsurance;
    data['with_delivery'] = this.withDelivery;
    data['driver_age'] = this.driverAge;
    data['created_date'] = this.createdDate;
    data['air_booking'] = this.airBooking;
    data['description'] = this.description;
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
