
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import '../../notificationservice/local_notification_service.dart';
import '../constant.dart';
import '../model/fav_model.dart';
import '../model/find_car_model.dart';
import '/flutter/flutter_google_map.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'home_page/home_page_model.dart';


class FindCarsWidget extends StatefulWidget {
  dynamic lat;
  dynamic long;
  String vehicle_category ;
  String price ;
  String price_type ;
  String start_date ;
  String end_date ;
  String start_price ;
  String end_price ;


  FindCarsWidget({required this.lat,required this.long,required this.vehicle_category,required this.price_type,
    required this.price,required this.start_date,required this.end_date,required this.start_price,
    required this.end_price});


  @override
  _FindCarsWidgetState createState() => _FindCarsWidgetState();
}

class _FindCarsWidgetState extends State<FindCarsWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // LatLng? currentUserLocationValue;
  FindCarModel?_findCarModel;
  AddFavourite?_addFavourite;
  List<String> eachCategoryList = [
    'All car',
    'suv',
    'seden',
    'coupe',
    'van',

  ];
  String? selectedCategory;
  int value =5;
  int _min = 5;
  int _max = 50;
  bool _isSliderEnabled = true;
  Map<String, String> eachCategoryWithImages = {
    'All car': 'assets/images/allcar.svg',
    'suv': 'assets/images/Fly.svg',
    'seden': 'assets/images/Fly-1.svg',
    'coupe': 'assets/images/Fly-2.svg',
    'van': 'assets/images/Fly-2.svg',

  };
  bool _hasData = true;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
    //     .then((loc) => setState(() => currentUserLocationValue = loc));
    // FirebaseMessaging.instance.getInitialMessage().then(
    //       (message) {
    //     print("FirebaseMessaging.instance.getInitialMessage");
    //     if (message != null) {
    //       print("New Notification");
    //       // if (message.data['_id'] != null) {
    //       //   Navigator.of(context).push(
    //       //     MaterialPageRoute(
    //       //       builder: (context) => NotificationPage( serviceId: message.data['_id'],
    //       //       ),
    //       //     ),
    //       //   );
    //       // }
    //
    //     }
    //   },
    // );
    //
    // FirebaseMessaging.onMessage.listen(
    //       (message) {
    //     if (kDebugMode) {
    //       print("FirebaseMessaging.onMessage.listen");
    //     }
    //     if (message.notification != null) {
    //       if (kDebugMode) {
    //         // ToastMessage.msg(message.notification!.title.toString());
    //         print(message.notification!.title);
    //       }
    //       if (kDebugMode) {
    //         // ToastMessage.msg(message.notification!.title.toString());
    //         print(message.notification!.body);
    //       }
    //       if (kDebugMode) {
    //         // ToastMessage.msg(message.notification!.title.toString());
    //         print("message.data11 ${message.data}");
    //       }
    //
    //       LocalNotificationService.createanddisplaynotification(message);
    //       setState(() {
    //         // noti_count++;
    //         // updateNotiCount(noti_count);
    //         // hasNewMessages = true;
    //       });
    //     }
    //   },
    // );
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //       (message) {
    //     print("FirebaseMessaging.onMessageOpenedApp.listen");
    //     if (message.notification != null) {
    //       print(message.notification!.title);
    //       print(message.notification!.body);
    //       // ToastMessage.msg(message.notification!.title.toString());
    //       // ToastMessage.msg(message.data.toString());
    //       print("message.data22 ${message.data['_id']}");
    //       setState(() {
    //         // noti_count++;
    //         // updateNotiCount(noti_count);
    //         // hasNewMessages = true;
    //       });
    //     }
    //     LocalNotificationService.enableIOSNotifications();
    //   },
    // );
    Helper.checkInternet(findcar());
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
    // if (currentUserLocationValue == null) {
    //   return Container(
    //     color: FlutterTheme.of(context).primaryBackground,
    //     child: Center(
    //       child: SizedBox(
    //         width: 50,
    //         height: 50,
    //         child: CircularProgressIndicator(
    //           valueColor: AlwaysStoppedAnimation<Color>(
    //             FlutterTheme.of(context).primary,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

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
            backgroundColor: FlutterTheme.of(context).secondaryBackground,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,top: 15,right: 0,bottom: 10),
                child: Image.asset('assets/images/back_icon_with_bg.png',height: 30,width: 30,),
              ),
            ),
            title: Text("Your Filtered Car",
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
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: Stack(
                children: [
                  _findCarModel==null
                      ? _hasData
                      ? Container()
                      : Container(
                    child: Center(
                      child: Text("NO DATA"),
                    ),
                  ):
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          // "(16) Available Cars in Sedan",
                          "${_findCarModel!.data!.length} Available Cars in ${widget.vehicle_category}",
                          style: FlutterTheme.of(context)
                              .bodyMedium
                              .override(
                              fontFamily: 'Urbanist',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,color: Color(0XFF000000)
                          ),
                        ),
                        SingleChildScrollView(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: _findCarModel!.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return  InkWell(
                                  onTap: () {
                                    // print("=====_allCarsModel!.data!.length111======${_allCarsModel!.data!.length}");
                                    // print("=====_isSelected11111=====${isSelected}");
                                    context.pushNamed(
                                      'product_detail_page',
                                      queryParameters: {
                                        'carId':_findCarModel!.data![index]!.carId.toString(),
                                        'lat':double.parse( _findCarModel!.data![index]!.pickLat1.toString()).toString(),
                                        'long':double.parse(_findCarModel!.data![index]!.pickLong1.toString()).toString(),
                                        'pickaddress':  _findCarModel!.data![index]!.pickAddress1.toString(),
                                        'time':'',
                                        'distance': '',
                                      }.withoutNulls,
                                    );},
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 300,
                                        margin: EdgeInsets.only(right: 10),
                                        width: MediaQuery.of(context).size.width/1.1,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xffFAFAFA),width: 1.5
                                            )
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      // Container(
                                                      //   width: 72,
                                                      //   height: 24,
                                                      //   decoration: BoxDecoration(
                                                      //     color: Color(0xffFAF9FE
                                                      //     ),
                                                      //     border: Border.all(
                                                      //       color: Color(0xff0D0C0F),
                                                      //     ),
                                                      //     borderRadius: BorderRadius.circular(8.0),
                                                      //   ),
                                                      //   child: Padding(
                                                      //     padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                                      //     child: Row(
                                                      //       children: [
                                                      //         _findCarModel!.data![index]!.image.toString()==""?Image.asset( 'assets/images/default_profile_image.png',height: 25,width: 25,):
                                                      //         ClipOval(child: Image.network(_findCarModel!.data![index]!.image.toString(),height: 25,width: 25,)),
                                                      //         // Image.asset( 'assets/images/Male 5.png',),
                                                      //         SizedBox(
                                                      //           width: 8.8,
                                                      //         ),
                                                      //         SizedBox(
                                                      //           width: 5,
                                                      //         ),
                                                      //         // Icon(Icons.star,size: 10,color: Color(0xffFFBB35),),
                                                      //         // SizedBox(
                                                      //         //   width: 5,
                                                      //         // ),
                                                      //         // Text(
                                                      //         //   "4.7", style: FlutterTheme.of(context).titleSmall.override(
                                                      //         //     fontFamily: 'Urbanist',
                                                      //         //     color: Color(0xff0D0C0F),fontSize: 12
                                                      //         // ),
                                                      //         // ),
                                                      //         // Text(
                                                      //         //   "(109)", style: FlutterTheme.of(context).titleSmall.override(
                                                      //         //   fontFamily: 'Urbanist',fontSize: 12,
                                                      //         //   color: Color(0xff7C8BA0),
                                                      //         // ),
                                                      //         // ),
                                                      //       ],
                                                      //     ),
                                                      //   ),
                                                      // ),

                                                      _findCarModel!.data![index]!.image.toString()==""?Image.asset( 'assets/images/default_profile_image.png',height: 25,width: 25,):
                                                      ClipOval(child: Image.network(_findCarModel!.data![index]!.image.toString(),height: 25,width: 25,)),
                                                      // Image.asset( 'assets/images/Male 5.png',),
                                                      // SizedBox(
                                                      //   width: 8.8,
                                                      // ),
                                                      // SizedBox(
                                                      //   width: 5,
                                                      // ),
                                                      SizedBox(
                                                        width: 8.8,
                                                      ),

                                                      Container(
                                                        width: 110,
                                                        height: 24,
                                                        decoration: BoxDecoration(
                                                          color: Color(0xff4ADB06).withOpacity(0.06),
                                                          borderRadius: BorderRadius.circular(6.0),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 0),
                                                          child: Center(
                                                            child: Text(
                                                              "Available now", style: FlutterTheme.of(context).titleSmall.override(
                                                                fontFamily: 'Urbanist',
                                                                color: Color(0xff4ADB06),fontSize: 12
                                                            ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   width: 8.8,
                                                      // ),
                                                      // Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
                                                      // Text(
                                                      //   "120m", style: FlutterTheme.of(context).titleSmall.override(
                                                      //     fontFamily: 'Urbanist',
                                                      //     color: Color(0xff0D0C0F),fontSize: 12
                                                      // ),
                                                      // ),
                                                      // Text(
                                                      //   "(4 min)", style: FlutterTheme.of(context).titleSmall.override(
                                                      //   fontFamily: 'Urbanist',fontSize: 12,
                                                      //   color: Color(0xff7C8BA0),
                                                      // ),
                                                      // ),
                                                    ],
                                                  ),

                                                  InkWell(
                                                    onTap: () {
                                                      // setState(() {
                                                      //   isFavourite = !isFavourite;
                                                      // });


                                                      setState(() {
                                                        if (_findCarModel!.data![index]!.favStatus.toString()=="0") {
                                                          _findCarModel!.data![index].favStatus="1";
                                                          Helper.checkInternet(favourite(_findCarModel!.data![index]!.carId.toString()));
                                                        } else {
                                                          _findCarModel!.data![index]!.favStatus="0";
                                                          Helper.checkInternet(Unfavourite(_findCarModel!.data![index]!.carId.toString()));
                                                        }
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                      (_findCarModel!.data![index]!.favStatus.toString()=="1")
                                                          ? 'assets/images/bookmark-03.svg'
                                                          : 'assets/images/bookmark_outline-03.svg',
                                                      width: 25.33,
                                                      height: 25.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Image.network(
                                                _findCarModel!.data![index].carImage![index].image.toString(),
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
                                                        _findCarModel!.data![index].carName.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                                        color: Color(0xff7C8BA0),
                                                      ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        _findCarModel!.data![index].description.toString(),style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                                                        color: Color(0xff0D0C0F),
                                                      ),
                                                      ),
                                                    ],

                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "\$${_findCarModel!.data![index].carCost.toString()}", style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          color: Color(0xff0D0C0F),fontSize: 16
                                                      ),
                                                      ),
                                                      Text(
                                                        _findCarModel!.data![index].priceType.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 12,
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
                                                        _findCarModel!.data![index].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
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
                                                        "Diesel", style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
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
                                                        "${ _findCarModel!.data![index].carSeat.toString()} Seater", style: FlutterTheme.of(context).titleSmall.override(
                                                        fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
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
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  )
                              );
                            },

                          ),
                        ),



                      ],
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

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  Future<void> favourite(String car_id) async {


    print("<============favourite== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'car_id':car_id,
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
            _hasData=false;

            setState(() {
              _addFavourite=model;
              // Helper.checkInternet(categoryapi());
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
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
    _hasData=false;
  }
  Future<void> Unfavourite(String car_id) async {


    print("<============unfav== hello===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'car_id':car_id,
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
            _hasData=false;

            setState(() {
              _addFavourite=model;
              // Helper.checkInternet(categoryapi());
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
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
    _hasData=false;
  }
  Future<void> findcar() async {



    print("<=============categorywiselist=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'lat':widget.lat.toString(),
      'vehicle_category':widget.vehicle_category.trim(),
      'price':value.toString(),
      'long':widget.long.toString(),
      'start_date':widget.start_date,
      'price_type':widget.price_type,
      'end_date':widget.end_date,
      'price_from':widget.start_price,
      'price_to':widget.end_price,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.search_car), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          FindCarModel model = FindCarModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _findCarModel=model;
            });

            print("successs==============");

            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
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
    _hasData=false;
  }
}
