class BookingDetailModel {
  String? response;
  Data? data;
  String? message;

  BookingDetailModel({this.response, this.data, this.message});

  BookingDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? supplierId;
  String? driverName;
  String? driverContact;
  String? licenceFront;
  String? licenceBack;
  String? carId;
  String? airBooking;
  String? specification;
  String? automaticTransmission;
  String? safetyRaring;
  String? carName;
  String? carColour;
  String? carCost;
  String? carMake;
  String? carManufacturer;
  String? seatCapacity;
  String? carSeat;
  String? carModelYear;
  String? rentHour;
  String? carType;
  String? vehicleType;
  String? carNumber;
  String? pickAddress1;
  String? pickAddress2;
  String? pickAddress3;
  String? createdDate;
  List<CarImage>? carImage;
  String? rating;
  String? priceType;
  String? description;
  String? address;
  String? bookingId;
  String? dropOffAddress;
  String? status;
  String? startDate;
  String? endDate;
  String? taxes;
  String? tripCost;

  Data(
      {this.userId,
        this.supplierId,
        this.driverName,
        this.driverContact,
        this.licenceFront,
        this.licenceBack,
        this.carId,
        this.airBooking,
        this.specification,
        this.automaticTransmission,
        this.safetyRaring,
        this.carName,
        this.carColour,
        this.carCost,
        this.carMake,
        this.carManufacturer,
        this.seatCapacity,
        this.carSeat,
        this.carModelYear,
        this.rentHour,
        this.carType,
        this.vehicleType,
        this.carNumber,
        this.pickAddress1,
        this.pickAddress2,
        this.pickAddress3,
        this.createdDate,
        this.carImage,
        this.rating,
        this.priceType,
        this.description,
        this.address,
        this.bookingId,
        this.dropOffAddress,
        this.status,
        this.startDate,
        this.endDate,
        this.taxes,
        this.tripCost});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    supplierId = json['supplier_id'];
    driverName = json['driver_name'];
    driverContact = json['driver_contact'];
    licenceFront = json['licence_front'];
    licenceBack = json['licence_back'];
    carId = json['car_id'];
    airBooking = json['air_booking'];
    specification = json['specification'];
    automaticTransmission = json['automatic_transmission'];
    safetyRaring = json['safety_raring'];
    carName = json['car_name'];
    carColour = json['car_colour'];
    carCost = json['car_cost'];
    carMake = json['car_make'];
    carManufacturer = json['car_manufacturer'];
    seatCapacity = json['seat_capacity'];
    carSeat = json['car_seat'];
    carModelYear = json['car_model_year'];
    rentHour = json['Rent_hour'];
    carType = json['car_type'];
    vehicleType = json['vehicle_type'];
    carNumber = json['car_number'];
    pickAddress1 = json['pick_address1'];
    pickAddress2 = json['pick_address2'];
    pickAddress3 = json['pick_address3'];
    createdDate = json['created_date'];
    if (json['car_image'] != null) {
      carImage = <CarImage>[];
      json['car_image'].forEach((v) {
        carImage!.add(new CarImage.fromJson(v));
      });
    }
    rating = json['rating'];
    priceType = json['price_type'];
    description = json['description'];
    address = json['address'];
    bookingId = json['booking_id'];
    dropOffAddress = json['drop_off_address'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    taxes = json['taxes'];
    tripCost = json['trip_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['supplier_id'] = this.supplierId;
    data['driver_name'] = this.driverName;
    data['driver_contact'] = this.driverContact;
    data['licence_front'] = this.licenceFront;
    data['licence_back'] = this.licenceBack;
    data['car_id'] = this.carId;
    data['air_booking'] = this.airBooking;
    data['specification'] = this.specification;
    data['automatic_transmission'] = this.automaticTransmission;
    data['safety_raring'] = this.safetyRaring;
    data['car_name'] = this.carName;
    data['car_colour'] = this.carColour;
    data['car_cost'] = this.carCost;
    data['car_make'] = this.carMake;
    data['car_manufacturer'] = this.carManufacturer;
    data['seat_capacity'] = this.seatCapacity;
    data['car_seat'] = this.carSeat;
    data['car_model_year'] = this.carModelYear;
    data['Rent_hour'] = this.rentHour;
    data['car_type'] = this.carType;
    data['vehicle_type'] = this.vehicleType;
    data['car_number'] = this.carNumber;
    data['pick_address1'] = this.pickAddress1;
    data['pick_address2'] = this.pickAddress2;
    data['pick_address3'] = this.pickAddress3;
    data['created_date'] = this.createdDate;
    if (this.carImage != null) {
      data['car_image'] = this.carImage!.map((v) => v.toJson()).toList();
    }
    data['rating'] = this.rating;
    data['price_type'] = this.priceType;
    data['description'] = this.description;
    data['address'] = this.address;
    data['booking_id'] = this.bookingId;
    data['drop_off_address'] = this.dropOffAddress;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['taxes'] = this.taxes;
    data['trip_cost'] = this.tripCost;
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
