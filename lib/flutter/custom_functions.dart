import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/auth/firebase_auth/auth_util.dart';

String latLongConverString(LatLng latLongs) {
  // latLng to convet to string
// latLng to convert to string
// Starter code
  return '${latLongs.latitude},${latLongs.longitude}';
}

double? addTwoNumber(
  double? firstNumber,
  double? sendNumber,
) {
  // add two number
// Starter code
  if (firstNumber == null || sendNumber == null) {
    return null;
  }
  return firstNumber + sendNumber;
}

double? multiplayData(
  double? firstNumber,
  double? sencondNumber,
) {
  if (firstNumber == null || sencondNumber == null) {
    return null;
  }
  double result = firstNumber * sencondNumber;
  return result;
}

int? getDaysNumbers(
  DateTime? startDate,
  DateTime? endDate,
) {
  // how to start date and end Date get days
  if (startDate == null || endDate == null) {
    return 2;
  }
  final difference = endDate.difference(startDate);
  return difference.inDays + 1;
}

double? getHoursAndMinutes(
  DateTime? startTime,
  DateTime? endtime,
) {
  // how to get hours and mins start time and end time
  if (startTime == null || endtime == null) {
    return null;
  }
  final difference = endtime.difference(startTime);
  final hours = difference.inHours;
  final minutes = difference.inMinutes.remainder(60);
  return double.parse('$hours.$minutes');
}

double? newstringToDouble(String? firstNumber) {
  // string to double convert
// string to double convert
// Starter code
  if (firstNumber == null) {
    return null;
  }
  return double.tryParse(firstNumber);
}
