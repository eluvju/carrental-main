import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter/flutter_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _UserId = prefs.getString('ff_UserId') ?? _UserId;
      country_code = prefs.getString('ff_countrycode') ?? country_code;

    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _UserId = '';
  String country_code = '';
  String get UserId => _UserId;
  String get Countrycode => country_code;
  set UserId(String _value) {
    _UserId = _value;
    prefs.setString('ff_UserId', _value);
  }
  set countrycode(String _value) {
    country_code = _value;
    prefs.setString('ff_countrycode', _value);
  }

  String _locationName = 'indore';
  String get locationName => _locationName;
  set locationName(String _value) {
    _locationName = _value;
  }

  LatLng? _latLog = LatLng(22.7195687, 75.8577258);
  LatLng? get latLog => _latLog;
  set latLog(LatLng? _value) {
    _latLog = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
