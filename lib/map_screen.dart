import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';
import 'constant.dart';
import 'flutter/flutter_icon_button.dart';
import 'flutter/flutter_theme.dart';
import 'flutter/flutter_widgets.dart';
import 'flutter/internationalization.dart';

typedef void CallBackFunction(String, Lat, long,lat2,long2,lat3,long3);

class PriceCalculationLocation extends StatefulWidget {
  final CallBackFunction callback;
  PriceCalculationLocation({required this.callback});
  @override
  _PriceCalculationLocationState createState() => _PriceCalculationLocationState();
}

class _PriceCalculationLocationState extends State<PriceCalculationLocation> {
  String googleApikey = "AIzaSyDC3tem0TZwtIX1W4RhFiZasKwI2T8g34k";
  GoogleMapController? mapController; //controller for Google map
  CameraPosition? cameraPosition;
  // LatLng startLocation = LatLng(22.717807, 75.8780294);
  // LatLng startLocation = LatLng(22.7178507, 75.8780402);
  LatLng startLocation = LatLng(0, 0);
  String location = "Search Location";
  List<Marker> _markers = <Marker>[];
  bool _isVisible = false;
  dynamic latitude;
  dynamic longitude;
  dynamic latitude2;
  dynamic longitude2;
  dynamic latitude3;
  dynamic longitude3;
  bool _isVisiblenew = false;

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterTheme.of(context)
          .primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFF5C47A8),
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Select Address",
          style: FlutterTheme.of(context).headlineMedium.override(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body:_isVisiblenew==true?  Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 14.0,
            ),
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
            onCameraMove: (CameraPosition cameraPositiona) {
              cameraPosition = cameraPositiona;
            },
            onCameraIdle: () async {
              LatLng target = cameraPosition!.target;

              List<Placemark> placemarks = await placemarkFromCoordinates(
                target.latitude,
                target.longitude,
              );

              setState(() {
                location = placemarks.first.locality.toString()+
                    placemarks.first.street.toString() +
                    ", " +
                    placemarks.first.subLocality.toString() +
                    placemarks.first.administrativeArea.toString();
                print("=======location test=====${location}");
                print("=======location test1=====${placemarks}");

                // Now 'target' contains the LatLng of the changed/searched address
                latitude = target.latitude;
                longitude = target.longitude;
                latitude2 = target.latitude;
                longitude2 = target.longitude;
                latitude3 = target.latitude;
                longitude3 = target.longitude;
                print("=======Latitude=====$latitude");
                print("=======Longitude=====$longitude");
                print("=======droplatitude=====$latitude2");
                print("=======droplongitude=====$longitude2");
                print("=======droplongitude=====$latitude3");
                print("=======droplongitude=====$longitude3");
              });
            },
            markers: Set<Marker>.of(_markers),
          ),
          Positioned(
            top: 10,
            child: InkWell(
              onTap: () async {
                var place = await PlacesAutocomplete.show(
                  context: context,
                  apiKey: googleApikey,
                  mode: Mode.overlay,
                  types: [],
                  strictbounds: false,
                  // components: [Component(Component.country, 'in')],
                  onError: (err) {
                    print("error===>${err.errorMessage}");
                  },
                );

                if (place != null) {
                  setState(() {
                    location = place.description.toString();
                  });

                  final plist = GoogleMapsPlaces(
                    apiKey: googleApikey,
                    apiHeaders: await GoogleApiHeaders().getHeaders(),
                  );

                  String placeid = place.placeId ?? "0";
                  final detail = await plist.getDetailsByPlaceId(placeid);
                  final geometry = detail.result.geometry!;
                  final lat = geometry.location.lat;
                  final lang = geometry.location.lng;
                  var newlatlang = LatLng(lat, lang);

                  mapController?.animateCamera(CameraUpdate.newCameraPosition(
                      CameraPosition(target: newlatlang, zoom: 17)));
                  // _markers.add(
                  //   Marker(
                  //     markerId: MarkerId("1"),
                  //     position: LatLng(lat, lang),
                  //   ),
                  // );
                }
              },
              child:  Padding(
                padding: EdgeInsets.all(15),
                child: Card(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width - 40,
                    child: ListTile(
                      // leading:
                      //     Icon(Icons.location_on_outlined, color: Colors.red),
                      title: Text(
                        location,
                        style: TextStyle(fontSize: 18),
                      ),
                      // trailing: Icon(Icons.search),
                      dense: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 60,
            right: 60,
            child: FFButtonWidget(
              onPressed: () async {
                widget.callback(location, latitude, longitude,latitude2,longitude2,latitude3,longitude3);
                // print("=======droplatitude=====${droplatitude}");
                // print("=======droplongitude=====${droplongitude}");
                print("=======latitude=====${latitude}");
                print("=======longitude=====${longitude}");
                Helper.popScreen(context);
                // Navigator.pop(context, location);

                // Helper.moveToScreenwithPush(context, CreateADropOffPageWidget(size: widget.size, catergory: widget.catergory, quantity: widget.quantity, vehicle_type: widget.vehicle_type, drop_address: location, name: widget.name,
                //   email: widget.email, order_number: widget.order_number, notes: widget.notes, pickup_address: widget.pickup_address, pick_lat: widget.pick_lat,
                //   pick_long: widget.pick_long, drop_lat:latitude, drop_long: longitude, sender_number: widget.sender_number,));

                // context.pushNamed('CreateADropOffPage');
              },
              text: 'Select Address',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterTheme.of(context).black600,
                textStyle: FlutterTheme.of(context).titleSmall.override(
                  fontFamily: 'Montserrat',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterTheme.of(context).titleSmallFamily),
                ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          Positioned.fill(

            // top: MediaQuery.of(context).size.height / 2 - 12, // Assuming the icon size is 24x24
            // left: MediaQuery.of(context).size.width / 2 - 12,
            // right: MediaQuery.of(context).size.width / 2 - 12,
            // bottom: MediaQuery.of(context).size.height / 2 - 14,

              child: Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.location_on_sharp,size: 50,color: Colors.red,))),
          Helper.getProgressBarWhite(context, _isVisible)
        ],
      ):setProgress(true),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  void getCurrentLocation() async {
    print("========current location=======");
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          print('Location permission denied by user');
          return;
        }
      }

      final position = await Geolocator.getCurrentPosition();

      print('Current Position: ${position.latitude}, ${position.longitude}');

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      // if (startLocation == LatLng(0, 0)) {
      //
      // }

      setState(() {
        startLocation = LatLng(position.latitude, position.longitude);
        print("====startLocation=====${startLocation}");
        location = placemarks.first.street.toString() +
            ", " +
            placemarks.first.subLocality.toString() +
            placemarks.first.administrativeArea.toString();
        _isVisiblenew=true;
        setProgress(false);
        print("=====location======${location}");
      });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }

}
