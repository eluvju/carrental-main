import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:car_rental/backend/api_requests/api_constants.dart';

import '../cloud_functions/cloud_functions.dart';

import '/flutter/flutter_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'carRentalApis';

/// Start BaseUrl Group Code

class BaseUrlGroup {
  static LoginCall loginCall = LoginCall();
  static RegisterCall registerCall = RegisterCall();
  static CarsCall carsCall = CarsCall();
  static CategoryCall categoryCall = CategoryCall();
  static CarDetailCall carDetailCall = CarDetailCall();
  static BookingCall bookingCall = BookingCall();
  static UsercurrentBookingCall usercurrentBookingCall =
      UsercurrentBookingCall();
  static UserhistoryBookingCall userhistoryBookingCall =
      UserhistoryBookingCall();
  static GetProfileCall getProfileCall = GetProfileCall();
  static UpdateUserProfileCall updateUserProfileCall = UpdateUserProfileCall();
  static ChangePasswordCall changePasswordCall = ChangePasswordCall();
  static AddfavouriteCall addfavouriteCall = AddfavouriteCall();
  static UnfavouriteCall unfavouriteCall = UnfavouriteCall();
  static FavouritlistCall favouritlistCall = FavouritlistCall();
  static BookingdetailCall bookingdetailCall = BookingdetailCall();
  static CancelledCall cancelledCall = CancelledCall();
  static AcceptCall acceptCall = AcceptCall();
  static PickupCall pickupCall = PickupCall();
  static CompleteCall completeCall = CompleteCall();
  static LogoutCall logoutCall = LogoutCall();
  static LocationCall locationCall = LocationCall();
  static DeleteaccountCall deleteaccountCall = DeleteaccountCall();
  static NeedhelpCall needhelpCall = NeedhelpCall();
  static SearchCall searchCall = SearchCall();
  static RatingCall ratingCall = RatingCall();
  static BrandCall brandCall = BrandCall();
  static DriverPriceCall driverPriceCall = DriverPriceCall();
}

class LoginCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? deviceType = '',
    String? deviceToken = '',
    String? login_type = '',
  }) async {
    // final result = await makeCloudCall(callName, input);
    final response = await makeCloudCall(
      ApiAction.login,
      {
        ApiConstantsKey.kcode: ApiCode.kcode,
        ApiConstantsKey.kemail: email,
        ApiConstantsKey.kpassword: password,
        ApiConstantsKey.kdeviceType: deviceType,
        ApiConstantsKey.kdeviceToken: deviceToken,
        ApiConstantsKey.klogintype: login_type,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
    // print("=======")
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic userid(dynamic response) => getJsonField(
        response,
        r'''$.data.user_id''',
      );
  dynamic country_code(dynamic response) => getJsonField(
    response,
    r'''$.data.country_code''',
  );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class RegisterCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? password = '',
    String? deviceType = '',
    String? deviceToken = '',
    String? userName = '',
    String? contact = '',
    String? country_code = '',

  }) async {
    final response = await makeCloudCall(
      ApiAction.registration,
      {
        ApiConstantsKey.kcode: ApiCode.kcode,
        ApiConstantsKey.kemail: email,
        ApiConstantsKey.kpassword: password,
        ApiConstantsKey.kdeviceType: deviceType,
        ApiConstantsKey.kdeviceToken: deviceToken,
        ApiConstantsKey.kusername: userName,
        ApiConstantsKey.kuserType: "1",
        ApiConstantsKey.kcontact: contact,
        ApiConstantsKey.kcountry_code: country_code,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic userid(dynamic response) => getJsonField(
        response,
        r'''$.data.user_id''',
      );
  dynamic country_code(dynamic response) => getJsonField(
    response,
    r'''$.data.country_code''',
  );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class CarsCall {
  Future<ApiCallResponse> call({
    String? categoryType = '',
    String? priceType = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.cars,
      {
        'category_type': categoryType,
        'price_type': priceType,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic carData(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class CategoryCall {
  Future<ApiCallResponse> call() async {
    final response = await makeCloudCall(
      ApiAction.category,
      {
        'callName': 'CategoryCall',
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic carCategoryData(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class CarDetailCall {
  Future<ApiCallResponse> call({
    String? carId = '',
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.car_detail,
      {
        'car_id': carId,
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic username(dynamic response) => getJsonField(
        response,
        r'''$.data.user_name''',
      );
  dynamic carName(dynamic response) => getJsonField(
        response,
        r'''$.data.car_name''',
      );
  dynamic brandname(dynamic response) => getJsonField(
    response,
    r'''$.data.brand_name''',
  );
  dynamic seat_capacity(dynamic response) => getJsonField(
    response,
    r'''$.data.seat_capacity''',
  );
  dynamic carMenufacture(dynamic response) => getJsonField(
        response,
        r'''$.data.car_manufacturer''',
      );
  dynamic pick_lat1(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_lat1''',
  );
  dynamic pick_long1(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_long1''',
  );
  dynamic pick_lat2(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_lat2''',
  );
  dynamic pick_long2(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_long2''',
  );
  dynamic carmake(dynamic response) => getJsonField(
        response,
        r'''$.data.car_make''',
      );

  dynamic carcolor(dynamic response) => getJsonField(
        response,
        r'''$.data.car_colour''',
      );
  dynamic carSeat(dynamic response) => getJsonField(
        response,
        r'''$.data.car_seat''',
      );
  dynamic airbooking(dynamic response) => getJsonField(
    response,
    r'''$.data.air_booking''',
  );
  dynamic automatictransmission(dynamic response) => getJsonField(
    response,
    r'''$.data.automatic_transmission''',
  );
  dynamic pick_address1(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_address1''',
  );
  dynamic pick_address2(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_address2''',
  );
  dynamic pick_address3(dynamic response) => getJsonField(
    response,
    r'''$.data.pick_address3''',
  );
  dynamic specification(dynamic response) => getJsonField(
    response,
    r'''$.data.specification''',
  );
  dynamic safetyraring(dynamic response) => getJsonField(
    response,
    r'''$.data.safety_raring''',
  );
  dynamic carImage(dynamic response) => getJsonField(
        response,
        r'''$.data.car_image[:].image''',
    // r'''$.car_image[0].image''',
      );

  dynamic carDocument(dynamic response) => getJsonField(
        response,
        r'''$.data.car_document''',
      );
  dynamic city(dynamic response) => getJsonField(
        response,
        r'''$.data.city''',
      );
  dynamic description(dynamic response) => getJsonField(
        response,
        r'''$.data.description''',
      );
  dynamic address(dynamic response) => getJsonField(
        response,
        r'''$.data.address''',
      );
  dynamic carCost(dynamic response) => getJsonField(
        response,
        r'''$.data.car_cost''',
      );
  dynamic lat(dynamic response) => getJsonField(
        response,
        r'''$.data.lat''',
      );
  dynamic long(dynamic response) => getJsonField(
        response,
        r'''$.data.lon''',
      );
  dynamic fulyType(dynamic response) => getJsonField(
        response,
        r'''$.data.fuly_type''',
      );
  dynamic totalRating(dynamic response) => getJsonField(
        response,
        r'''$.data.total_rating''',
      );
  dynamic rating(dynamic response) => getJsonField(
        response,
        r'''$.data.rating''',
      );
  dynamic carId(dynamic response) => getJsonField(
        response,
        r'''$.data.car_id''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.data.status''',
      );
  dynamic pricetype(dynamic response) => getJsonField(
        response,
        r'''$.data.price_type''',
      );
  dynamic supplierid(dynamic response) => getJsonField(
    response,
    r'''$.data.supplier_id''',
  );

}

class BookingCall {
  Future<ApiCallResponse> call({
    String? carId = '',
    String? taxes = '',
    String? userId = '',
    String? userName = '',
    String? contact = '',
    String? address = '',
    String? endDate = '',
    String? tripCost = '',
    String? startDate = '',
    String? driverType = '',
    String? licenceFront = '',
    String? licenceBack = '',
    String? priceType = '',
    String? dropOffAddress = '',
    String? supplierid = '',
  }) async {
    final response = await makeCreateBookingApiCall(
        ApiAction.booking, licenceBack ?? '', licenceFront ?? '', {
      'car_id': carId,
      'taxes': taxes,
      'user_id': userId,
      'user_name': userName,
      'contact': contact,
      'address': address,
      'end_date': endDate,
      'trip_cost': tripCost,
      'start_date': startDate,
      'driver_type': driverType,
      'licence_front': licenceFront,
      'licence_back': licenceBack,
      'price_type': priceType,
      'drop_off_address': dropOffAddress,
      'supplier_id': supplierid,

    });
    // final response = await makeCloudCall(
    //   ApiAction.booking,
    //   {

    //   },
    // );

    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class UsercurrentBookingCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.usercurrentBooking,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic dataList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class UserhistoryBookingCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.userhistoryBooking,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic dataHistory(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class GetProfileCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.profile,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic userId(dynamic response) => getJsonField(
        response,
        r'''$.profileData.user_id''',
      );
  dynamic userName(dynamic response) => getJsonField(
        response,
        r'''$.profileData.user_name''',
      );
  dynamic email(dynamic response) => getJsonField(
        response,
        r'''$.profileData.email''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic contact(dynamic response) => getJsonField(
        response,
        r'''$.profileData.contact''',
      );
  dynamic userProfileUrl(dynamic response) => getJsonField(
        response,
        r'''$.profileData.user_profile_pic''',
      );
}

class UpdateUserProfileCall {
  Future<ApiCallResponse> call({
    String? userName = '',
    String? userId = '',
    String? email = '',
    String? contact = '',
    String? image = '',
  }) async {
    // final response = await makeCloudCall(
    //   ApiAction.update_User_Profile,
    //   {
    //     'user_name': userName,
    //     'user_id': userId,
    //     'email': email,
    //     'contact': contact,
    //     'image': image,
    //   },
    // );
    final response =
        await makeEditProfile(ApiAction.update_User_Profile, image ?? "", {
      'user_name': userName,
      'user_id': userId,
      'email': email,
      'contact': contact,
    });

    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class ChangePasswordCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? oldPassword = '',
    String? newPassword = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.changePassword,
      {
        'user_id': userId,
        'old_password': oldPassword,
        'new_password': newPassword,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic userid(dynamic response) => getJsonField(
        response,
        r'''$.user_id''',
      );
  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
}

class AddfavouriteCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? carId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Add_favourite,
      {
        'user_id': userId,
        'car_id': carId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class UnfavouriteCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? carId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Unfavourite,
      {
        'user_id': userId,
        'car_id': carId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class FavouritlistCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.favouritlist,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic favouriteList(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic carid(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_id''',
      );
  dynamic carName(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_name''',
      );
  dynamic priceType(dynamic response) => getJsonField(
        response,
        r'''$.data[:].price_type''',
      );
  dynamic carManufacture(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_manufacturer''',
      );
  dynamic carMake(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_make''',
      );
  dynamic carColor(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_colour''',
      );
  dynamic carImage(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_image''',
      );
  dynamic carSeat(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_seat''',
      );
  dynamic city(dynamic response) => getJsonField(
        response,
        r'''$.data[:].city''',
      );
  dynamic lat(dynamic response) => getJsonField(
        response,
        r'''$.data[:].lat''',
      );
  dynamic long(dynamic response) => getJsonField(
        response,
        r'''$.data[:].long''',
      );
  dynamic address(dynamic response) => getJsonField(
        response,
        r'''$.data[:].address''',
      );
  dynamic vehicleCategory(dynamic response) => getJsonField(
        response,
        r'''$.data[:].vehicle_category''',
      );
  dynamic carCost(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_cost''',
      );
  dynamic carInsurance(dynamic response) => getJsonField(
        response,
        r'''$.data[:].car_insurance''',
      );
  dynamic driverAge(dynamic response) => getJsonField(
        response,
        r'''$.data[:].driver_age''',
      );
  dynamic withDelivery(dynamic response) => getJsonField(
        response,
        r'''$.data[:].with_delivery''',
      );
  dynamic rating(dynamic response) => getJsonField(
        response,
        r'''$.data[:].rating''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class BookingdetailCall {
  Future<ApiCallResponse> call({
    String? bookingId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.bookingdetail,
      {
        'booking_id': bookingId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  dynamic bookingId(dynamic response) => getJsonField(
        response,
        r'''$.data.booking_id''',
      );
  dynamic userid(dynamic response) => getJsonField(
        response,
        r'''$.data.user_id''',
      );
  dynamic supplierid(dynamic response) => getJsonField(
        response,
        r'''$.data.supplier_id''',
      );
  dynamic carid(dynamic response) => getJsonField(
        response,
        r'''$.data.car_id''',
      );
  dynamic rate(dynamic response) => getJsonField(
    response,
    r'''$.data.rate''',
  );
  dynamic address(dynamic response) => getJsonField(
        response,
        r'''$.data.address''',
      );
  dynamic startdate(dynamic response) => getJsonField(
        response,
        r'''$.data.start_date''',
      );
  dynamic endData(dynamic response) => getJsonField(
        response,
        r'''$.data.end_date''',
      );
  dynamic driverType(dynamic response) => getJsonField(
        response,
        r'''$.data.driver_type''',
      );
  dynamic rentedusername(dynamic response) => getJsonField(
        response,
        r'''$.data.rented_user_name''',
      );
  dynamic contact(dynamic response) => getJsonField(
        response,
        r'''$.data.contact''',
      );
  dynamic taxes(dynamic response) => getJsonField(
        response,
        r'''$.data.taxes''',
      );
  dynamic tripeCost(dynamic response) => getJsonField(
        response,
        r'''$.data.trip_cost''',
      );
  dynamic status(dynamic response) => getJsonField(
        response,
        r'''$.data.status''',
      );
  dynamic createdate(dynamic response) => getJsonField(
        response,
        r'''$.data.created_date''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic carImage(dynamic response) => getJsonField(
        response,
        // r'''$.data.car_image''',
      r'''$.data.car_image[:].image''',

      );
  dynamic withDeluvery(dynamic response) => getJsonField(
        response,
        r'''$.data.with_delivery''',
      );
  dynamic carSeat(dynamic response) => getJsonField(
        response,
        r'''$.data.car_seat''',
      );
  dynamic drivername(dynamic response) => getJsonField(
    response,
    r'''$.data.driver_name''',
  );
  dynamic drivercontact(dynamic response) => getJsonField(
    response,
    r'''$.data.driver_contact''',
  );
  dynamic driver_country_code(dynamic response) => getJsonField(
    response,
    r'''$.data.driver_country_code''',
  );
  dynamic user_country_code(dynamic response) => getJsonField(
    response,
    r'''$.data.user_country_code''',
  );
  dynamic carCost(dynamic response) => getJsonField(
        response,
        r'''$.data.car_cost''',
      );
  dynamic long(dynamic response) => getJsonField(
        response,
        r'''$.data.long''',
      );
  dynamic lat(dynamic response) => getJsonField(
        response,
        r'''$.data.lat''',
      );
  dynamic carName(dynamic response) => getJsonField(
        response,
        r'''$.data.car_name''',
      );
  dynamic carManufacture(dynamic response) => getJsonField(
        response,
        r'''$.data.car_manufacturer''',
      );
  dynamic carMake(dynamic response) => getJsonField(
        response,
        r'''$.data.car_make''',
      );
  dynamic carColor(dynamic response) => getJsonField(
        response,
        r'''$.data.car_colour''',
      );
  dynamic pricetype(dynamic response) => getJsonField(
        response,
        r'''$.data.price_type''',
      );
  dynamic description(dynamic response) => getJsonField(
        response,
        r'''$.data.description''',
      );
  dynamic rating(dynamic response) => getJsonField(
        response,
        r'''$.data.rating''',
      );
  dynamic dropOffAddress(dynamic response) => getJsonField(
        response,
        r'''$.data.drop_off_address''',
      );
  dynamic licencefront(dynamic response) => getJsonField(
    response,
    r'''$.data.licence_front''',
  );
  dynamic licenceback(dynamic response) => getJsonField(
    response,
    r'''$.data.licence_back''',
  );
  dynamic automatic_transmission(dynamic response) => getJsonField(
    response,
    r'''$.data.automatic_transmission''',
  );
  dynamic safety_raring(dynamic response) => getJsonField(
    response,
    r'''$.data.safety_raring''',
  );
  dynamic air_booking(dynamic response) => getJsonField(
    response,
    r'''$.data.air_booking''',
  );
  dynamic specification(dynamic response) => getJsonField(
    response,
    r'''$.data.specification''',
  );
}


class CancelledCall {
  Future<ApiCallResponse> call({
    String? bookingId = '',
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Cancelled,
      {
        'booking_id': bookingId,
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class AcceptCall {
  Future<ApiCallResponse> call({
    String? bookingId = '',
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Accept,
      {
        'booking_id': bookingId,
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class PickupCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? bookingId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Pickup,
      {
        'user_id': userId,
        'booking_id': bookingId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class CompleteCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? bookingId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.Complete,
      {
        'user_id': userId,
        'booking_id': bookingId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class LogoutCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.logout,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class LocationCall {
  Future<ApiCallResponse> call({
    String? carId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.location,
      {
        'car_id': carId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic locationsList(dynamic response) {
    List<dynamic> addressList = [];

    List<dynamic> pickAddress1List = getJsonField(response, r'''$.data[:].pick_address1''', true);
    List<dynamic> pickAddress2List = getJsonField(response, r'''$.data[:].pick_address2''', true);
    List<dynamic> pickAddress3List = getJsonField(response, r'''$.data[:].pick_address3''', true);

    addressList.addAll(pickAddress1List);
    addressList.addAll(pickAddress2List);
    addressList.addAll(pickAddress3List);

    return addressList;
  }


  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class DeleteaccountCall {
  Future<ApiCallResponse> call({
    String? userId = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.delete_account,
      {
        'user_id': userId,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }
}

class NeedhelpCall {
  Future<ApiCallResponse> call({
    String? email = '',
    String? userName = '',
    String? contact = '',
    String? message = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.need_help,
      {
        'email': email,
        'user_name': userName,
        'contact': contact,
        'message': message,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class SearchCall {
  Future<ApiCallResponse> call({
    String? lat = '',
    String? vehicleCategory = '',
    String? brand = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.search_car,
      {
        'lat': lat,
        'vehicle_category': vehicleCategory,
        'brand': brand,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
}

class RatingCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? carId = '',
    String? rate = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.rating,
      {
        'user_id': userId,
        'car_id': carId,
        'rate': rate,
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class BrandCall {
  Future<ApiCallResponse> call({
    String? appToken = 'booking12345',
  }) async {
    final response = await makeCloudCall(
      ApiAction.brand,
      {},
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic data(dynamic response) => getJsonField(
        response,
        r'''$.data''',
        true,
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
  dynamic brandName(dynamic response) => getJsonField(
        response,
        r'''$.data[:].brand_name''',
        true,
      );
}

class DriverPriceCall {
  Future<ApiCallResponse> call({
    String? appToken = '',
  }) async {
    final response = await makeCloudCall(
      ApiAction.driverPrice,
      {},
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.response''',
      );
  dynamic price(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

/// End BaseUrl Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
