import 'package:http/http.dart' as http;
import '../api_requests/api_constants.dart';

Future<http.Response> makeCloudCall(
  String callName,
  Map<String, dynamic> input,
) async {
  String url = BaseURl.url + callName;
  var request = http.MultipartRequest('POST', Uri.parse(url));

  if (input is Map) {
    input.forEach((key, value) {
      request.fields[key] = value;
    });
  }
  request.fields[ApiConstantsKey.kcode] = ApiCode.kcode;
  var response = await request.send();

  final result = await http.Response.fromStream(response);
  if (result.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(result.body);
    // final jsonData = jsonDecode(result.body);
    return result;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<http.Response> makeEditProfile(
  String callName,
  String profileUrls,
  Map<String, dynamic> input,
) async {
  String url = BaseURl.url + callName;
  var request = http.MultipartRequest('POST', Uri.parse(url));

  if (input is Map) {
    input.forEach((key, value) {
      request.fields[key] = value;
    });
  }
  var pic =
      await http.MultipartFile.fromPath(ApiConstantsKey.kimage, profileUrls);
  request.files.add(pic);
  request.fields[ApiConstantsKey.kcode] = ApiCode.kcode;
  var response = await request.send();

  final result = await http.Response.fromStream(response);
  if (result.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(result.body);
    // final jsonData = jsonDecode(result.body);
    return result;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<http.Response> makeCreateBookingApiCall(
  String callName,
  String backlicenseImage,
  String forntlicenseImage,
  Map<String, dynamic> input,
) async {
  String url = BaseURl.url + callName;
  var request = http.MultipartRequest('POST', Uri.parse(url));

  if (input is Map) {
    input.forEach((key, value) {
      request.fields[key] = value;
    });
  }
  var backlicenseImages = await http.MultipartFile.fromPath(
      ApiConstantsKey.klicenceImageBack, backlicenseImage);
  request.files.add(backlicenseImages);

  var forntlicenseImages = await http.MultipartFile.fromPath(
      ApiConstantsKey.klicenceImageFront, forntlicenseImage);
  request.files.add(forntlicenseImages);

  request.fields[ApiConstantsKey.kcode] = ApiCode.kcode;
  var response = await request.send();

  final result = await http.Response.fromStream(response);
  print("=======license=======${result.body}");
  if (result.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(result.body);
    // final jsonData = jsonDecode(result.body);
    return result;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
