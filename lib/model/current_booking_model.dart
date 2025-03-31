class CurrentBooking {
  bool? response;
  List<Data>? data;
  String? message;

  CurrentBooking({this.response, this.data, this.message});

  CurrentBooking.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? supplierId;
  String? email;
  String? contact;
  String? userName;
  String? image;
  String? supplierEmail;
  String? supplierContact;
  String? supplierUserName;
  String? supplierImage;
  String? carId;
  String? favStatus;
  String? rating;
  String? carName;
  String? vehicleCategory;
  String? carSeat;
  String? carColour;
  String? seatCapacity;
  List<CarImage>? carImage;
  String? pickLat1;
  String? pickLat2;
  String? pickLat3;
  String? pickLong1;
  String? pickLong2;
  String? pickLong3;
  String? carCost;
  String? description;
  String? specification;
  String? brandName;
  String? address;
  String? bookingId;
  String? priceType;
  String? status;
  String? startDate;
  String? endDate;
  String? taxes;
  String? tripCost;
  String? createdDate;

  Data(
      {this.userId,
        this.supplierId,
        this.email,
        this.contact,
        this.userName,
        this.image,
        this.supplierEmail,
        this.supplierContact,
        this.supplierUserName,
        this.supplierImage,
        this.carId,
        this.favStatus,
        this.rating,
        this.carName,
        this.vehicleCategory,
        this.carSeat,
        this.carColour,
        this.seatCapacity,
        this.carImage,
        this.pickLat1,
        this.pickLat2,
        this.pickLat3,
        this.pickLong1,
        this.pickLong2,
        this.pickLong3,
        this.carCost,
        this.description,
        this.specification,
        this.brandName,
        this.address,
        this.bookingId,
        this.priceType,
        this.status,
        this.startDate,
        this.endDate,
        this.taxes,
        this.tripCost,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    supplierId = json['supplier_id'];
    email = json['email'];
    contact = json['contact'];
    userName = json['user_name'];
    image = json['image'];
    supplierEmail = json['supplier_email'];
    supplierContact = json['supplier_contact'];
    supplierUserName = json['supplier_user_name'];
    supplierImage = json['supplier_image'];
    carId = json['car_id'];
    favStatus = json['fav_status'];
    rating = json['rating'];
    carName = json['car_name'];
    vehicleCategory = json['vehicle_category'];
    carSeat = json['car_seat'];
    carColour = json['car_colour'];
    seatCapacity = json['seat_capacity'];
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
    carCost = json['car_cost'];
    description = json['description'];
    specification = json['specification'];
    brandName = json['brand_name'];
    address = json['address'];
    bookingId = json['booking_id'];
    priceType = json['price_type'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    taxes = json['taxes'];
    tripCost = json['trip_cost'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['supplier_id'] = this.supplierId;
    data['email'] = this.email;
    data['contact'] = this.contact;
    data['user_name'] = this.userName;
    data['image'] = this.image;
    data['supplier_email'] = this.supplierEmail;
    data['supplier_contact'] = this.supplierContact;
    data['supplier_user_name'] = this.supplierUserName;
    data['supplier_image'] = this.supplierImage;
    data['car_id'] = this.carId;
    data['fav_status'] = this.favStatus;
    data['rating'] = this.rating;
    data['car_name'] = this.carName;
    data['vehicle_category'] = this.vehicleCategory;
    data['car_seat'] = this.carSeat;
    data['car_colour'] = this.carColour;
    data['seat_capacity'] = this.seatCapacity;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    data['pick_lat1'] = this.pickLat1;
    data['pick_lat2'] = this.pickLat2;
    data['pick_lat3'] = this.pickLat3;
    data['pick_long1'] = this.pickLong1;
    data['pick_long2'] = this.pickLong2;
    data['pick_long3'] = this.pickLong3;
    data['car_cost'] = this.carCost;
    data['description'] = this.description;
    data['specification'] = this.specification;
    data['brand_name'] = this.brandName;
    data['address'] = this.address;
    data['booking_id'] = this.bookingId;
    data['price_type'] = this.priceType;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['taxes'] = this.taxes;
    data['trip_cost'] = this.tripCost;
    data['created_date'] = this.createdDate;
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
