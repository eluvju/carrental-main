import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import 'app_state.dart';
import 'constant.dart';
import 'flutter/flutter_util.dart';
import 'flutter/nav/nav.dart';
import 'onbording_screen_first.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({Key? key}) : super(key: key);

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}


class _SpashScreenState extends State<SpashScreen> {
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 5000));
      // await Future.delayed(const Duration(minutes: 60));
      FFAppState().UserId != ''?   context.goNamed(
        'HomePage',
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
            duration: Duration(milliseconds: 0),
          ),
        },
      ):
      Helper.moveToScreenwithPush(context, OnboardingScreen());
      // SessionHelper sessionHelper = await SessionHelper.getInstance(context);
      // var userId = sessionHelper.get(SessionHelper.USER_ID);
      // var user_type = sessionHelper.get(SessionHelper.USERTYPE);
      //
      // if (userId == null||userId =="0") {
      //   context.pushNamed('WelcomePage');
      // }
      // else if(user_type=="2"){
      //
      //   Helper.moveToScreenwithPush(context, FindGigsClass());
      //   // context.pushNamed(
      //   //   'CruzerHomePage',
      //   //   extra: <String, dynamic>{
      //   //     kTransitionInfoKey: TransitionInfo(
      //   //       hasTransition: true,
      //   //       transitionType: PageTransitionType.fade,
      //   //       duration: Duration(milliseconds: 0),
      //   //     ),
      //   //   },
      //   // );
      // }
      // else {
      //   context.pushNamed(
      //     'UserHomePage',
      //     extra: <String, dynamic>{
      //       kTransitionInfoKey: TransitionInfo(
      //         hasTransition: true,
      //         transitionType: PageTransitionType.fade,
      //         duration: Duration(milliseconds: 0),
      //       ),
      //     },
      //   );
      // }

    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  'assets/images/splash-min.jpg',
                  fit: BoxFit.cover,
                )),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xff553FA5).withOpacity(0.75),
            ),
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                     'assets/images/car_rental.svg',
              ),
            ),
          ],
        ),
      ),
    );
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

      // Set global latitude and longitude
      globalLatitude = position.latitude;
      globalLongitude = position.longitude;

      SessionHelper sessionHelper = await SessionHelper.getInstance(context);
      sessionHelper.put(SessionHelper.LATITUDE,position.latitude.toString());
      sessionHelper.put(SessionHelper.LONGITUDE,  position.longitude.toString());


      print('Current Position: ${globalLatitude}, ${globalLongitude}');

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        startLocation = LatLng(position.latitude, position.longitude);
        print("====startLocation=====${startLocation}");

        // location = placemarks.first.street.toString() +
        //     ", " +
        //     placemarks.first.subLocality.toString() +
        //     ", " +
        //     placemarks.first.administrativeArea.toString();
        // _isVisiblenew = true;
        // setProgress(false);
        // print("=====location======${location}");
      });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }
}
