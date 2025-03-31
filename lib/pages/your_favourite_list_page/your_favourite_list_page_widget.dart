import 'dart:math';

import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../constant.dart';
import '../../model/fav_list_model.dart';
import '../../model/fav_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'your_favourite_list_page_model.dart';
export 'your_favourite_list_page_model.dart';
import 'package:http/http.dart'as http;

class YourFavouriteListPageWidget extends StatefulWidget {
  const YourFavouriteListPageWidget({Key? key}) : super(key: key);

  @override
  _YourFavouriteListPageWidgetState createState() =>
      _YourFavouriteListPageWidgetState();
}

class _YourFavouriteListPageWidgetState
    extends State<YourFavouriteListPageWidget> {
  late YourFavouriteListPageModel _model;
  bool _hasData = true;
  bool _isVisible = false;
  FavListModel?_favListModel;
  AddFavourite? _addFavourite;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  String location = '';
  bool _isVisiblenew = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    _model = createModel(context, () => YourFavouriteListPageModel());
    Helper.checkInternet(fav_list());
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

    return FutureBuilder<ApiCallResponse>(
      future: BaseUrlGroup.favouritlistCall.call(
        userId: FFAppState().UserId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: SpinKitFadingGrid(
                  color: FlutterTheme.of(context).secondary,
                  size: 40.0,
                ),
              ),
            ),
          );
        }
        final yourFavouriteListPageFavouritlistResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterTheme.of(context).primaryBackground,
            // appBar: AppBar(
            //   backgroundColor: FlutterTheme.of(context).secondaryBackground,
            //   automaticallyImplyLeading: false,
            //   title: Text(
            //     FFLocalizations.of(context).getText(
            //       'wr75d95l' /* Favorite  */,
            //     ),
            //     style: FlutterTheme.of(context).headlineMedium.override(
            //           fontFamily: 'Urbanist',
            //           color: FlutterTheme.of(context).primaryText,
            //           fontSize: 18.0,fontWeight: FontWeight.w500
            //         ),
            //   ),
            //   actions: [],
            //   centerTitle: true,
            //   elevation: 2.0,
            // ),
            appBar: AppBar(
              backgroundColor: FlutterTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              // leading: InkWell(
              //   onTap: () {
              //     Helper.popScreen(context);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10.0,top: 15,right: 0,bottom: 10),
              //     child: Image.asset('assets/images/back_icon_with_bg.png',height: 30,width: 30,),
              //   ),
              // ),
              title: Text(
               "Saved Cars",
                style: FlutterTheme.of(context).headlineMedium.override(
                    fontFamily: 'Urbanist',
                    color: FlutterTheme.of(context).primaryText,
                    fontSize: 18.0,fontWeight: FontWeight.w600
                ),
              ),
              actions: [],
              centerTitle: true,
              // elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child:_favListModel == null
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
                itemCount: _favListModel!.data!.length,
                // itemCount: _allCategoryModel!.data!.length,
                itemBuilder: (context, item) {
                  print(
                      "=====_allCategoryModel!.data!.length======${_favListModel!.data!.length}");
                  double distance = calculateDistance(
                      double.parse(globalLatitude
                          .toString()),
                      double.parse(globalLongitude
                          .toString()),
                      double.parse(_favListModel!
                          .data![item].pickLat1
                          .toString()),
                      double.parse(_favListModel!
                          .data![item].pickLong1
                          .toString()));
                  String travelTime = calculateTravelTime(
                      double.parse(globalLatitude
                          .toString()),
                      double.parse(globalLongitude
                          .toString()),
                      double.parse(_favListModel!
                          .data![item].pickLat2
                          .toString()),
                      double.parse(_favListModel!
                          .data![item].pickLong2
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
                        'product_detail_page',
                        queryParameters: {
                          'carId':_favListModel !.data![item].carId.toString(),
                          'time':travelTime.toString(),
                          'distance': double.parse(distance.toString()).toString(),
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
                      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                                        color: Color(0xffFAF9FE
                                        ),
                                        border: Border.all(
                                          color: Color(0xff0D0C0F),
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(Icons.star,size: 10,color: Color(0xffFFBB35),),
                                            SizedBox(
                                              width: 5,
                                            ),

                                            Text(
                                              _favListModel!.data![item].rating!
                                                  .toString()=="0.00"?"5.0":_favListModel!.data![item].rating!
                                                  .toString(), style: FlutterTheme.of(context).titleSmall.override(
                                                fontFamily: 'Urbanist',
                                                color: Color(0xff0D0C0F),fontSize: 12
                                            ),
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
                                            "Available now",
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

                                ///======commented part
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (_favListModel!
                                          .data![item]
                                          .favStatus
                                          .toString() ==
                                          "0") {
                                        _favListModel!
                                            .data![item]
                                            .favStatus = "1";
                                        Helper.checkInternet(
                                            favourite(
                                                _favListModel!
                                                    .data![
                                                item]
                                                    .carId
                                                    .toString()));
                                      } else {
                                        _favListModel!
                                            .data![item]
                                            .favStatus = "0";
                                        Helper.checkInternet(
                                            Unfavourite(
                                                _favListModel!
                                                    .data![
                                                item]
                                                    .carId
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
                                    _favListModel!
                                        .data![item]
                                        .favStatus ==
                                        "1"
                                        ? 'assets/images/bookmark-03.svg'
                                        : 'assets/images/bookmark_outline-03.svg',
                                    width: 30.33,
                                    height: 28.5,
                                  ),
                                ),

                                ///======commented part

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
                              _favListModel!.data![item]
                                  .carImage![0].image
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
                                      _favListModel!
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
                                      _favListModel!
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
                                      "\$${_favListModel!.data![item].carCost.toString()}",
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
                                      _favListModel!
                                          .data![item]
                                          .priceType
                                          .toString(),
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
                                    // Text(
                                    //   _catergorywiseCar!.data![item].vehicleCategory.toString(), style: FlutterTheme.of(context).titleSmall.override(
                                    //   fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                    //   color: Color(0xff7C8BA0),
                                    // ),
                                    // ),
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
                                      _favListModel!
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
                                      "${_favListModel!.data![item].carSeat.toString()} Seater",
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

              // Builder(
              //   builder: (context) {
              //     if (BaseUrlGroup.favouritlistCall.response(
              //           yourFavouriteListPageFavouritlistResponse.jsonBody,
              //         ) ==
              //         true) {
              //       return Builder(
              //         builder: (context) {
              //           final eachFavourite = BaseUrlGroup.favouritlistCall
              //                   .favouriteList(
              //                     yourFavouriteListPageFavouritlistResponse
              //                         .jsonBody,
              //                   )
              //                   ?.toList() ??
              //               [];
              //           return ListView.separated(
              //             padding: EdgeInsets.fromLTRB(
              //               0,
              //               0,
              //               0,
              //               80.0,
              //             ),
              //             scrollDirection: Axis.vertical,
              //             itemCount: eachFavourite.length,
              //             separatorBuilder: (_, __) => SizedBox(height: 20.0),
              //             itemBuilder: (context, eachFavouriteIndex) {
              //               final eachFavouriteItem =
              //                   eachFavourite[eachFavouriteIndex];
              //               return Card(
              //                 clipBehavior: Clip.antiAliasWithSaveLayer,
              //                 color: FlutterTheme.of(context)
              //                     .secondaryBackground,
              //                 elevation: 4.0,
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8.0),
              //                 ),
              //                 child: Align(
              //                   alignment: AlignmentDirectional(0.00, 1.00),
              //                   child: Row(
              //                     mainAxisSize: MainAxisSize.max,
              //                     crossAxisAlignment: CrossAxisAlignment.end,
              //                     children: [
              //                       Column(
              //                         mainAxisSize: MainAxisSize.max,
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.center,
              //                         children: [
              //                           Card(
              //                             clipBehavior:
              //                                 Clip.antiAliasWithSaveLayer,
              //                             color: FlutterTheme.of(context)
              //                                 .secondaryBackground,
              //                             elevation: 4.0,
              //                             shape: RoundedRectangleBorder(
              //                               borderRadius:
              //                                   BorderRadius.circular(8.0),
              //                             ),
              //                             child: Padding(
              //                               padding:
              //                                   EdgeInsetsDirectional.fromSTEB(
              //                                       2.0, 2.0, 2.0, 2.0),
              //                               child: ClipRRect(
              //                                 borderRadius:
              //                                     BorderRadius.circular(8.0),
              //                                 child: Image.network(
              //                                   getJsonField(
              //                                     eachFavouriteItem,
              //                                     r'''$.car_image[0].image''',
              //                                   ),
              //                                   width: 175.0,
              //                                   height: 102.0,
              //                                   fit: BoxFit.cover,
              //                                 ),
              //                               ),
              //                             ),
              //                           ),
              //                           Row(
              //                             mainAxisSize: MainAxisSize.max,
              //                             children: [
              //                               Text(
              //                                 FFLocalizations.of(context)
              //                                     .getText(
              //                                   'rswwto66' /* $ */,
              //                                 ),
              //                                 style:
              //                                     FlutterTheme.of(context)
              //                                         .bodyMedium
              //                                         .override(
              //                                           fontFamily: 'Urbanist',
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .primaryText,
              //                                         ),
              //                               ),
              //                               Text(
              //                                 getJsonField(
              //                                   eachFavouriteItem,
              //                                   r'''$.car_cost''',
              //                                 ).toString(),
              //                                 style:
              //                                     FlutterTheme.of(context)
              //                                         .bodyMedium
              //                                         .override(
              //                                           fontFamily: 'Urbanist',
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .primaryText,
              //                                         ),
              //                               ),
              //                               Text(
              //                                 FFLocalizations.of(context)
              //                                     .getText(
              //                                   'e8zle783' /* / */,
              //                                 ),
              //                                 style:
              //                                     FlutterTheme.of(context)
              //                                         .bodyMedium
              //                                         .override(
              //                                           fontFamily: 'Urbanist',
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .primaryText,
              //                                         ),
              //                               ),
              //                               Text(
              //                                 getJsonField(
              //                                   eachFavouriteItem,
              //                                   r'''$.price_type''',
              //                                 ).toString(),
              //                                 style:
              //                                     FlutterTheme.of(context)
              //                                         .bodyMedium
              //                                         .override(
              //                                           fontFamily: 'Urbanist',
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .primaryText,
              //                                         ),
              //                               ),
              //                             ],
              //                           ),
              //                         ]
              //                             .divide(SizedBox(height: 8.0))
              //                             .addToEnd(SizedBox(height: 8.0)),
              //                       ),
              //                       Flexible(
              //                         child: Column(
              //                           mainAxisSize: MainAxisSize.max,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.end,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             Padding(
              //                               padding:
              //                                   EdgeInsetsDirectional.fromSTEB(
              //                                       0.0, 0.0, 8.0, 0.0),
              //                               child: Text(
              //                                 getJsonField(
              //                                   eachFavouriteItem,
              //                                   r'''$.car_name''',
              //                                 ).toString(),
              //                                 style:
              //                                     FlutterTheme.of(context)
              //                                         .bodyMedium
              //                                         .override(
              //                                           fontFamily: 'Urbanist',
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .primary,
              //                                         ),
              //                               ),
              //                             ),
              //                             Material(
              //                               color: Colors.transparent,
              //                               elevation: 1.0,
              //                               shape: RoundedRectangleBorder(
              //                                 borderRadius:
              //                                     BorderRadius.circular(12.5),
              //                               ),
              //                               child: Container(
              //                                 width: 60.0,
              //                                 height: 30.0,
              //                                 decoration: BoxDecoration(
              //                                   color:
              //                                       FlutterTheme.of(context)
              //                                           .secondaryBackground,
              //                                   borderRadius:
              //                                       BorderRadius.circular(12.5),
              //                                   shape: BoxShape.rectangle,
              //                                   border: Border.all(
              //                                     color: FlutterTheme.of(
              //                                             context)
              //                                         .warning,
              //                                     width: 1.0,
              //                                   ),
              //                                 ),
              //                                 child: Padding(
              //                                   padding: EdgeInsetsDirectional
              //                                       .fromSTEB(
              //                                           4.0, 4.0, 4.0, 4.0),
              //                                   child: Padding(
              //                                     padding: const EdgeInsets.only(left: 2.0,right: 2),
              //                                     child: Row(
              //                                       mainAxisSize:
              //                                           MainAxisSize.max,
              //                                       mainAxisAlignment:
              //                                           MainAxisAlignment.center,
              //                                       crossAxisAlignment:
              //                                           CrossAxisAlignment.center,
              //                                       children: [
              //                                         Icon(
              //                                           Icons.star_rate,
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .warning,
              //                                           size: 16.0,
              //                                         ),
              //                                         SizedBox(
              //                                           height: 0.0,
              //                                           child: VerticalDivider(
              //                                             width: 5.0,
              //                                             thickness: 1.0,
              //                                             color:
              //                                                 FlutterTheme.of(
              //                                                         context)
              //                                                     .accent4,
              //                                           ),
              //                                         ),
              //                                         Flexible(
              //                                           child: Text(
              //                                             getJsonField(
              //                                               eachFavouriteItem,
              //                                               r'''$.rating''',
              //                                             ).toString(),
              //                                             style:
              //                                                 FlutterTheme.of(
              //                                                         context)
              //                                                     .bodyMedium,
              //                                           ),
              //                                         ),
              //                                       ],
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                             Row(
              //                               mainAxisSize: MainAxisSize.max,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.end,
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.center,
              //                               children: [
              //                                 Expanded(
              //                                   child: FFButtonWidget(
              //                                     onPressed: () async {
              //                                       context.pushNamed(
              //                                         'product_detail_page',
              //                                         queryParameters: {
              //                                           'carId': serializeParam(
              //                                             getJsonField(
              //                                               eachFavouriteItem,
              //                                               r'''$.car_id''',
              //                                             ).toString(),
              //                                             ParamType.String,
              //                                           ),
              //                                         }.withoutNulls,
              //                                       );
              //                                     },
              //                                     text: FFLocalizations.of(
              //                                             context)
              //                                         .getText(
              //                                       '0uuzgdpj' /* Details */,
              //                                     ),
              //                                     options: FFButtonOptions(
              //                                       width: 120.0,
              //                                       height: 40.0,
              //                                       padding:
              //                                           EdgeInsetsDirectional
              //                                               .fromSTEB(24.0, 0.0,
              //                                                   24.0, 0.0),
              //                                       iconPadding:
              //                                           EdgeInsetsDirectional
              //                                               .fromSTEB(0.0, 0.0,
              //                                                   0.0, 0.0),
              //                                       color: FlutterTheme.of(
              //                                               context)
              //                                           .secondary,
              //                                       textStyle: FlutterTheme
              //                                               .of(context)
              //                                           .titleSmall
              //                                           .override(
              //                                             fontFamily:
              //                                                 'Urbanist',
              //                                             color: Colors.white,
              //                                           ),
              //                                       elevation: 3.0,
              //                                       borderSide: BorderSide(
              //                                         color: Colors.transparent,
              //                                         width: 1.0,
              //                                       ),
              //                                       borderRadius:
              //                                           BorderRadius.only(
              //                                         bottomLeft:
              //                                             Radius.circular(0.0),
              //                                         bottomRight:
              //                                             Radius.circular(16.0),
              //                                         topLeft:
              //                                             Radius.circular(16.0),
              //                                         topRight:
              //                                             Radius.circular(0.0),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                           ].divide(SizedBox(height: 8.0)),
              //                         ),
              //                       ),
              //                     ].divide(SizedBox(width: 12.0)),
              //                   ),
              //                 ),
              //               );
              //             },
              //           );
              //         },
              //       );
              //     } else {
              //       return Align(
              //         alignment: AlignmentDirectional(0.00, 0.00),
              //         child: Text(
              //           BaseUrlGroup.favouritlistCall
              //               .message(
              //                 yourFavouriteListPageFavouritlistResponse
              //                     .jsonBody,
              //               )
              //               .toString(),
              //           style: FlutterTheme.of(context).bodyMedium,
              //         ),
              //       );
              //     }
              //   },
              // ),
            ),
          ),
        );
      },
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
  double _toRadians(double degree) {
    return degree * pi / 180;
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
               Helper.checkInternet(fav_list());
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

  Future<void> fav_list() async {


    print("<============fav_list===========>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'user_id': FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.favouritlist), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          FavListModel model = FavListModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _favListModel=model;
              print("=====  _allCarsModel!.data!.length.toString()====${  _favListModel!.data!.length.toString()}");

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
}
