import 'dart:math';

import 'package:car_rental/constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '../../model/all_car_model.dart';
import '../../model/carcetegorywise_model.dart';
import '../../model/catergory_model.dart';
import '../../model/fav_model.dart';
import '../../model/profile_model.dart';
import '../../model/promocode_model.dart';
import '../../notificationservice/local_notification_service.dart';
import '../../promo_code_details/promo_code_detail_page/promo_code_detail_page_widget.dart';
import '../../sell_all_cars.dart';
import '../../view_all_promocode.dart';
import '../more_filter_page/more_filter_page_widget.dart';
import 'home_page_model.dart';

export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;
  List<String> eachCategoryList = [
    'All car',
    'suv',
    'seden',
    'coupe',
    'van',
  ];
  String selectedCategory = "All Cars";
  String isSelected = "All Cars";
  AddFavourite? _addFavourite;
  Promocode? _promocode;
  Map<String, String> eachCategoryWithImages = {
    'All car': 'assets/images/allcar.svg',
    'suv': 'assets/images/Fly.svg',
    'seden': 'assets/images/Fly-1.svg',
    'coupe': 'assets/images/Fly-2.svg',
    'van': 'assets/images/Fly-2.svg',
  };
  bool _hasData = true;
  bool _isVisible = false;
  AllCategoryModel? _allCategoryModel;
  AllCarsModel? _allCarsModel;
  CatergorywiseCar? _catergorywiseCar;
  UserProfileModel? _userProfileModel;
  bool isFavourite = false;
  double? distance;
  String? time;
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  String location = '';
  bool _isVisiblenew = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    // getCurrentLocation();
    print(
        "SessionHelper().get(SessionHelper.LATITUDE).toString()${SessionHelper().get(SessionHelper.LATITUDE).toString()}");
    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => NotificationPage( serviceId: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
      (message) {
        if (kDebugMode) {
          print("FirebaseMessaging.onMessage.listen");
        }
        if (message.notification != null) {
          if (kDebugMode) {
            // ToastMessage.msg(message.notification!.title.toString());
            print(message.notification!.title);
          }
          if (kDebugMode) {
            // ToastMessage.msg(message.notification!.title.toString());
            print(message.notification!.body);
          }
          if (kDebugMode) {
            // ToastMessage.msg(message.notification!.title.toString());
            print("message.data11 ${message.data}");
          }

          LocalNotificationService.createanddisplaynotification(message);
          setState(() {
            // noti_count++;
            // updateNotiCount(noti_count);
            // hasNewMessages = true;
          });
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          // ToastMessage.msg(message.notification!.title.toString());
          // ToastMessage.msg(message.data.toString());
          print("message.data22 ${message.data['_id']}");
          setState(() {
            // noti_count++;
            // updateNotiCount(noti_count);
            // hasNewMessages = true;
          });
        }
        LocalNotificationService.enableIOSNotifications();
      },
    );
    Helper.checkInternet(categoryapi());
    Helper.checkInternet(promocode());
    Helper.checkInternet(allcars());
    Helper.checkInternet(userdetailsApi());
  }

  void _onCategorySelected(String categoryName) {
    setState(() {
      isSelected = categoryName;
      if (categoryName == "All Cars") {
        Helper.checkInternet(allcars());
      } else {
        Helper.checkInternet(categorywiselist(categoryName));
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterTheme.of(context).primary,
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: FlutterTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            leading: _userProfileModel == null || _userProfileModel!.profileData!.userProfilePic.toString() == ""
                ? ClipOval(
                    child: Image.asset(
                      'assets/images/default_profile_image.png',
                      // BaseUrlGroup.getProfileCall
                      //     .userProfileUrl(
                      //       settingsPageGetProfileResponse
                      //           .jsonBody,
                      //     )
                      //     .toString(),
                      fit: BoxFit.cover,
                    ),
                  )
                : ClipOval(
                    child: Image.network(
                      _userProfileModel!.profileData!.userProfilePic.toString(),
                      // BaseUrlGroup.getProfileCall
                      //     .userProfileUrl(
                      //       settingsPageGetProfileResponse
                      //           .jsonBody,
                      //     )
                      //     .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
            title: _userProfileModel != null
                ? Text(
                    "Hey,${_userProfileModel!.profileData!.userName.toString()}",
                    style: FlutterTheme.of(context).bodyMedium.override(
                        fontFamily: 'Urbanist', fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0XFF000000)),
                  )
                : Text(
                    "Hey,User",
                    style: FlutterTheme.of(context).bodyMedium.override(
                        fontFamily: 'Urbanist', fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0XFF000000)),
                  ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Helper.moveToScreenwithPush(context, MoreFilterPageWidget());
                          },
                          child: Container(
                            width: 70,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Color(0xffFAF9FE),
                              border: Border.all(
                                color: FlutterTheme.of(context).plumpPurple,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SvgPicture.asset(
                                    'assets/images/filter.svg',
                                    height: 14,
                                    width: 13,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Filter",
                                    style: FlutterTheme.of(context).titleSmall.override(
                                          fontFamily: 'Urbanist',
                                          color: Color(0xff0D0C0F),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/images/notification_with_bg.svg',
                      width: 35,
                      height: 35,
                    ),
                  ],
                ),
              )
            ],
            centerTitle: false,
            // elevation: 2,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Stack(
                children: [
                  _allCategoryModel == null
                      ? _hasData
                          ? Container()
                          : Container(
                              child: Center(
                                child: Text("NO DATA"),
                              ),
                            )
                      : SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Container(
                                //   height: 100,
                                //   color: Colors.transparent,
                                //   child: ListView.builder(
                                //     padding: EdgeInsets.zero,
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: eachCategoryList.length,
                                //     itemBuilder: (context, eachCategoryListIndex) {
                                //       final category = eachCategoryList[eachCategoryListIndex];
                                //       final imagePath = eachCategoryWithImages[category];
                                //       bool isSelected = selectedCategory == category;
                                //       print("====isSelected===${isSelected}");
                                //       return Container(
                                //         height: 85,
                                //         width: 80,
                                //         color: Colors.transparent,
                                //         margin: EdgeInsets.only(right: 10),
                                //         child: InkWell(
                                //           onTap: () {
                                //             setState(() {
                                //               if (selectedCategory == category) {
                                //                 selectedCategory = null; // Unselect the category
                                //               } else {
                                //                 selectedCategory = category; // Select the category
                                //               }
                                //               // Additional logic if needed
                                //             });
                                //           },
                                //           splashColor: Colors.transparent, // Set splashColor to transparent
                                //           highlightColor: Colors.transparent, // Set highlightColor to transparent
                                //           child: Column(
                                //             children: [
                                //               imagePath != null
                                //                   ? Container(
                                //                 width: 80.42,
                                //                 height:60,
                                //                 decoration: BoxDecoration(
                                //                   borderRadius: BorderRadius.circular(8),
                                //                   border: Border.all(color: Color(0xffE8ECF4)),
                                //                   color:isSelected ? FlutterTheme.of(context).plumpPurple : Colors.white,
                                //                 ),
                                //                 child: Padding(
                                //                   padding: const EdgeInsets.all(12.0),
                                //                   child: SvgPicture.asset(
                                //                     imagePath,
                                //                     width: 30,
                                //                     height: 30,
                                //                   ),
                                //                 ),
                                //               )
                                //                   : Container(),
                                //               SizedBox(
                                //                 height: 10,
                                //               ),// Display nothing if image path is not available
                                //               Text(category, style: FlutterTheme.of(context)
                                //                   .bodyMedium
                                //                   .override(
                                //                 fontFamily: 'Urbanist',
                                //                 fontSize: 14.0,
                                //                 fontWeight: FontWeight.w600,color: Colors.black,
                                //               ),),
                                //             ],
                                //           ),
                                //         ),
                                //
                                //       );
                                //     },
                                //   ),
                                //
                                // ),

                                Container(
                                  height: 100,
                                  color: Colors.transparent,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _allCategoryModel!.data!.length,
                                    itemBuilder: (context, item) {
                                      final category = _allCategoryModel!.data![item];
                                      // final imagePath = eachCategoryWithImages[category];
                                      //  isSelected = _allCategoryModel!.data![item].categoryName;
                                      //  print("====isSelected ghjegej===${isSelected}");
                                      return InkWell(
                                        onTap: () {
                                          Helper.checkInternet(
                                              categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                          print("======helllooo=====");
                                          print(
                                              "======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                                        },
                                        child: Container(
                                          height: 85,
                                          width: 80,
                                          color: Colors.transparent,
                                          margin: EdgeInsets.only(right: 10),
                                          child: InkWell(
                                            onTap: () {
                                              // _onCategorySelected(category.categoryName!);
                                              if (_allCategoryModel!.data![item].categoryName.toString() ==
                                                  "All Cars") {
                                                _allCarsModel = null;
                                              } else {
                                                _catergorywiseCar = null;
                                              }
                                              _allCategoryModel!.data![item].categoryName.toString() == "All Cars"
                                                  ? Helper.checkInternet(allcars())
                                                  : Helper.checkInternet(categorywiselist(
                                                      _allCategoryModel!.data![item].categoryName.toString()));
                                              print("======helllooo=====");
                                              print(
                                                  "======category=====${_allCategoryModel!.data![item].categoryName.toString()}");
                                              setState(() {
                                                isSelected = _allCategoryModel!.data![item].categoryName.toString();
                                                print(
                                                    "====All Cars===${_allCategoryModel!.data![item].categoryName.toString()}");
                                                print("====All Cars isSelected===${isSelected}");
                                                // isSelected=="All Cars";
                                                // if (isSelected == category) {
                                                //   selectedCategory = null; // Unselect the category
                                                // } else {
                                                //   isSelected = category.toString(); // Select the category
                                                // }
                                                // Additional logic if needed
                                              });
                                            },
                                            splashColor: Colors.transparent, // Set splashColor to transparent
                                            highlightColor: Colors.transparent, // Set highlightColor to transparent
                                            child: Column(
                                              children: [
                                                // imagePath != null
                                                Container(
                                                  width: 80.42,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    border: Border.all(color: Color(0xffE8ECF4)),
                                                    color: isSelected ==
                                                            _allCategoryModel!.data![item].categoryName.toString()
                                                        ? FlutterTheme.of(context).plumpPurple
                                                        : Colors.white,
                                                  ),
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child:

                                                          //

                                                          Image.network(
                                                        _allCategoryModel!.data![item].categoryImage.toString(),
                                                        height: 50,
                                                        width: 70,
                                                        fit: BoxFit.contain,
                                                      )
                                                      // SvgPicture.asset(
                                                      //   _allCategoryModel!.data![item].categoryName.toString() == "Sedan"
                                                      //       ? 'assets/images/allcar.svg' // Display this image if category is Sedan
                                                      //       : _allCategoryModel!.data![item].categoryName.toString() == "Suv"
                                                      //       ? 'assets/images/Fly.svg'// Display this image if category is AnotherCategory
                                                      //       : 'assets/images/Fly-2.svg', // Display a default image if category is not matched
                                                      //   width: 30,
                                                      //   height: 30,
                                                      // ),
                                                      ),
                                                ),
                                                // : Container(),
                                                SizedBox(
                                                  height: 10,
                                                ), // Display nothing if image path is not available
                                                Container(
                                                  width: 60,
                                                  child: Text(
                                                    _allCategoryModel!.data![item].categoryName.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: FlutterTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Urbanist',
                                                          fontSize: 14.0,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                // Text(
                                //   _catergorywiseCar!.data!.length==null||_catergorywiseCar!.data!.length==0?"Available Cars in ${isSelected}":
                                //   "${_catergorywiseCar!.data!.length} Available Cars in ${isSelected}",
                                //   style: FlutterTheme.of(context)
                                //       .bodyMedium
                                //       .override(
                                //       fontFamily: 'Urbanist',
                                //       fontSize: 16.0,
                                //       fontWeight: FontWeight.w400,color: Color(0XFF000000)
                                //   ),
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                // isSelected=="All Cars"?Text("gdhgfhjvfr hiiiii"):Text("hellloooooo======="),

                                isSelected == "All Cars"
                                    ? (_allCarsModel == null || _allCarsModel!.data!.isEmpty
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Available Cars " + _allCarsModel!.data!.length.toString(),
                                                    style: FlutterTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0XFF0D0C0F)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Helper.moveToScreenwithPush(
                                                            context,
                                                            SeeAllCars(
                                                              isSelected: isSelected,
                                                              category: isSelected,
                                                            ));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "See All",
                                                            // FFLocalizations.of(context).getText(
                                                            //   'See All' /*See All*/,
                                                            // ),
                                                            style: FlutterTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Urbanist',
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: FlutterTheme.of(context).secondary,
                                                                ),
                                                          ),
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: FlutterTheme.of(context).secondary,
                                                            size: 16,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ))
                                    : (_catergorywiseCar == null || _catergorywiseCar!.data!.isEmpty
                                        ? SizedBox()
                                        : Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Available Cars " + _catergorywiseCar!.data!.length.toString(),
                                                    style: FlutterTheme.of(context).bodyMedium.override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Color(0XFF0D0C0F)),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(right: 5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Helper.moveToScreenwithPush(
                                                            context,
                                                            SeeAllCars(
                                                              isSelected: isSelected,
                                                              category: isSelected,
                                                            ));
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "See All",
                                                            // FFLocalizations.of(context).getText(
                                                            //   'See All' /*See All*/,
                                                            // ),
                                                            style: FlutterTheme.of(context).bodyMedium.override(
                                                                  fontFamily: 'Urbanist',
                                                                  fontSize: 17.0,
                                                                  fontWeight: FontWeight.w500,
                                                                  color: FlutterTheme.of(context).secondary,
                                                                ),
                                                          ),
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: FlutterTheme.of(context).secondary,
                                                            size: 16,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          )),

                                isSelected == "All Cars"
                                    ? (_allCarsModel == null || _allCarsModel!.data!.isEmpty
                                        ? (_hasData
                                            ? Container(
                                                height: 270,
                                              )
                                            : Container(
                                                height: 270,
                                                child: Center(
                                                  child: Text("No Car Available in this Category"),
                                                ),
                                              ))
                                        : Container(
                                            height: 270,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              // itemCount: _catergorywiseCar!.data!.length,
                                              itemCount: _allCarsModel!.data!.length,
                                              itemBuilder: (context, item) {
                                                double distance = calculateDistance(
                                                    double.parse(
                                                      SessionHelper().get(SessionHelper.LATITUDE).toString(),
                                                    ),
                                                    double.parse(
                                                      SessionHelper().get(SessionHelper.LONGITUDE).toString(),
                                                    ),
                                                    double.parse(_allCarsModel!.data![item].pickLat1.toString()),
                                                    double.parse(_allCarsModel!.data![item].pickLong1.toString()));
                                                String travelTime = calculateTravelTime(
                                                    double.parse(
                                                        SessionHelper().get(SessionHelper.LATITUDE).toString()),
                                                    double.parse(
                                                        SessionHelper().get(SessionHelper.LONGITUDE).toString()),
                                                    double.parse(_allCarsModel!.data![item].pickLat1.toString()),
                                                    double.parse(_allCarsModel!.data![item].pickLong1.toString()),
                                                    80);

                                                final category = _allCarsModel!.data![item];
                                                // final imagePath = eachCategoryWithImages[category];
                                                //  isSelected = _allCategoryModel!.data![item].categoryName;
                                                //  print("====isSelected ghjegej===${isSelected}");
                                                return InkWell(
                                                  onTap: () {
                                                    print(
                                                        "=====_allCarsModel!.data!.length111======${_allCarsModel!.data!.length}");
                                                    print("=====_isSelected11111=====${isSelected}");
                                                    context.pushNamed(
                                                      'product_detail_page',
                                                      queryParameters: {
                                                        'carId': _allCarsModel!.data![item].carId.toString(),
                                                        'lat':
                                                            double.parse(_allCarsModel!.data![item].pickLat1.toString())
                                                                .toString(),
                                                        'long': double.parse(
                                                                _allCarsModel!.data![item].pickLong1.toString())
                                                            .toString(),
                                                        'pickaddress':
                                                            _allCarsModel!.data![item].pickAddress1.toString(),
                                                        'time': travelTime.toString(),
                                                        'distance': double.parse(distance.toString()).toString(),
                                                      }.withoutNulls,
                                                    );
                                                    // context.pushNamed('product_detail_page');
                                                    // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
                                                    // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                                  },
                                                  child: Container(
                                                    height: 270,
                                                    margin: EdgeInsets.only(right: 10),
                                                    width: MediaQuery.of(context).size.width / 1.1,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Color(0xffFAFAFA), width: 1.5)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 60,
                                                                    height: 24,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xffFAF9FE),
                                                                      border: Border.all(
                                                                        color: Color(0xff0D0C0F),
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 0.0, vertical: 0),
                                                                      child: Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            size: 10,
                                                                            color: Color(0xffFFBB35),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(
                                                                            _allCarsModel!.data![item].rating
                                                                                        .toString() ==
                                                                                    "0.00"
                                                                                ? "5.0"
                                                                                : _allCarsModel!.data![item].rating
                                                                                    .toString(),
                                                                            style: FlutterTheme.of(context)
                                                                                .titleSmall
                                                                                .override(
                                                                                    fontFamily: 'Urbanist',
                                                                                    color: Color(0xff0D0C0F),
                                                                                    fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Container(
                                                                    width: 85,
                                                                    height: 24,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xff4ADB06).withOpacity(0.06),
                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 2.0, vertical: 0),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Available now",
                                                                          style: FlutterTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                  fontFamily: 'Urbanist',
                                                                                  color: Color(0xff4ADB06),
                                                                                  fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.8,
                                                                  ),
                                                                  Icon(
                                                                    Icons.directions_walk,
                                                                    color: Color(0xff7C8BA0),
                                                                    size: 12,
                                                                  ),
                                                                  Text(
                                                                    " ${distance.toStringAsFixed(2)} km",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                        fontFamily: 'Urbanist',
                                                                        color: Color(0xff0D0C0F),
                                                                        fontSize: 10),
                                                                  ),
                                                                  Text(
                                                                    "(${travelTime})",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 10,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),

                                                              InkWell(
                                                                onTap: () {
                                                                  // setState(() {
                                                                  //   isFavourite = !isFavourite;
                                                                  // });

                                                                  setState(() {
                                                                    if (_allCarsModel!.data![item].favStatus
                                                                            .toString() ==
                                                                        "0") {
                                                                      _allCarsModel!.data![item].favStatus = "1";
                                                                      Helper.checkInternet(favourite(
                                                                          _allCarsModel!.data![item].carId.toString()));
                                                                    } else {
                                                                      _allCarsModel!.data![item].favStatus = "0";
                                                                      Helper.checkInternet(Unfavourite(
                                                                          _allCarsModel!.data![item].carId.toString()));
                                                                    }
                                                                  });
                                                                },
                                                                child: SvgPicture.asset(
                                                                  (_allCarsModel!.data![item].favStatus.toString() ==
                                                                          "1")
                                                                      ? 'assets/images/bookmark-03.svg'
                                                                      : 'assets/images/bookmark_outline-03.svg',
                                                                  width: 30.33,
                                                                  height: 28.5,
                                                                ),
                                                              ),
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     Helper.checkInternet(favourite(_allCarsModel!.data![item].carId.toString()));
                                                              //   },
                                                              //   child: SvgPicture.asset(
                                                              //     'assets/images/heart_line.svg',
                                                              //     width: 30.33,
                                                              //     height: 28.5,
                                                              //   ),
                                                              // ),
                                                              // SvgPicture.asset(
                                                              //   'assets/images/heart_line.svg',
                                                              //   width: 30.33,
                                                              //   height: 28.5,
                                                              // ),
                                                            ],
                                                          ),
                                                          Image.network(
                                                            _allCarsModel == null
                                                                ? ""
                                                                : _allCarsModel!.data![item].carImage![0].image
                                                                    .toString(),
                                                            width: 240.33,
                                                            height: 130.5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    _allCarsModel == null
                                                                        ? ""
                                                                        : _allCarsModel!.data![item].carName.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    _allCarsModel == null
                                                                        ? ""
                                                                        : _allCarsModel!.data![item].description
                                                                            .toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff0D0C0F),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "\$${_allCarsModel!.data![item].carCost.toString()}" +
                                                                        "/",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                        fontFamily: 'Urbanist',
                                                                        color: Color(0xff0D0C0F),
                                                                        fontSize: 16),
                                                                  ),
                                                                  Text(
                                                                    _allCarsModel!.data![item].priceType.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 12,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Color(0xffAD3CFD6),
                                                            thickness: 0.5,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/sedan.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    _allCarsModel!.data![item].vehicleCategory
                                                                        .toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/diesel.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    _allCarsModel!.data![item].specification.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/seater.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    "${_allCarsModel!.data![item].carSeat.toString()} Seater",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ))
                                    : (_catergorywiseCar == null || _catergorywiseCar!.data!.isEmpty
                                        ? (_hasData
                                            ? Container(
                                                height: 270,
                                              )
                                            : Container(
                                                height: 270,
                                                child: Center(
                                                  child: Text("No Car Available in this Category"),
                                                ),
                                              ))
                                        : Container(
                                            height: 270,
                                            child: ListView.builder(
                                              padding: EdgeInsets.zero,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _catergorywiseCar!.data!.length,
                                              // itemCount: _allCategoryModel!.data!.length,
                                              itemBuilder: (context, item) {
                                                print(
                                                    "=====_allCategoryModel!.data!.length======${_catergorywiseCar!.data!.length}");
                                                double distance = calculateDistance(
                                                    double.parse(
                                                        SessionHelper().get(SessionHelper.LATITUDE).toString()),
                                                    double.parse(
                                                        SessionHelper().get(SessionHelper.LONGITUDE).toString()),
                                                    double.parse(_catergorywiseCar!.data![item].pickLat1.toString()),
                                                    double.parse(_catergorywiseCar!.data![item].pickLong1.toString()));
                                                String travelTime = calculateTravelTime(
                                                    double.parse(_catergorywiseCar!.data![item].pickLat1.toString()),
                                                    double.parse(_catergorywiseCar!.data![item].pickLong1.toString()),
                                                    double.parse(_catergorywiseCar!.data![item].pickLat2.toString()),
                                                    double.parse(_catergorywiseCar!.data![item].pickLong2.toString()),
                                                    80);
                                                print("=====_isSelected2222=====${isSelected}");
                                                final category = _catergorywiseCar!.data![item];
                                                // final imagePath = eachCategoryWithImages[category];
                                                //  isSelected = _allCategoryModel!.data![item].categoryName;
                                                //  print("====isSelected ghjegej===${isSelected}");
                                                return InkWell(
                                                  onTap: () {
                                                    context.pushNamed(
                                                      'product_detail_page',
                                                      queryParameters: {
                                                        'carId': _catergorywiseCar!.data![item].carId.toString(),
                                                        'time': travelTime.toString(),
                                                        'distance': double.parse(distance.toString()).toString(),
                                                      }.withoutNulls,
                                                    );
                                                    // context.pushNamed('product_detail_page');
                                                    // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
                                                    // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                                  },
                                                  child: Container(
                                                    height: 270,
                                                    margin: EdgeInsets.only(right: 10),
                                                    width: MediaQuery.of(context).size.width / 1.1,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Color(0xffFAFAFA), width: 1.5)),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    width: 60,
                                                                    height: 24,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xffFAF9FE),
                                                                      border: Border.all(
                                                                        color: Color(0xff0D0C0F),
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(8.0),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 0.0, vertical: 0),
                                                                      child: Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            size: 10,
                                                                            color: Color(0xffFFBB35),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 5,
                                                                          ),
                                                                          Text(
                                                                            _catergorywiseCar!.data![item].rating
                                                                                        .toString() ==
                                                                                    "0.00"
                                                                                ? "5.0"
                                                                                : _catergorywiseCar!.data![item].rating
                                                                                    .toString(),
                                                                            style: FlutterTheme.of(context)
                                                                                .titleSmall
                                                                                .override(
                                                                                    fontFamily: 'Urbanist',
                                                                                    color: Color(0xff0D0C0F),
                                                                                    fontSize: 12),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Container(
                                                                    width: 85,
                                                                    height: 24,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xff4ADB06).withOpacity(0.06),
                                                                      borderRadius: BorderRadius.circular(6.0),
                                                                    ),
                                                                    child: Padding(
                                                                      padding: const EdgeInsets.symmetric(
                                                                          horizontal: 2.0, vertical: 0),
                                                                      child: Center(
                                                                        child: Text(
                                                                          "Available now",
                                                                          style: FlutterTheme.of(context)
                                                                              .titleSmall
                                                                              .override(
                                                                                  fontFamily: 'Urbanist',
                                                                                  color: Color(0xff4ADB06),
                                                                                  fontSize: 12),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5.8,
                                                                  ),
                                                                  Icon(
                                                                    Icons.directions_walk,
                                                                    color: Color(0xff7C8BA0),
                                                                    size: 12,
                                                                  ),
                                                                  Text(
                                                                    " ${distance.toStringAsFixed(2)} km",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                        fontFamily: 'Urbanist',
                                                                        color: Color(0xff0D0C0F),
                                                                        fontSize: 10),
                                                                  ),
                                                                  Text(
                                                                    "(${travelTime})",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 10,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),

                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (_catergorywiseCar!.data![item].favStatus
                                                                            .toString() ==
                                                                        "0") {
                                                                      _catergorywiseCar!.data![item].favStatus = "1";
                                                                      Helper.checkInternet(favourite(_catergorywiseCar!
                                                                          .data![item].carId
                                                                          .toString()));
                                                                    } else {
                                                                      _catergorywiseCar!.data![item].favStatus = "0";
                                                                      Helper.checkInternet(Unfavourite(
                                                                          _catergorywiseCar!.data![item].carId
                                                                              .toString()));
                                                                    }
                                                                  });
                                                                  // setState(() {
                                                                  //   isFavourite = !isFavourite;
                                                                  // });
                                                                  //
                                                                  // if (isFavourite) {
                                                                  //   Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
                                                                  // } else {
                                                                  //   Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
                                                                  // }
                                                                },
                                                                child: SvgPicture.asset(
                                                                  _catergorywiseCar!.data![item].favStatus == "1"
                                                                      ? 'assets/images/bookmark-03.svg'
                                                                      : 'assets/images/bookmark_outline-03.svg',
                                                                  width: 30.33,
                                                                  height: 28.5,
                                                                ),
                                                              ),
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
                                                              //   },
                                                              //   child: SvgPicture.asset(
                                                              //     'assets/images/bookmark-03.svg',
                                                              //     width: 30.33,
                                                              //     height: 28.5,
                                                              //   ),
                                                              // ),
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
                                                              //   },
                                                              //   child: SvgPicture.asset(
                                                              //     'assets/images/bookmark_outline-03.svg',
                                                              //     width: 30.33,
                                                              //     height: 28.5,
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          Image.network(
                                                            _catergorywiseCar!.data![item].carImage.toString(),
                                                            width: 240.33,
                                                            height: 130.5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    _catergorywiseCar!.data![item].carName.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  Text(
                                                                    _catergorywiseCar!.data![item].brandName.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 16,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff0D0C0F),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "\$${_catergorywiseCar!.data![item].carCost.toString()}" +
                                                                        "/",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                        fontFamily: 'Urbanist',
                                                                        color: Color(0xff0D0C0F),
                                                                        fontSize: 16),
                                                                  ),
                                                                  Text(
                                                                    _catergorywiseCar!.data![item].priceType.toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 12,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Color(0xffAD3CFD6),
                                                            thickness: 0.5,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/sedan.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    _catergorywiseCar!.data![item].vehicleCategory
                                                                        .toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/diesel.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    _catergorywiseCar!.data![item].specification
                                                                        .toString(),
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SvgPicture.asset(
                                                                    'assets/images/seater.svg',
                                                                    width: 18.33,
                                                                    height: 16.5,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 8.8,
                                                                  ),
                                                                  Text(
                                                                    "${_catergorywiseCar!.data![item].carSeat.toString()} Seater",
                                                                    style: FlutterTheme.of(context).titleSmall.override(
                                                                          fontFamily: 'Urbanist',
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0xff7C8BA0),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          )),

                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Promo Codes",
                                      style: FlutterTheme.of(context).bodyMedium.override(
                                          fontFamily: 'Urbanist',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0XFF0D0C0F)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 5.0),
                                      child: InkWell(
                                        onTap: () {
                                          Helper.moveToScreenwithPush(context, ViewAllPromode());
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "See All",
                                              style: FlutterTheme.of(context).bodyMedium.override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 17.0,
                                                    fontWeight: FontWeight.w500,
                                                    color: FlutterTheme.of(context).plumpPurple,
                                                  ),
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              color: FlutterTheme.of(context).plumpPurple,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _promocode == null
                                    ? _hasData
                                        ? Container()
                                        : Container(
                                            child: Center(
                                              child: Text("NO DATA"),
                                            ),
                                          )
                                    : Container(
                                        height: 120,
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _promocode!.deliverydata!.length,
                                          shrinkWrap: true,
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              onTap: () {
                                                Helper.moveToScreenwithPush(
                                                    context,
                                                    PromoCodeDetailPageWidget(
                                                      coupon_image: _promocode!.deliverydata![index].image.toString(),
                                                      coupon: _promocode!.deliverydata![index].couponCode.toString(),
                                                      title: _promocode!.deliverydata![index].couponName.toString(),
                                                      details: _promocode!.deliverydata![index].description.toString(),
                                                    ));
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(right: 20),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 120,
                                                      // width: 222,
                                                      width: MediaQuery.of(context).size.width / 1.5,
                                                      decoration: BoxDecoration(

                                                          // color: Colors.green,
                                                          borderRadius: BorderRadius.circular(8),
                                                          border: Border.all(color: Color(0xffD9D9D9))),
                                                      // color: Colors.green,
                                                      child: Column(
                                                        children: [
                                                          _promocode!.deliverydata![index].image.toString() == ""
                                                              ? Image.asset(
                                                                  'assets/images/promocode1.png',
                                                                  height: 90,
                                                                  width: 352.0,
                                                                  fit: BoxFit.cover,
                                                                )
                                                              : Image.network(
                                                                  _promocode!.deliverydata![index].image.toString(),
                                                                  fit: BoxFit.fill,
                                                                  width: MediaQuery.of(context).size.width / 1.5,
                                                                  height: 90,
                                                                ),
                                                          // Container(
                                                          //   height: 90,
                                                          //   width: MediaQuery.of(context).size.width/1.5,
                                                          //   decoration: BoxDecoration(
                                                          //       borderRadius: BorderRadius.circular(8),
                                                          //       image: DecorationImage(
                                                          //           image: AssetImage('assets/images/promocode1.png',),fit: BoxFit.fill
                                                          //       )
                                                          //   ),
                                                          //
                                                          // ),

                                                          Container(
                                                            height: 20,
                                                            width: MediaQuery.of(context).size.width / 1.5,
                                                            decoration: BoxDecoration(
                                                                // color: Colors.grey,
                                                                borderRadius: BorderRadius.only(
                                                              bottomLeft: Radius.circular(8.0),
                                                              bottomRight: Radius.circular(8.0),
                                                            )),
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Redeem Code",
                                                                    style: FlutterTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Urbanist',
                                                                        fontSize: 12.0,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Color(0XFF553FA5)),
                                                                  ),
                                                                  Text(
                                                                    "Expire: ${_promocode!.deliverydata![index].couponVaildT.toString()}",
                                                                    style: FlutterTheme.of(context).bodyMedium.override(
                                                                        fontFamily: 'Urbanist',
                                                                        fontSize: 12.0,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Color(0XFF7C8BA0)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                  Helper.getProgressBarWhite(context, _isVisible)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> userdetailsApi() async {
    print("<=============userdetailsApi=============>${FFAppState().UserId}");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token': "booking12345",
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.profile), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          UserProfileModel model = UserProfileModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);

            setState(() {
              _userProfileModel = model;
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );

            // context.pushNamed('RegisterCrozerVehicalPage');

            //  ToastMessage.msg(model.message.toString());
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
            //     route) => false);
          } else {
            setProgress(false);
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> categoryapi() async {
    print("<=============categoryapi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': "booking12345",
    };

    print("Request =============> " + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.category), body: data);
      print("Response ============> " + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AllCategoryModel model = AllCategoryModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _allCategoryModel = model;

              // Check the state of the data list before insertion
              print("Before insertion, data length: ${_allCategoryModel!.data?.length}");

              // Add a new category at the zero index
              _allCategoryModel!.addCategoryAtZeroIndex(
                "newCatId",
                "All Cars",
                "https://brainesscompany.com.br/api_assets/images/ALL_CARS.png",
              );

              // Check the state of the data list after insertion
              print("After insertion, data length: ${_allCategoryModel!.data?.length}");
              print("Category at zero index: ${_allCategoryModel!.data![0].categoryName}");
              print("Category image at zero index: ${_allCategoryModel!.data![0].categoryImage}");

              // Initialize selected category to "All Cars" if it exists
              // for (var category in _allCategoryModel!.data!) {
              //   if (category.categoryName == "All Cars") {
              //     isSelected = "All Cars";
              //     Helper.checkInternet(allcategory());
              //     break;
              //   }
              // }
            });
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
          }
        } catch (e) {
          print("Exception while parsing response ============>");
          print('exception ==> ' + e.toString());
        }
      } else {
        print("HTTP status code ==> " + res.statusCode.toString());
      }
    } catch (e) {
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
  }

  Future<void> categorywiselist(String category) async {
    print("<=============categorywiselist== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': 'booking12345',
      'category': category,
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.category_wise_car), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CatergorywiseCar model = CatergorywiseCar.fromJson(jsonResponse);

          if (model.response == "true") {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _catergorywiseCar = model;
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
  }

  Future<void> favourite(String car_id) async {
    print("<============favourite== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': 'booking12345',
      'car_id': car_id,
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.Add_favourite), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddFavourite model = AddFavourite.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _addFavourite = model;
              // Helper.checkInternet(categoryapi());
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
  }

  Future<void> Unfavourite(String car_id) async {
    print("<============unfav== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': 'booking12345',
      'car_id': car_id,
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.Unfavourite), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AddFavourite model = AddFavourite.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _addFavourite = model;
              // Helper.checkInternet(categoryapi());
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
  }

  Future<void> allcars() async {
    print("<=============allcategory=click============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': 'booking12345',
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.all_cars), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          AllCarsModel model = AllCarsModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _allCarsModel = model;
              print("=====  _allCarsModel!.data!.length.toString()====${_allCarsModel!.data!.length.toString()}");
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
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

      print('Current Position: ${globalLatitude}, ${globalLongitude}');

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        startLocation = LatLng(position.latitude, position.longitude);
        print("====startLocation=====${startLocation}");
        location = placemarks.first.street.toString() +
            ", " +
            placemarks.first.subLocality.toString() +
            ", " +
            placemarks.first.administrativeArea.toString();
        _isVisiblenew = true;
        setProgress(false);
        print("=====location======${location}");
      });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }

  Future<void> promocode() async {
    print("<=============promocode=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData = true;

    Map data = {
      'app_token': 'booking12345',
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.promocode), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Promocode model = Promocode.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _promocode = model;
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hasData = false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          print("false ============>");
          //ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      //  ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
    _hasData = false;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Radius of the Earth in kilometers
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) + cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = R * c; // Distance in kilometers

    return double.parse(distance.toStringAsFixed(2));
  }

  String calculateTravelTime(double lat1, double lon1, double lat2, double lon2, double averageSpeedKmH) {
    double distance = calculateDistance(lat1, lon1, lat2, lon2);
    double time = distance / averageSpeedKmH; // Time in hours

    int hours = time.floor();
    int minutes = ((time - hours) * 60).round();

    return "${hours}h ${minutes}m";
  }
}
