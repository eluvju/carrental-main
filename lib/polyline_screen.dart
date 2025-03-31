import 'dart:convert';
import 'dart:math' show cos, sqrt, asin;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'constant.dart';
import 'flutter/flutter_icon_button.dart';
import 'flutter/flutter_theme.dart';
import 'flutter/internationalization.dart';



class YourMapWidget extends StatefulWidget {
  dynamic pick_lat;
  dynamic pick_long;
  dynamic drop_lat;
  dynamic drop_long;


  YourMapWidget(
      {
        required this.pick_lat,
        required this.pick_long,
        required this.drop_lat,
        required this.drop_long,

      });
  @override
  _YourMapWidgetState createState() => _YourMapWidgetState();
}

class _YourMapWidgetState extends State<YourMapWidget> {
  GoogleMapController? _mapController;
  List<LatLng> _routeCoordinates = [];
  LatLng _pickupLocation = LatLng(22.7196, 75.8577); // Default pickup location
  LatLng _dropoffLocation = LatLng(22.9676, 76.0534);
  Uint8List? _pickupMarkerIcon;
  Uint8List? _dropoffMarkerIcon;
  // Default drop-off location
  bool _hasData = true;
  bool _isVisible = false;
  double? distance;
  String? time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('=======widget.pick_lat========${widget.pick_lat}');
    print('=======widget.pick_long========${widget.pick_long}');
    print('=======widget.drop_lat========${widget.drop_lat}');
    print('=======widget.drop_long========${widget.drop_long}');
    drawRoute(widget.pick_lat,widget.pick_long, widget.drop_lat, widget.drop_long);
    double haversineDistance =
    calculateDistance(widget.pick_lat, widget.pick_long, widget.drop_lat, widget.drop_long);
    print('Haversine distance between pickup and drop-off: $haversineDistance km');

