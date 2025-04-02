import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../constant.dart';
import '../../model/current_booking_model.dart';
import '../../model/fav_model.dart';
import '../../model/history_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_button_tabbar.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'your_current_booking_page_model.dart';
export 'your_current_booking_page_model.dart';
import 'package:http/http.dart' as http;

class YourCurrentBookingPageWidget extends StatefulWidget {
  const YourCurrentBookingPageWidget({Key? key}) : super(key: key);

  @override
  _YourCurrentBookingPageWidgetState createState() =>
      _YourCurrentBookingPageWidgetState();
}

class _YourCurrentBookingPageWidgetState
    extends State<YourCurrentBookingPageWidget> with TickerProviderStateMixin {
  late YourCurrentBookingPageModel _model;
  bool _hasData = true;
  bool _isVisible = false;
  AddFavourite? _addFavourite;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  CurrentBooking? _currentBooking;
  HistoryBooking?_historyBooking;
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  String location = '';
  bool _isVisiblenew = false;
  bool _isLoading = false;

  Widget _buildStatusContainer(BuildContext context, String? status, {bool isHistory = false}) {
    String statusText;
    Color backgroundColor;
    Color textColor;

    // Se for histórico, verifica primeiro se foi cancelado
    if (isHistory) {
      if (_historyBooking?.data?[0]?.cancelby != null) {
        status = "5"; // Cancelado
      } else if (status == "4" || status == null) {
        status = "4"; // Entregue
      }
    }

    switch (status) {
      case "1":
        statusText = FFLocalizations.of(context).getText('booking_status_open');
        backgroundColor = Color(0xffFAF9FE);
        textColor = Color(0xff0D0C0F);
        break;
      case "2":
        statusText = FFLocalizations.of(context).getText('booking_status_accepted');
        backgroundColor = Color(0xff4ADB06).withOpacity(0.06);
        textColor = Color(0xff4ADB06);
        break;
      case "3":
        statusText = FFLocalizations.of(context).getText('booking_status_picked_up');
        backgroundColor = Color(0xffFFBB35).withOpacity(0.06);
        textColor = Color(0xffFFBB35);
        break;
      case "4":
        statusText = FFLocalizations.of(context).getText('booking_status_delivered');
        backgroundColor = Color(0xff4ADB06).withOpacity(0.06);
        textColor = Color(0xff4ADB06);
        break;
      case "5":
        statusText = FFLocalizations.of(context).getText('booking_status_cancelled');
        backgroundColor = Color(0xffFF3B30).withOpacity(0.06);
        textColor = Color(0xffFF3B30);
        break;
      default:
        statusText = FFLocalizations.of(context).getText('booking_status_open');
        backgroundColor = Color(0xffFAF9FE);
        textColor = Color(0xff0D0C0F);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text(
        statusText,
        style: FlutterTheme.of(context).titleSmall.override(
          fontFamily: 'Urbanist',
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => YourCurrentBookingPageModel());
    Helper.checkInternet(currentBooking());
    Helper.checkInternet(historycurrentBooking());
    getCurrentLocation();

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => setState(() {}));
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText('booking'),
            style: FlutterTheme.of(context).headlineMedium.override(
                  fontFamily: 'Urbanist',
                  color: FlutterTheme.of(context).primaryText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment(0.0, 0),
                      child: FlutterButtonTabBar(
                        onTap: (i) async {
                          [
                                () async {
                                  Helper.checkInternet(currentBooking());

                                },
                                () async {
                                  Helper.checkInternet(historycurrentBooking());
                                },

                          ][i]();
                        },
                        useToggleButtonStyle: true,
                        labelStyle: FlutterTheme.of(context).displaySmall,
                        unselectedLabelStyle: TextStyle(),
                        labelColor: FlutterTheme.of(context).primaryBtnText,
                        unselectedLabelColor:
                            FlutterTheme.of(context).secondary,
                        backgroundColor: FlutterTheme.of(context).secondary,
                        unselectedBackgroundColor:
                            FlutterTheme.of(context).alternate,
                        borderColor: FlutterTheme.of(context).secondary,
                        unselectedBorderColor:
                            FlutterTheme.of(context).alternate,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        elevation: 0.0,
                        buttonMargin:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        tabs: [
                          Tab(
                            text: FFLocalizations.of(context).getText('current_booking'),
                          ),
                          Tab(
                            text: FFLocalizations.of(context).getText('booking_history'),
                          ),
                        ],
                        controller: _model.tabBarController,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _model.tabBarController,
                        children: [
                          _currentBooking == null
                              ? _hasData
                                  ? Container()
                                  : Container(
                                      child: Center(
                                        child: Text("NO DATA"),
                                      ),
                                    )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _currentBooking!.data!.length,
                                  // itemCount: _allCategoryModel!.data!.length,
                                  itemBuilder: (context, item) {
                                    print(
                                        "=====_allCategoryModel!.data!.length======${_currentBooking!.data!.length}");
                                    double distance = calculateDistance(
                                        double.parse(SessionHelper().get(SessionHelper.LATITUDE).toString()),
                                        double.parse(SessionHelper().get(SessionHelper.LONGITUDE).toString()),
                                        double.parse(_currentBooking!
                                            .data![item].pickLat1
                                            .toString()),
                                        double.parse(_currentBooking!
                                            .data![item].pickLong1
                                            .toString()));
                                    String travelTime = calculateTravelTime(
                                        double.parse(SessionHelper().get(SessionHelper.LATITUDE).toString()),
                                        double.parse(SessionHelper().get(SessionHelper.LONGITUDE).toString()),
                                        double.parse(_currentBooking!
                                            .data![item].pickLat1
                                            .toString()),
                                        double.parse(_currentBooking!
                                            .data![item].pickLong1
                                            .toString()),
                                        80);
                                    // print("=====_isSelected2222=====${isSelected}");
                                    // final category = _catergorywiseCar!.data![item];
                                    // final imagePath = eachCategoryWithImages[category];
                                    //  isSelected = _allCategoryModel!.data![item].categoryName;
                                    //  print("====isSelected ghjegej===${isSelected}");
                                    return InkWell(
                                      onTap: () {
                                        context.pushNamed(
                                          'booking_detail_page',
                                          queryParameters: {
                                            'bookingId': _currentBooking!
                                                .data![item].bookingId
                                                .toString(),
                                          }.withoutNulls,
                                        );

                                        // context.pushNamed(
                                        //   'product_detail_page',
                                        //   queryParameters: {
                                        //     'carId': _currentBooking!
                                        //         .data![item].carId
                                        //         .toString()
                                        //   }.withoutNulls,
                                        // );
                                        // context.pushNamed('product_detail_page');
                                        // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
                                        // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
                                      },
                                      child: Container(
                                        height: 270,
                                        margin: EdgeInsets.only(right: 10),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Color(0xffFAFAFA),
                                                width: 1.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 5),
                                                            Icon(Icons.star, size: 10, color: Color(0xffFFBB35)),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              _currentBooking!.data![item].rating!.toString() == "0.00"
                                                                  ? "5.0"
                                                                  : _currentBooking!.data![item].rating!.toString(),
                                                              style: FlutterTheme.of(context).titleSmall.override(
                                                                fontFamily: 'Urbanist',
                                                                color: Color(0xff0D0C0F),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      _buildStatusContainer(context, _currentBooking!.data![item].status.toString()),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width: 8.8,
                                                  ),
                                                  Container(
                                                    width: 85,
                                                    height: 24,
                                                    decoration:
                                                        BoxDecoration(
                                                      color:
                                                          Color(0xff4ADB06)
                                                              .withOpacity(
                                                                  0.06),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  6.0),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal:
                                                                  2.0,
                                                              vertical: 0),
                                                      child: Center(
                                                        child: Text(
                                                          FFLocalizations.of(context).getText('available_now'),
                                                          style: FlutterTheme
                                                                  .of(
                                                                      context)
                                                              .titleSmall
                                                              .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: Color(
                                                                      0xff4ADB06),
                                                                  fontSize:
                                                                      12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.8,
                                                  ),
                                                  Icon(
                                                    Icons.directions_walk,
                                                    color:
                                                        Color(0xff7C8BA0),
                                                    size: 12,
                                                  ),
                                                  Text(
                                                    " ${distance.toStringAsFixed(2)} km",
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            color: Color(
                                                                0xff0D0C0F),
                                                            fontSize: 10),
                                                  ),
                                                  Text(
                                                    "(${travelTime})",
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 10,
                                                          color: Color(
                                                              0xff7C8BA0),
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              Image.network(
                                                _currentBooking!.data![item]
                                                    .carImage![item].image
                                                    .toString(),
                                                width: 240.33,
                                                height: 130.5,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _currentBooking!
                                                            .data![item].carName
                                                            .toString(),
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff7C8BA0),
                                                            ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        _currentBooking!
                                                            .data![item]
                                                            .brandName
                                                            .toString(),
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff0D0C0F),
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${FFLocalizations.of(context).getText('currency_symbol')}${_currentBooking!.data![item].carCost.toString()}",
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: Color(
                                                                    0xff0D0C0F),
                                                                fontSize: 16),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(context).getText('price_type_hourly'),
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0xff7C8BA0),
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
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
                                                        _currentBooking!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
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
                                                        _currentBooking!
                                                            .data![item]
                                                            .specification
                                                            .toString(),
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff7C8BA0),
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
                                                        "${_currentBooking!.data![item].carSeat.toString()} ${FFLocalizations.of(context).getText('seater')}",
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .titleSmall
                                                            .override(
                                                              fontFamily:
                                                                  'Urbanist',
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0xff7C8BA0),
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
//                           FutureBuilder<ApiCallResponse>(
//                             future: BaseUrlGroup.usercurrentBookingCall.call(
//                               userId: FFAppState().UserId,
//                             ),
//                             builder: (context, snapshot) {
//                               // Customize what your widget looks like when it's loading.
//                               if (!snapshot.hasData) {
//                                 return Center(
//                                   child: SizedBox(
//                                     width: 50.0,
//                                     height: 50.0,
//                                     child: CircularProgressIndicator(
//                                       valueColor: AlwaysStoppedAnimation<Color>(
//                                         FlutterTheme.of(context).primary,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               final conditionalBuilderUsercurrentBookingResponse =
//                                   snapshot.data!;
//                               return Builder(
//                                 builder: (context) {
//                                   if (BaseUrlGroup.usercurrentBookingCall
//                                       .response(
//                                     conditionalBuilderUsercurrentBookingResponse
//                                         .jsonBody,
//                                   )) {
//                                     return Builder(
//                                       builder: (context) {
//                                         final eachResponse =
//                                             BaseUrlGroup.usercurrentBookingCall
//                                                     .dataList(
//                                                       conditionalBuilderUsercurrentBookingResponse
//                                                           .jsonBody,
//                                                     )
//                                                     ?.toList() ??
//                                                 [];
//                                         return
//
//
//
//                                         //   ListView.builder(
//                                         //   padding: EdgeInsets.zero,
//                                         //   shrinkWrap: true,
//                                         //   scrollDirection: Axis.vertical,
//                                         //   itemCount: eachResponse.length,
//                                         //   itemBuilder:
//                                         //       (context, eachResponseIndex) {
//                                         //     final eachResponseItem =
//                                         //         eachResponse[eachResponseIndex];
//                                         //     return Card(
//                                         //       clipBehavior:
//                                         //           Clip.antiAliasWithSaveLayer,
//                                         //       color:
//                                         //           FlutterTheme.of(context)
//                                         //               .secondaryBackground,
//                                         //       elevation: 4.0,
//                                         //       shape: RoundedRectangleBorder(
//                                         //         borderRadius:
//                                         //             BorderRadius.circular(8.0),
//                                         //       ),
//                                         //       child: Align(
//                                         //         alignment: AlignmentDirectional(
//                                         //             0.00, 1.00),
//                                         //         child: Row(
//                                         //           mainAxisSize:
//                                         //               MainAxisSize.max,
//                                         //           crossAxisAlignment:
//                                         //               CrossAxisAlignment.end,
//                                         //           children: [
//                                         //             Column(
//                                         //               mainAxisSize:
//                                         //                   MainAxisSize.max,
//                                         //               crossAxisAlignment:
//                                         //                   CrossAxisAlignment
//                                         //                       .center,
//                                         //               children: [
//                                         //                 Card(
//                                         //                   clipBehavior: Clip
//                                         //                       .antiAliasWithSaveLayer,
//                                         //                   color: FlutterTheme
//                                         //                           .of(context)
//                                         //                       .secondaryBackground,
//                                         //                   elevation: 4.0,
//                                         //                   shape:
//                                         //                       RoundedRectangleBorder(
//                                         //                     borderRadius:
//                                         //                         BorderRadius
//                                         //                             .circular(
//                                         //                                 8.0),
//                                         //                   ),
//                                         //                   child: Padding(
//                                         //                     padding:
//                                         //                         EdgeInsetsDirectional
//                                         //                             .fromSTEB(
//                                         //                                 2.0,
//                                         //                                 2.0,
//                                         //                                 2.0,
//                                         //                                 2.0),
//                                         //                     child: ClipRRect(
//                                         //                       borderRadius:
//                                         //                           BorderRadius
//                                         //                               .circular(
//                                         //                                   8.0),
//                                         //                       child:
//                                         //                           Image.network(
//                                         //                         getJsonField(
//                                         //                           eachResponseItem,
//                                         //
//                                         //                           r'''$.car_image[0].image''',
//                                         //                         ),
//                                         //                         width: 182.0,
//                                         //                         height: 102.0,
//                                         //                         fit: BoxFit
//                                         //                             .cover,
//                                         //                       ),
//                                         //                     ),
//                                         //                   ),
//                                         //                 ),
//                                         //                 Row(
//                                         //                   mainAxisSize:
//                                         //                       MainAxisSize.max,
//                                         //                   children: [
//                                         //                     Text(
//                                         //                       FFLocalizations.of(
//                                         //                               context)
//                                         //                           .getText(
//                                         //                         'g3baa7fb' /* $ */,
//                                         //                       ),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primaryText,
//                                         //                           ),
//                                         //                     ),
//                                         //                     Text(
//                                         //                       getJsonField(
//                                         //                         eachResponseItem,
//                                         //                         r'''$.trip_cost''',
//                                         //                       ).toString(),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primaryText,
//                                         //                           ),
//                                         //                     ),
//                                         //                     Text(
//                                         //                       FFLocalizations.of(
//                                         //                               context)
//                                         //                           .getText(
//                                         //                         'ibfzcjjx' /* / */,
//                                         //                       ),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primaryText,
//                                         //                           ),
//                                         //                     ),
//                                         //                     Text(
//                                         //                       FFLocalizations.of(
//                                         //                               context)
//                                         //                           .getText(
//                                         //                         '882rxjud' /* Price */,
//                                         //                       ),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primaryText,
//                                         //                           ),
//                                         //                     ),
//                                         //                   ],
//                                         //                 ),
//                                         //               ]
//                                         //                   .divide(SizedBox(
//                                         //                       height: 8.0))
//                                         //                   .addToEnd(SizedBox(
//                                         //                       height: 8.0)),
//                                         //             ),
//                                         //             Flexible(
//                                         //               child: Column(
//                                         //                 mainAxisSize:
//                                         //                     MainAxisSize.max,
//                                         //                 mainAxisAlignment:
//                                         //                     MainAxisAlignment
//                                         //                         .end,
//                                         //                 crossAxisAlignment:
//                                         //                     CrossAxisAlignment
//                                         //                         .start,
//                                         //                 children: [
//                                         //                   Padding(
//                                         //                     padding:
//                                         //                         EdgeInsetsDirectional
//                                         //                             .fromSTEB(
//                                         //                                 0.0,
//                                         //                                 0.0,
//                                         //                                 8.0,
//                                         //                                 0.0),
//                                         //                     child: Text(
//                                         //                       getJsonField(
//                                         //                         eachResponseItem,
//                                         //                         r'''$.car_name''',
//                                         //                       ).toString(),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primary,
//                                         //                           ),
//                                         //                     ),
//                                         //                   ),
//                                         //                   Padding(
//                                         //                     padding:
//                                         //                         EdgeInsetsDirectional
//                                         //                             .fromSTEB(
//                                         //                                 0.0,
//                                         //                                 0.0,
//                                         //                                 8.0,
//                                         //                                 0.0),
//                                         //                     child: Text(
//                                         //                       getJsonField(
//                                         //                         eachResponseItem,
//                                         //                         r'''$.address''',
//                                         //                       ).toString(),
//                                         //                       style: FlutterTheme
//                                         //                               .of(context)
//                                         //                           .bodyMedium
//                                         //                           .override(
//                                         //                             fontFamily:
//                                         //                                 'Urbanist',
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .primary,
//                                         //                           ),
//                                         //                     ),
//                                         //                   ),
//                                         //                   // Material(
//                                         //                   //   color: Colors
//                                         //                   //       .transparent,
//                                         //                   //   elevation: 1.0,
//                                         //                   //   shape:
//                                         //                   //       RoundedRectangleBorder(
//                                         //                   //     borderRadius:
//                                         //                   //         BorderRadius
//                                         //                   //             .circular(
//                                         //                   //                 12.5),
//                                         //                   //   ),
//                                         //                   //   child: Container(
//                                         //                   //     width: 60.0,
//                                         //                   //     height: 25.0,
//                                         //                   //     decoration:
//                                         //                   //         BoxDecoration(
//                                         //                   //       color: FlutterTheme.of(
//                                         //                   //               context)
//                                         //                   //           .secondaryBackground,
//                                         //                   //       borderRadius:
//                                         //                   //           BorderRadius
//                                         //                   //               .circular(
//                                         //                   //                   12.5),
//                                         //                   //       shape: BoxShape
//                                         //                   //           .rectangle,
//                                         //                   //       border:
//                                         //                   //           Border.all(
//                                         //                   //         color: FlutterTheme.of(
//                                         //                   //                 context)
//                                         //                   //             .warning,
//                                         //                   //         width: 1.0,
//                                         //                   //       ),
//                                         //                   //     ),
//                                         //                   //     child: Padding(
//                                         //                   //       padding:
//                                         //                   //           EdgeInsetsDirectional
//                                         //                   //               .fromSTEB(
//                                         //                   //                   4.0,
//                                         //                   //                   4.0,
//                                         //                   //                   4.0,
//                                         //                   //                   4.0),
//                                         //                   //       child: Row(
//                                         //                   //         mainAxisSize:
//                                         //                   //             MainAxisSize
//                                         //                   //                 .max,
//                                         //                   //         mainAxisAlignment:
//                                         //                   //             MainAxisAlignment
//                                         //                   //                 .center,
//                                         //                   //         crossAxisAlignment:
//                                         //                   //             CrossAxisAlignment
//                                         //                   //                 .center,
//                                         //                   //         children: [
//                                         //                   //           Icon(
//                                         //                   //             Icons
//                                         //                   //                 .star_rate,
//                                         //                   //             color: FlutterTheme.of(
//                                         //                   //                     context)
//                                         //                   //                 .warning,
//                                         //                   //             size:
//                                         //                   //                 16.0,
//                                         //                   //           ),
//                                         //                   //           SizedBox(
//                                         //                   //             height:
//                                         //                   //                 0.0,
//                                         //                   //             child:
//                                         //                   //                 VerticalDivider(
//                                         //                   //               width:
//                                         //                   //                   5.0,
//                                         //                   //               thickness:
//                                         //                   //                   1.0,
//                                         //                   //               color: FlutterTheme.of(context)
//                                         //                   //                   .accent4,
//                                         //                   //             ),
//                                         //                   //           ),
//                                         //                   //           Flexible(
//                                         //                   //             child:
//                                         //                   //                 Text(
//                                         //                   //               getJsonField(
//                                         //                   //                 eachResponseItem,
//                                         //                   //                 r'''$.rating''',
//                                         //                   //               ).toString(),
//                                         //                   //               style: FlutterTheme.of(context)
//                                         //                   //                   .bodyMedium,
//                                         //                   //             ),
//                                         //                   //           ),
//                                         //                   //         ],
//                                         //                   //       ),
//                                         //                   //     ),
//                                         //                   //   ),
//                                         //                   // ),
//                                         //                   Row(
//                                         //                     mainAxisSize:
//                                         //                         MainAxisSize
//                                         //                             .max,
//                                         //                     mainAxisAlignment:
//                                         //                         MainAxisAlignment
//                                         //                             .end,
//                                         //                     crossAxisAlignment:
//                                         //                         CrossAxisAlignment
//                                         //                             .center,
//                                         //                     children: [
//                                         //                       Expanded(
//                                         //                         child:
//                                         //                             FFButtonWidget(
//                                         //                           onPressed:
//                                         //                               () async {
//                                         //                             context
//                                         //                                 .pushNamed(
//                                         //                               'booking_detail_page',
//                                         //                               queryParameters:
//                                         //                                   {
//                                         //                                 'bookingId':
//                                         //                                     serializeParam(
//                                         //                                   getJsonField(
//                                         //                                     eachResponseItem,
//                                         //                                     r'''$.booking_id''',
//                                         //                                   ),
//                                         //                                   ParamType
//                                         //                                       .double,
//                                         //                                 ),
//                                         //                               }.withoutNulls,
//                                         //                             );
//                                         //                           },
//                                         //                           text: FFLocalizations.of(
//                                         //                                   context)
//                                         //                               .getText(
//                                         //                             '3dfiveih' /* Details */,
//                                         //                           ),
//                                         //                           options:
//                                         //                               FFButtonOptions(
//                                         //                             width:
//                                         //                                 120.0,
//                                         //                             height:
//                                         //                                 40.0,
//                                         //                             padding: EdgeInsetsDirectional
//                                         //                                 .fromSTEB(
//                                         //                                     24.0,
//                                         //                                     0.0,
//                                         //                                     24.0,
//                                         //                                     0.0),
//                                         //                             iconPadding:
//                                         //                                 EdgeInsetsDirectional.fromSTEB(
//                                         //                                     0.0,
//                                         //                                     0.0,
//                                         //                                     0.0,
//                                         //                                     0.0),
//                                         //                             color: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .secondary,
//                                         //                             textStyle: FlutterTheme.of(
//                                         //                                     context)
//                                         //                                 .titleSmall
//                                         //                                 .override(
//                                         //                                   fontFamily:
//                                         //                                       'Urbanist',
//                                         //                                   color:
//                                         //                                       Colors.white,
//                                         //                                 ),
//                                         //                             elevation:
//                                         //                                 3.0,
//                                         //                             borderSide:
//                                         //                                 BorderSide(
//                                         //                               color: Colors
//                                         //                                   .transparent,
//                                         //                               width:
//                                         //                                   1.0,
//                                         //                             ),
//                                         //                             borderRadius:
//                                         //                                 BorderRadius
//                                         //                                     .only(
//                                         //                               bottomLeft:
//                                         //                                   Radius.circular(
//                                         //                                       0.0),
//                                         //                               bottomRight:
//                                         //                                   Radius.circular(
//                                         //                                       16.0),
//                                         //                               topLeft: Radius
//                                         //                                   .circular(
//                                         //                                       16.0),
//                                         //                               topRight:
//                                         //                                   Radius.circular(
//                                         //                                       0.0),
//                                         //                             ),
//                                         //                           ),
//                                         //                         ),
//                                         //                       ),
//                                         //                     ],
//                                         //                   ),
//                                         //                 ].divide(SizedBox(
//                                         //                     height: 8.0)),
//                                         //               ),
//                                         //             ),
//                                         //           ].divide(
//                                         //               SizedBox(width: 12.0)),
//                                         //         ),
//                                         //       ),
//                                         //     );
//                                         //   },
//                                         // );
//                                           _currentBooking==null
//                                               ? _hasData
//                                               ? Container()
//                                               : Container(
//                                             child: Center(
//                                               child: Text("NO DATA"),
//                                             ),
//                                           ):
//                                         ListView.builder(
//                                           padding: EdgeInsets.zero,
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: _currentBooking!.data!.length,
//                                           // itemCount: _allCategoryModel!.data!.length,
//                                           itemBuilder: (context, item) {
//                                             print("=====_allCategoryModel!.data!.length======${_currentBooking!.data!.length}");
//                                             double distance =   calculateDistance(double.parse(_currentBooking!.data![item].pickLat1.toString()), double.parse(_currentBooking!.data![item].pickLong1.toString()) ,double.parse(  _currentBooking!.data![item].pickLat2.toString()),
//                                                 double.parse(_currentBooking!.data![item].pickLong2.toString()));
//                                             String travelTime = calculateTravelTime(double.parse(_currentBooking!.data![item].pickLat1.toString()), double.parse(_currentBooking!.data![item].pickLong1.toString()) ,double.parse(  _currentBooking!.data![item].pickLat2.toString()),
//                                                 double.parse(_currentBooking!.data![item].pickLong2.toString()), 80);
//                                             // print("=====_isSelected2222=====${isSelected}");
//                                             // final category = _catergorywiseCar!.data![item];
//                                             // final imagePath = eachCategoryWithImages[category];
//                                             //  isSelected = _allCategoryModel!.data![item].categoryName;
//                                             //  print("====isSelected ghjegej===${isSelected}");
//                                             return InkWell(
//                                               onTap: () {context.pushNamed(
//                                                 'product_detail_page',
//                                                 queryParameters: {
//                                                   'carId': _currentBooking!.data![item].carId.toString()
//                                                 }.withoutNulls,
//                                               );
//                                                 // context.pushNamed('product_detail_page');
//                                                 // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
//                                                 // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
//                                               },
//                                               child:   Container(
//                                                 height: 270,
//                                                 margin: EdgeInsets.only(right: 10),
//                                                 width: MediaQuery.of(context).size.width/1.1,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius: BorderRadius.circular(10),
//                                                     border: Border.all(
//                                                         color: Color(0xffFAFAFA),width: 1.5
//                                                     )
//                                                 ),
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(8.0),
//                                                   child: Column(
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Row(
//                                                             children: [
//                                                               Container(
//                                                                 width: 72,
//                                                                 height: 24,
//                                                                 decoration: BoxDecoration(
//                                                                   color: Color(0xffFAF9FE
//                                                                   ),
//                                                                   border: Border.all(
//                                                                     color: Color(0xff0D0C0F),
//                                                                   ),
//                                                                   borderRadius: BorderRadius.circular(8.0),
//                                                                 ),
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
//                                                                   child: Row(
//                                                                     children: [
//                                                                       SizedBox(
//                                                                         width: 5,
//                                                                       ),
//                                                                       Icon(Icons.star,size: 10,color: Color(0xffFFBB35),),
//                                                                       SizedBox(
//                                                                         width: 5,
//                                                                       ),
//                                                                       Text(
//                                                                         "4.7", style: FlutterTheme.of(context).titleSmall.override(
//                                                                           fontFamily: 'Urbanist',
//                                                                           color: Color(0xff0D0C0F),fontSize: 12
//                                                                       ),
//                                                                       ),
//                                                                       Text(
//                                                                         "(109)", style: FlutterTheme.of(context).titleSmall.override(
//                                                                         fontFamily: 'Urbanist',fontSize: 12,
//                                                                         color: Color(0xff7C8BA0),
//                                                                       ),
//                                                                       ),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 8.8,
//                                                               ),
//
//                                                               Container(
//                                                                 width: 85,
//                                                                 height: 24,
//                                                                 decoration: BoxDecoration(
//                                                                   color: Color(0xff4ADB06).withOpacity(0.06),
//                                                                   borderRadius: BorderRadius.circular(6.0),
//                                                                 ),
//                                                                 child: Padding(
//                                                                   padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 0),
//                                                                   child: Center(
//                                                                     child: Text(
//                                                                       FFLocalizations.of(context).getText('available_now'),
//                                                                       style: FlutterTheme.of(context).titleSmall.override(
//                                                                         fontFamily: 'Urbanist',
//                                                                         color: Color(0xff4ADB06),
//                                                                         fontSize: 12
//                                                                       ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 5.8,
//                                                               ),
//                                                               Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
//                                                               Text(
//                                                                 " ${distance.toStringAsFixed(2)} km",
//                                                                 style: FlutterTheme.of(context).titleSmall.override(
//                                                                     fontFamily: 'Urbanist',
//                                                                     color: Color(0xff0D0C0F),fontSize: 10
//                                                                 ),
//                                                               ),
//                                                               Text(
//                                                                 "(${travelTime})",overflow: TextOverflow.ellipsis, style: FlutterTheme.of(context).titleSmall.override(
//                                                                 fontFamily: 'Urbanist',fontSize: 10,
//                                                                 color: Color(0xff7C8BA0),
//                                                               ),
//                                                               ),
//                                                             ],
//                                                           ),
// ///======commented part
//                                                           // InkWell(
//                                                           //   onTap: () {
//                                                           //     setState(() {
//                                                           //       if (_currentBooking!.data![item].favStatus.toString()=="0") {
//                                                           //         _currentBooking!.data![item].favStatus="1";
//                                                           //         Helper.checkInternet(favourite(_currentBooking!.data![item].carId.toString()));
//                                                           //       } else {
//                                                           //         _currentBooking!.data![item].favStatus="0";
//                                                           //         Helper.checkInternet(Unfavourite(_currentBooking!.data![item].carId.toString()));
//                                                           //       }
//                                                           //     });
//                                                           //     // setState(() {
//                                                           //     //   isFavourite = !isFavourite;
//                                                           //     // });
//                                                           //     //
//                                                           //     // if (isFavourite) {
//                                                           //     //   Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                           //     // } else {
//                                                           //     //   Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                           //     // }
//                                                           //   },
//                                                           //   child: SvgPicture.asset(
//                                                           //     _currentBooking!.data![item].favStatus=="1"
//                                                           //         ? 'assets/images/bookmark-03.svg'
//                                                           //         : 'assets/images/bookmark_outline-03.svg',
//                                                           //     width: 30.33,
//                                                           //     height: 28.5,
//                                                           //   ),
//                                                           // ),
//
//
//
//
//                                                           ///======commented part
//
//
//
//                                                           // InkWell(
//                                                           //   onTap: () {
//                                                           //     Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                           //   },
//                                                           //   child: SvgPicture.asset(
//                                                           //     'assets/images/bookmark-03.svg',
//                                                           //     width: 30.33,
//                                                           //     height: 28.5,
//                                                           //   ),
//                                                           // ),
//                                                           // InkWell(
//                                                           //   onTap: () {
//                                                           //     Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                           //   },
//                                                           //   child: SvgPicture.asset(
//                                                           //     'assets/images/bookmark_outline-03.svg',
//                                                           //     width: 30.33,
//                                                           //     height: 28.5,
//                                                           //   ),
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                       Image.network(
//                                                         _currentBooking!.data![item].carImage.toString(),
//                                                         width: 240.33,
//                                                         height: 130.5,
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                         children: [
//                                                           Column(
//                                                             mainAxisAlignment: MainAxisAlignment.start,
//                                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                                             children: [
//                                                               Text(
//                                                                 _currentBooking!.data![item].carName.toString(), style: FlutterTheme.of(context).titleSmall.override(
//                                                                 fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
//                                                                 color: Color(0xff7C8BA0),
//                                                               ),
//                                                               ),
//                                                               SizedBox(
//                                                                 height: 5,
//                                                               ),
//                                                               // Text(
//                                                               //   _currentBooking!.data![item].brandName.toString(), style: FlutterTheme.of(context).titleSmall.override(
//                                                               //   fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
//                                                               //   color: Color(0xff0D0C0F),
//                                                               // ),
//                                                               // ),
//                                                             ],
//
//                                                           ),
//                                                           Row(
//                                                             children: [
//                                                               Text(
//                                                                 "${FFLocalizations.of(context).getText('currency_symbol')}${_currentBooking!.data![item].carCost.toString()}",
//                                                                 style: FlutterTheme.of(context).titleSmall.override(
//                                                                   fontFamily: 'Urbanist',
//                                                                   color: Color(0xff0D0C0F),fontSize: 16
//                                                               ),
//                                                               ),
//                                                               Text(
//                                                                 FFLocalizations.of(context).getText('price_type_hourly'), style: FlutterTheme.of(context).titleSmall.override(
//                                                                 fontFamily: 'Urbanist',fontSize: 12,
//                                                                 color: Color(0xff7C8BA0),
//                                                               ),
//                                                               ),
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                       Divider(
//                                                         color: Color(0xffAD3CFD6),
//                                                         thickness: 0.5,
//                                                       ),
//                                                       SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                                         children: [
//                                                           Row(
//                                                             children: [
//                                                               SvgPicture.asset(
//                                                                 'assets/images/sedan.svg',
//                                                                 width: 18.33,
//                                                                 height: 16.5,
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 8.8,
//                                                               ),
//                                                               // Text(
//                                                               //   _catergorywiseCar!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
//                                                               //   fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
//                                                               //   color: Color(0xff7C8BA0),
//                                                               // ),
//                                                               // ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             children: [
//                                                               SvgPicture.asset(
//                                                                 'assets/images/diesel.svg',
//                                                                 width: 18.33,
//                                                                 height: 16.5,
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 8.8,
//                                                               ),
//                                                               // Text(
//                                                               //   _currentBooking!.data![item].specification.toString(), style: FlutterTheme.of(context).titleSmall.override(
//                                                               //   fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
//                                                               //   color: Color(0xff7C8BA0),
//                                                               // ),
//                                                               // ),
//                                                             ],
//                                                           ),
//                                                           Row(
//                                                             children: [
//                                                               SvgPicture.asset(
//                                                                 'assets/images/seater.svg',
//                                                                 width: 18.33,
//                                                                 height: 16.5,
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 8.8,
//                                                               ),
//                                                               Text(
//                                                                 "${_currentBooking!.data![item].carSeat.toString()} ${FFLocalizations.of(context).getText('seater')}", style: FlutterTheme.of(context).titleSmall.override(
//                                                                 fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
//                                                                 color: Color(0xff7C8BA0),
//                                                               ),
//                                                               ),
//                                                             ],
//                                                           ),
//
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                         );
//
//                                       },
//                                     );
//                                   } else {
//                                     return Align(
//                                       alignment:
//                                           AlignmentDirectional(0.00, 0.00),
//                                       child: Text(
//                                         FFLocalizations.of(context).getText(
//                                           't6bazqfn' /* No Booking Available ! */,
//                                         ),
//                                         style: FlutterTheme.of(context)
//                                             .bodyMedium,
//                                       ),
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           ),ListView.builder(
//                                   padding: EdgeInsets.zero,
//                                   scrollDirection: Axis.vertical,
//                                   itemCount: _currentBooking!.data!.length,
//                                   // itemCount: _allCategoryModel!.data!.length,
//                                   itemBuilder: (context, item) {
//                                     print(
//                                         "=====_allCategoryModel!.data!.length======${_currentBooking!.data!.length}");
//                                     double distance = calculateDistance(
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLat1
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLong1
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLat2
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLong2
//                                             .toString()));
//                                     String travelTime = calculateTravelTime(
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLat1
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLong1
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLat2
//                                             .toString()),
//                                         double.parse(_currentBooking!
//                                             .data![item].pickLong2
//                                             .toString()),
//                                         80);
//                                     // print("=====_isSelected2222=====${isSelected}");
//                                     // final category = _catergorywiseCar!.data![item];
//                                     // final imagePath = eachCategoryWithImages[category];
//                                     //  isSelected = _allCategoryModel!.data![item].categoryName;
//                                     //  print("====isSelected ghjegej===${isSelected}");
//                                     return InkWell(
//                                       onTap: () {
//                                         context.pushNamed(
//                                           'booking_detail_page',
//                                           queryParameters: {
//                                             'bookingId': _currentBooking!
//                                                 .data![item].bookingId
//                                                 .toString(),
//                                           }.withoutNulls,
//                                         );
//
//                                         // context.pushNamed(
//                                         //   'product_detail_page',
//                                         //   queryParameters: {
//                                         //     'carId': _currentBooking!
//                                         //         .data![item].carId
//                                         //         .toString()
//                                         //   }.withoutNulls,
//                                         // );
//                                         // context.pushNamed('product_detail_page');
//                                         // Helper.moveToScreenwithPush(context, ProductDetailPageWidget(hnmjh));
//                                         // Helper.checkInternet(categorywiselist(_allCategoryModel!.data![item].categoryName.toString()));
//                                       },
//                                       child: Container(
//                                         height: 270,
//                                         margin: EdgeInsets.only(right: 10),
//                                         width:
//                                             MediaQuery.of(context).size.width /
//                                                 1.1,
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border: Border.all(
//                                                 color: Color(0xffFAFAFA),
//                                                 width: 1.5)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Container(
//                                                         width: 72,
//                                                         height: 24,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color:
//                                                               Color(0xffFAF9FE),
//                                                           border: Border.all(
//                                                             color: Color(
//                                                                 0xff0D0C0F),
//                                                           ),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       8.0),
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       0.0,
//                                                                   vertical: 0),
//                                                           child: Row(
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: 5,
//                                                               ),
//                                                               Icon(
//                                                                 Icons.star,
//                                                                 size: 10,
//                                                                 color: Color(
//                                                                     0xffFFBB35),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 5,
//                                                               ),
//                                                               Text(
//                                                                 "4.7",
//                                                                 style: FlutterTheme.of(
//                                                                         context)
//                                                                     .titleSmall
//                                                                     .override(
//                                                                         fontFamily:
//                                                                             'Urbanist',
//                                                                         color: Color(
//                                                                             0xff0D0C0F),
//                                                                         fontSize:
//                                                                             12),
//                                                               ),
//                                                               Text(
//                                                                 "(109)",
//                                                                 style: FlutterTheme.of(
//                                                                         context)
//                                                                     .titleSmall
//                                                                     .override(
//                                                                       fontFamily:
//                                                                           'Urbanist',
//                                                                       fontSize:
//                                                                           12,
//                                                                       color: Color(
//                                                                           0xff7C8BA0),
//                                                                     ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 8.8,
//                                                       ),
//                                                       Container(
//                                                         width: 85,
//                                                         height: 24,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color:
//                                                               Color(0xff4ADB06)
//                                                                   .withOpacity(
//                                                                       0.06),
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(
//                                                                       6.0),
//                                                         ),
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       2.0,
//                                                                   vertical: 0),
//                                                           child: Center(
//                                                             child: Text(
//                                                               FFLocalizations.of(context).getText('available_now'),
//                                                               style: FlutterTheme
//                                                                       .of(
//                                                                           context)
//                                                                   .titleSmall
//                                                                   .override(
//                                                                       fontFamily:
//                                                                           'Urbanist',
//                                                                       color: Color(
//                                                                           0xff4ADB06),
//                                                                       fontSize:
//                                                                           12),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 5.8,
//                                                       ),
//                                                       Icon(
//                                                         Icons.directions_walk,
//                                                         color:
//                                                             Color(0xff7C8BA0),
//                                                         size: 12,
//                                                       ),
//                                                       Text(
//                                                         " ${distance.toStringAsFixed(2)} km",
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                                 fontFamily:
//                                                                     'Urbanist',
//                                                                 color: Color(
//                                                                     0xff0D0C0F),
//                                                                 fontSize: 10),
//                                                       ),
//                                                       Text(
//                                                         "(${travelTime})",
//                                                         overflow: TextOverflow
//                                                             .ellipsis,
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 10,
//                                                               color: Color(
//                                                                   0xff7C8BA0),
//                                                             ),
//                                                       ),
//                                                     ],
//                                                   ),
//
//                                                   ///======commented part
//                                                   InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         if (_currentBooking!
//                                                                 .data![item]
//                                                                 .favStatus
//                                                                 .toString() ==
//                                                             "0") {
//                                                           _currentBooking!
//                                                               .data![item]
//                                                               .favStatus = "1";
//                                                           Helper.checkInternet(
//                                                               favourite(
//                                                                   _currentBooking!
//                                                                       .data![
//                                                                           item]
//                                                                       .carId
//                                                                       .toString()));
//                                                         } else {
//                                                           _currentBooking!
//                                                               .data![item]
//                                                               .favStatus = "0";
//                                                           Helper.checkInternet(
//                                                               Unfavourite(
//                                                                   _currentBooking!
//                                                                       .data![
//                                                                           item]
//                                                                       .carId
//                                                                       .toString()));
//                                                         }
//                                                       });
//                                                       // setState(() {
//                                                       //   isFavourite = !isFavourite;
//                                                       // });
//                                                       //
//                                                       // if (isFavourite) {
//                                                       //   Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                       // } else {
//                                                       //   Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                       // }
//                                                     },
//                                                     child: SvgPicture.asset(
//                                                       _currentBooking!
//                                                                   .data![item]
//                                                                   .favStatus ==
//                                                               "1"
//                                                           ? 'assets/images/bookmark-03.svg'
//                                                           : 'assets/images/bookmark_outline-03.svg',
//                                                       width: 30.33,
//                                                       height: 28.5,
//                                                     ),
//                                                   ),
//
//                                                   ///======commented part
//
//                                                   // InkWell(
//                                                   //   onTap: () {
//                                                   //     Helper.checkInternet(favourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                   //   },
//                                                   //   child: SvgPicture.asset(
//                                                   //     'assets/images/bookmark-03.svg',
//                                                   //     width: 30.33,
//                                                   //     height: 28.5,
//                                                   //   ),
//                                                   // ),
//                                                   // InkWell(
//                                                   //   onTap: () {
//                                                   //     Helper.checkInternet(Unfavourite(_catergorywiseCar!.data![item].carId.toString()));
//                                                   //   },
//                                                   //   child: SvgPicture.asset(
//                                                   //     'assets/images/bookmark_outline-03.svg',
//                                                   //     width: 30.33,
//                                                   //     height: 28.5,
//                                                   //   ),
//                                                   // ),
//                                                 ],
//                                               ),
//                                               Image.network(
//                                                 _currentBooking!.data![item]
//                                                     .carImage![item].image
//                                                     .toString(),
//                                                 width: 240.33,
//                                                 height: 130.5,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Column(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     children: [
//                                                       Text(
//                                                         _currentBooking!
//                                                             .data![item].carName
//                                                             .toString(),
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Color(
//                                                                   0xff7C8BA0),
//                                                             ),
//                                                       ),
//                                                       SizedBox(
//                                                         height: 5,
//                                                       ),
//                                                       Text(
//                                                         _currentBooking!
//                                                             .data![item]
//                                                             .brandName
//                                                             .toString(),
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 16,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Color(
//                                                                   0xff0D0C0F),
//                                                             ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         "${FFLocalizations.of(context).getText('currency_symbol')}${_currentBooking!.data![item].tripCost.toString()}",
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                                 fontFamily:
//                                                                     'Urbanist',
//                                                                 color: Color(
//                                                                     0xff0D0C0F),
//                                                                 fontSize: 16),
//                                                       ),
//                                                       Text(
//                                                         FFLocalizations.of(context).getText('price_type_hourly'),
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 12,
//                                                               color: Color(
//                                                                   0xff7C8BA0),
//                                                             ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                               Divider(
//                                                 color: Color(0xffAD3CFD6),
//                                                 thickness: 0.5,
//                                               ),
//                                               SizedBox(
//                                                 height: 5,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/sedan.svg',
//                                                         width: 18.33,
//                                                         height: 16.5,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 8.8,
//                                                       ),
//                                                       // Text(
//                                                       //   _catergorywiseCar!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
//                                                       //   fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
//                                                       //   color: Color(0xff7C8BA0),
//                                                       // ),
//                                                       // ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/diesel.svg',
//                                                         width: 18.33,
//                                                         height: 16.5,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 8.8,
//                                                       ),
//                                                       Text(
//                                                         _currentBooking!
//                                                             .data![item]
//                                                             .specification
//                                                             .toString(),
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Color(
//                                                                   0xff7C8BA0),
//                                                             ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       SvgPicture.asset(
//                                                         'assets/images/seater.svg',
//                                                         width: 18.33,
//                                                         height: 16.5,
//                                                       ),
//                                                       SizedBox(
//                                                         width: 8.8,
//                                                       ),
//                                                       Text(
//                                                         "${_currentBooking!.data![item].carSeat.toString()} ${FFLocalizations.of(context).getText('seater')}",
//                                                         style: FlutterTheme.of(
//                                                                 context)
//                                                             .titleSmall
//                                                             .override(
//                                                               fontFamily:
//                                                                   'Urbanist',
//                                                               fontSize: 14,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w400,
//                                                               color: Color(
//                                                                   0xff7C8BA0),
//                                                             ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),

                        ///=========commenting part===========
                          _historyBooking == null
                              ? _hasData
                                  ? Container()
                                  : Container(
                                      child: Center(
                                        child: Text(FFLocalizations.of(context).getText('no_data')),
                                      ),
                                    )
                              : ListView.builder(
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.vertical,
                                  itemCount: _historyBooking!.data!.length,
                                  itemBuilder: (context, item) {
                                    return InkWell(
                                      onTap: () {
                                        context.pushNamed(
                                          'booking_detail_page',
                                          queryParameters: {
                                            'bookingId': _historyBooking!
                                                .data![item].bookingId
                                                .toString(),
                                          }.withoutNulls,
                                        );
                                      },
                                      child: Container(
                                        height: 270,
                                        margin: EdgeInsets.only(right: 10),
                                        width: MediaQuery.of(context).size.width / 1.1,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffFAFAFA),
                                            width: 1.5
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
                                                        child: Row(
                                                          children: [
                                                            SizedBox(width: 5),
                                                            Icon(Icons.star, size: 10, color: Color(0xffFFBB35)),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              _historyBooking!.data![item].rating!.toString() == "0.00"
                                                                  ? "5.0"
                                                                  : _historyBooking!.data![item].rating!.toString(),
                                                              style: FlutterTheme.of(context).titleSmall.override(
                                                                fontFamily: 'Urbanist',
                                                                color: Color(0xff0D0C0F),
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      _buildStatusContainer(
                                                        context, 
                                                        _historyBooking!.data![item].status,
                                                        isHistory: true
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (_historyBooking!.data![item].favStatus.toString() == "0") {
                                                          _historyBooking!.data![item].favStatus = "1";
                                                          Helper.checkInternet(favourite(_historyBooking!.data![item].carId.toString()));
                                                        } else {
                                                          _historyBooking!.data![item].favStatus = "0";
                                                          Helper.checkInternet(Unfavourite(_historyBooking!.data![item].carId.toString()));
                                                        }
                                                      });
                                                    },
                                                    child: SvgPicture.asset(
                                                      _historyBooking!.data![item].favStatus == "1"
                                                          ? 'assets/images/bookmark-03.svg'
                                                          : 'assets/images/bookmark_outline-03.svg',
                                                      width: 30.33,
                                                      height: 28.5,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Image.network(
                                                _historyBooking!.data![item].carImage![0].image ?? "",
                                                width: 240.33,
                                                height: 130.5,
                                                fit: BoxFit.cover,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _historyBooking!.data![item].carName ?? "",
                                                        style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400,
                                                          color: Color(0xff7C8BA0),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Text(
                                                        _historyBooking!.data![item].brandName ?? "",
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
                                                        "${FFLocalizations.of(context).getText('currency_symbol')}${_historyBooking!.data![item].carCost}/",
                                                        style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          color: Color(0xff0D0C0F),
                                                          fontSize: 14
                                                        ),
                                                      ),
                                                      Text(
                                                        FFLocalizations.of(context).getText('price_type_' + _historyBooking!.data![item].priceType.toString().toLowerCase()),
                                                        style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          fontSize: 14,
                                                          color: Color(0xff7C8BA0),
                                                        ),
                                                      ),
                                                      Text(
                                                        " - ",
                                                        style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          fontSize: 14,
                                                          color: Color(0xff7C8BA0),
                                                        ),
                                                      ),
                                                      Text(
                                                        "${FFLocalizations.of(context).getText('total_label')} ${FFLocalizations.of(context).getText('currency_symbol')}${_historyBooking!.data![item].tripCost}",
                                                        style: FlutterTheme.of(context).titleSmall.override(
                                                          fontFamily: 'Urbanist',
                                                          color: Color(0xff4ADB06),
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Color(0xffAD3CFD6),
                                                thickness: 0.5,
                                              ),
                                              SizedBox(height: 5),
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
                                                      SizedBox(width: 8.8),
                                                      Text(
                                                        _historyBooking!.data![item].vehicleCategory ?? "",
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
                                                      SizedBox(width: 8.8),
                                                      Text(
                                                        _historyBooking!.data![item].specification ?? "",
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
                                                      SizedBox(width: 8.8),
                                                      Text(
                                                        "${_historyBooking!.data![item].carSeat} ${FFLocalizations.of(context).getText('seater')}",
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ].addToEnd(SizedBox(height: 90.0)),
          ),
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

      print('Current Position: ${globalLatitude}, ${globalLongitude}');

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

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

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Radius of the Earth in kilometers
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);

    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = R * c; // Distance in kilometers

    return double.parse(distance.toStringAsFixed(2));
  }

  String calculateTravelTime(double lat1, double lon1, double lat2, double lon2,
      double averageSpeedKmH) {
    double distance = calculateDistance(lat1, lon1, lat2, lon2);
    double time = distance / averageSpeedKmH; // Time in hours

    int hours = time.floor();
    int minutes = ((time - hours) * 60).round();

    return "${hours}h ${minutes}m";
  }

  Future<void> currentBooking() async {
    print("<=============categorywiselist== hello===========>");

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
      var res = await http.post(Uri.parse(Apis.usercurrentBooking), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CurrentBooking model = CurrentBooking.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData = false;

            setState(() {
              _currentBooking = model;
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

  Future<void> historycurrentBooking() async {
    print("<=============historycurrentBooking== hello===========>");

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
      var res = await http.post(Uri.parse(Apis.userhistoryBooking), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          HistoryBooking model = HistoryBooking.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            setState(() {
              _historyBooking = model;
              _hasData = model.data == null || model.data!.isEmpty;
            });
            print("successs==============");
          } else {
            setProgress(false);
            setState(() {
              _hasData = false;
            });
            print("false ### ============>");
          }
        } catch (e) {
          print("false ============>");
          setProgress(false);
          setState(() {
            _hasData = false;
          });
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        setProgress(false);
        setState(() {
          _hasData = false;
        });
      }
    } catch (e) {
      print('Exception ======> ' + e.toString());
      setProgress(false);
      setState(() {
        _hasData = false;
      });
    }
  }
}