    // Calculate distance using Google Maps Distance Matrix API
    getDistance(widget.pick_lat, widget.pick_long, widget.drop_lat, widget.drop_long)
        .then((value) {
      setState(() {
        distance = value['distance'];
        time = value['time'];
        print("Distance: $distance, Time: $time");
      });
    }).catchError((error) {
      print('Error: $error');
    });

  }

  Future<void> _loadMarkerIcons() async {
    print("========loadicon=====${_loadMarkerIcons()}");
    _pickupMarkerIcon = await _getMarkerIcon('assets/images/circle.png');
    _dropoffMarkerIcon = await _getMarkerIcon('assets/images/circle.png');
  }

  Future<Uint8List> _getMarkerIcon(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  @override
  Widget build(BuildContext context) {
    // double distance = calculateDistance(widget.pick_lat, widget.pick_long, widget.drop_lat, widget.drop_long);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Helper.popScreen(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0,top: 15,right: 0,bottom: 10),
            child: Image.asset('assets/images/back_icon_with_bg.png',height: 30,width: 30,),
          ),
        ),
        title: Text("Route Screen",
          // FFLocalizations.of(context).getText(
          //   'p6r3ar1p' /* More Filter */,
          // ),
          style: FlutterTheme.of(context).headlineMedium.override(
              fontFamily: 'Urbanist',
              color: FlutterTheme.of(context).primaryText,
              fontSize: 18.0,fontWeight: FontWeight.w600
          ),
        ),
        actions: [],
        centerTitle: false,
        // elevation: 2.0,
      ),

      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
                 zoomOutPolyline();
              },
              markers: {
                Marker(
                  onTap: () {
                  },
                  markerId: MarkerId('pickup'),
                  position: LatLng(widget.pick_lat, widget.pick_long),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                  // infoWindow: InfoWindow(title: widget.pickup_address),
                ),
                Marker(
                  onTap: () {
                  },
                  markerId: MarkerId('dropoff'),
                  position: LatLng(widget.drop_lat, widget.drop_long),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                  // infoWindow: InfoWindow(title: widget.drop_address),
                ),
              },
              polylines: {
                Polyline(
                  polylineId: PolylineId('route'),
                  color: Colors.blue,
                  points: _routeCoordinates,
                  width: 4,
                ),
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.pick_lat, widget.pick_long),
                zoom: 5,
              ),
            ),
          ),

        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     drawRoute(widget.pick_lat,widget.pick_long, widget.drop_lat, widget.drop_long);
      //   },
      //   child: Icon(Icons.directions),
      // ),
    );
  }

  Future<Map<String, dynamic>> getDistance(double lat1, double lon1, double lat2, double lon2) async {
    final apiKey = 'AIzaSyDC3tem0TZwtIX1W4RhFiZasKwI2T8g34k'; // Replace with your API key
    final origin = '$lat1,$lon1';
    final destination = '$lat2,$lon2';
    final url = 'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$origin&destinations=$destination&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final distanceText = data['rows'][0]['elements'][0]['distance']['text'];
      final timeText = data['rows'][0]['elements'][0]['duration']['text'];
      final distanceValue = double.tryParse(distanceText.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      return {'distance': distanceValue, 'time': timeText};
    } else {
      throw Exception('Failed to fetch distance and time');
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    final p = 0.017453292519943295; // Math.PI / 180
    final c = 0.5 - cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(c)); // 2 * R; R = 6371 km
  }












  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }


  void drawRoute(double pickupLatitude, double pickupLongitude, double dropoffLatitude, double dropoffLongitude) async {
    _routeCoordinates.clear(); // Clear previous route

    final origin = '$pickupLatitude,$pickupLongitude';
    final destination = '$dropoffLatitude,$dropoffLongitude';

    final apiKey = 'AIzaSyDC3tem0TZwtIX1W4RhFiZasKwI2T8g34k'; // Replace with your actual Google Maps API key
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&mode=driving&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final routes = json['routes'];

        if (routes != null && routes.isNotEmpty) {
          final route = routes[0];
          final overviewPolyline = route['overview_polyline'];
          final points = overviewPolyline['points'];

          if (points != null) {
            List<LatLng> decodedRoute = decodePolyline(points);

            setState(() {
              _routeCoordinates = decodedRoute;
            });

            // Fit map bounds to show the entire route
            LatLngBounds bounds = boundsFromLatLngList(decodedRoute);
            _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
          } else {
            // Handle no points in the polyline
            print("No points in the polyline");
          }
        } else {
          // Handle no route found
          print("No route found");
        }
      } else {
        // Handle error response
        print("Error fetching route: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network or other exceptions
      print("Exception during route fetching: $e");
    }
  }

  void zoomOutPolyline() {
    if (_routeCoordinates.isEmpty || _mapController == null) return;

    double minLat = _routeCoordinates.first.latitude;
    double maxLat = _routeCoordinates.first.latitude;
    double minLng = _routeCoordinates.first.longitude;
    double maxLng = _routeCoordinates.first.longitude;

    // Finding the bounds of the polyline coordinates
    for (LatLng point in _routeCoordinates) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    // Creating LatLngBounds
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    // Zooming the camera to fit the bounds
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        50, // padding
      ),
    );
  }
}



List<LatLng> decodePolyline(String encoded) {
  List<LatLng> points = [];
  int index = 0;
  int len = encoded.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1F) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return points;
}

LatLngBounds boundsFromLatLngList(List<LatLng> list) {
  double minLat = list.first.latitude;
  double maxLat = list.first.latitude;
  double minLng = list.first.longitude;
  double maxLng = list.first.longitude;

  for (LatLng latLng in list) {
    if (latLng.latitude > maxLat) maxLat = latLng.latitude;
    if (latLng.latitude < minLat) minLat = latLng.latitude;
    if (latLng.longitude > maxLng) maxLng = latLng.longitude;
    if (latLng.longitude < minLng) minLng = latLng.longitude;
  }

  return LatLngBounds(
    southwest: LatLng(minLat, minLng),
    northeast: LatLng(maxLat, maxLng),
  );
}



