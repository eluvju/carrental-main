import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart'as http;
import '../../app_state.dart';
import '../../constant.dart';
import '../../flutter/flutter_model.dart';
import '../../flutter/internationalization.dart';
import '../../model/car_detail_model.dart';
import '../../polyline_screen.dart';
import '../booking_page/booking_page_widget.dart';
import '../login_page/login_page_widget.dart';
import '../more_filter_page/more_filter_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_google_map.dart'as gmaps;
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/custom_functions.dart' as functions;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_detail_page_model.dart';
export 'product_detail_page_model.dart';

class ProductDetailPageWidget extends StatefulWidget {
  const ProductDetailPageWidget({
    Key? key,
    String? carId,
    String? pickaddress,
    double? distance,
    double? lat,
    double? long,
    String? time,
  })  : this.carId = carId ?? '2',
        this.pickaddress = pickaddress ?? '',
        this.distance = distance ?? 0.0, // Default value for distance
        this.lat = lat ?? 0.0, // Default value for distance
        this.long = long ?? 0.0, // Default value for distance
        this.time = time ?? '00:00', // Default value for time
        super(key: key);

  final String carId;
  final String pickaddress;
  final double distance;
  final double lat;
  final double long;
  final String time;

  @override
  _ProductDetailPageWidgetState createState() =>
      _ProductDetailPageWidgetState();
}

class _ProductDetailPageWidgetState extends State<ProductDetailPageWidget> {
  late ProductDetailPageModel _model;
  String location = "Search Location";
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isExpanded = false;
  CarDetailsModel?_carDetailsModel;
  LatLng startLocation = LatLng(0, 0);
  bool _isVisible = false;
  bool _isVisiblenew = false;
  // Assuming these values are obtained from the API response
  final double latitude = 37.77483;  // Replace with your latitude
  final double longitude = -122.41942;
  bool _hasData = true;
  GoogleMapController? _mapController;
  // Example coordinates (San Francisco)

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailPageModel());
    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //   _model.apiResulttsa = await BaseUrlGroup.carDetailCall.call(
    //     carId: widget.carId,
    //     userId: FFAppState().UserId,
    //   );
    //   if ((_model.apiResulttsa?.succeeded ?? true)) {
    //
    //     print("=======${getJsonField(
    //       (_model.apiResulttsa?.jsonBody ?? ''),
    //       r'''$.data.status''',
    //     )}");
    //     setState(() {
    //       _model.isFavourite = getJsonField(
    //         (_model.apiResulttsa?.jsonBody ?? ''),
    //         r'''$.data.status''',
    //       );
    //     });
    //   }
    //
    // });
    getCurrentLocation();
    Helper.checkInternet(cardetails());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LatLng _initialPosition = LatLng(widget.lat, widget.long);
    // if (isiOS) {
    //   SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(
    //       statusBarBrightness: Theme.of(context).brightness,
    //       systemStatusBarContrastEnforced: true,
    //     ),
    //   );
    // }

    context.watch<FFAppState>();

    // return FutureBuilder<ApiCallResponse>(
    //   future: BaseUrlGroup.carDetailCall.call(
    //     carId: widget.carId,
    //     userId: FFAppState().UserId,
    //   ),
    // builder: (context, snapshot) {
    //   // Customize what your widget looks like when it's loading.
    //   if (!snapshot.hasData) {
    //     return Scaffold(
    //       backgroundColor: FlutterTheme.of(context).primaryBackground,
    //       body: Center(
    //         child: Padding(
    //           padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
    //           child: SizedBox(
    //             width: 40.0,
    //             height: 40.0,
    //             child: SpinKitPulse(
    //               color: FlutterTheme.of(context).secondary,
    //               size: 40.0,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    //   final productDetailPageCarDetailResponse = snapshot.data!;
    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
            : FocusScope.of(context).unfocus(),
        child: Scaffold(
          key: scaffoldKey,
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
            title: Text("Car Details",
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
          resizeToAvoidBottomInset: false,
          backgroundColor: FlutterTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                _carDetailsModel==null
                    ? _hasData
                    ? Container()
                    : Container(
                  child: Center(
                    child: Text("NO DATA"),
                  ),
                ):
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        12.0, 0.0, 12.0, 0.0),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Align(
                          //   alignment: AlignmentDirectional(0.00, 1.00),
                          //   child: Stack(
                          //     alignment: AlignmentDirectional(0.0, 1.0),
                          //     children: [
                          //       Container(
                          //         width: double.infinity,
                          //         height: 299.0,
                          //         decoration: BoxDecoration(
                          //           color: Color(0xFFDCD2FF),
                          //         ),
                          //         child: Padding(
                          //           padding: EdgeInsetsDirectional.fromSTEB(
                          //               16.0, 16.0, 16.0, 16.0),
                          //           child: Column(
                          //             mainAxisSize: MainAxisSize.min,
                          //             children: [
                          //               Row(
                          //                 mainAxisSize: MainAxisSize.max,
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   FlutterIconButton(
                          //                     borderColor: Colors.transparent,
                          //                     borderRadius: 20.0,
                          //                     borderWidth: 0.0,
                          //                     buttonSize: 40.0,
                          //                     fillColor: FlutterTheme.of(context)
                          //                         .secondary,
                          //                     icon: Icon(
                          //                       Icons.chevron_left,
                          //                       color: FlutterTheme.of(context)
                          //                           .primaryBtnText,
                          //                       size: 24.0,
                          //                     ),
                          //                     onPressed: () async {
                          //                       context.safePop();
                          //                     },
                          //                   ),
                          //                   FlutterIconButton(
                          //                     borderColor: Colors.transparent,
                          //                     borderRadius: 20.0,
                          //                     borderWidth: 0.0,
                          //                     buttonSize: 40.0,
                          //                     fillColor: valueOrDefault<Color>(
                          //                       _model.isFavourite.toString() == '1'
                          //                           ? Colors.white
                          //                           : FlutterTheme.of(context)
                          //                               .error,
                          //                       FlutterTheme.of(context)
                          //                           .secondary,
                          //                     ),
                          //                     icon: Icon(
                          //                       Icons.favorite,
                          //                       color: valueOrDefault<Color>(
                          //                         _model.isFavourite.toString() == '1'
                          //                             ? FlutterTheme.of(context)
                          //                                 .error
                          //                             : Colors.white,
                          //                         FlutterTheme.of(context)
                          //                             .customColor1,
                          //                       ),
                          //                       size: 24.0,
                          //                     ),
                          //                     onPressed: () async {
                          //                       print("===_model.isFavourite.toString()===${_model.isFavourite.toString()}");
                          //                       if (_model.isFavourite.toString() ==
                          //                           '1') {
                          //                         _model.unresponseData =
                          //                             await BaseUrlGroup
                          //                                 .unfavouriteCall
                          //                                 .call(
                          //                           userId: FFAppState().UserId,
                          //                           carId: widget.carId,
                          //                         );
                          //                         if (getJsonField(
                          //                           (_model.unresponseData
                          //                                   ?.jsonBody ??
                          //                               ''),
                          //                           r'''$.response''',
                          //                         )) {
                          //                           setState(() {
                          //                             _model.isFavourite = "0";
                          //                           });
                          //                         }
                          //                       } else {
                          //                         _model.addFavouriteResponse =
                          //                             await BaseUrlGroup
                          //                                 .addfavouriteCall
                          //                                 .call(
                          //                           userId: FFAppState().UserId,
                          //                           carId: widget.carId,
                          //                         );
                          //                         if (BaseUrlGroup.addfavouriteCall
                          //                             .response(
                          //                           (_model.addFavouriteResponse
                          //                                   ?.jsonBody ??
                          //                               ''),
                          //                         )) {
                          //                           setState(() {
                          //                             _model.isFavourite = "1";
                          //                           });
                          //                         }
                          //                       }
                          //
                          //                       setState(() {});
                          //                     },
                          //                   ),
                          //                 ],
                          //               ),
                          //               ClipRRect(
                          //                 borderRadius: BorderRadius.circular(8.0),
                          //                 child: Image.network(
                          //                   BaseUrlGroup.carDetailCall
                          //                       .carImage(
                          //                     productDetailPageCarDetailResponse
                          //                         .jsonBody,
                          //                   )
                          //                       .toString(),
                          //                   // valueOrDefault<String>(
                          //                   //   BaseUrlGroup.carDetailCall.carImage(
                          //                   //     productDetailPageCarDetailResponse
                          //                   //         .jsonBody,
                          //                   //   ),
                          //                   //   'https://images.unsplash.com/photo-1583121274602-3e2820c69888?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxjYXJzfGVufDB8fHx8MTY5NTEyOTg2N3ww&ixlib=rb-4.0.3&q=80&w=1080',
                          //                   // ),
                          //                   width: 320.0,
                          //                   height: 216.0,
                          //                   fit: BoxFit.contain,
                          //                 ),
                          //               ),
                          //             ].divide(SizedBox(height: 8.0)),
                          //           ),
                          //         ),
                          //       ),
                          //       Align(
                          //         alignment: AlignmentDirectional(0.00, 1.00),
                          //         child: Material(
                          //           color: Colors.transparent,
                          //           elevation: 4.0,
                          //           shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(20.0),
                          //           ),
                          //           child: Container(
                          //             width: 226.0,
                          //             height: 40.0,
                          //             decoration: BoxDecoration(
                          //               color: FlutterTheme.of(context).error,
                          //               borderRadius: BorderRadius.circular(20.0),
                          //               border: Border.all(
                          //                 color: FlutterTheme.of(context)
                          //                     .primaryBtnText,
                          //                 width: 3.0,
                          //               ),
                          //             ),
                          //             alignment: AlignmentDirectional(1.00, 1.00),
                          //             child: Align(
                          //               alignment: AlignmentDirectional(0.00, 0.00),
                          //               child: Padding(
                          //                 padding: EdgeInsetsDirectional.fromSTEB(
                          //                     1.0, 1.0, 1.0, 1.0),
                          //                 child: Row(
                          //                   mainAxisSize: MainAxisSize.min,
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.center,
                          //                   children: [
                          //                     Expanded(
                          //                       child: Text(
                          //                         FFLocalizations.of(context).getText(
                          //                           '1wk0pwmi' /* $ */,
                          //                         ),
                          //                         textAlign: TextAlign.end,
                          //                         style: FlutterTheme.of(context)
                          //                             .bodyMedium
                          //                             .override(
                          //                               fontFamily: 'Urbanist',
                          //                               color: FlutterTheme.of(
                          //                                       context)
                          //                                   .primaryBtnText,
                          //                             ),
                          //                       ),
                          //                     ),
                          //                     Text(
                          //                       BaseUrlGroup.carDetailCall
                          //                           .carCost(
                          //                             productDetailPageCarDetailResponse
                          //                                 .jsonBody,
                          //                           )
                          //                           .toString(),
                          //                       textAlign: TextAlign.center,
                          //                       style: FlutterTheme.of(context)
                          //                           .bodyMedium
                          //                           .override(
                          //                             fontFamily: 'Urbanist',
                          //                             color:
                          //                                 FlutterTheme.of(context)
                          //                                     .primaryBtnText,
                          //                           ),
                          //                     ),
                          //                     Text(
                          //                       FFLocalizations.of(context).getText(
                          //                         'gdgk4la9' /* / */,
                          //                       ),
                          //                       textAlign: TextAlign.center,
                          //                       style: FlutterTheme.of(context)
                          //                           .bodyMedium
                          //                           .override(
                          //                             fontFamily: 'Urbanist',
                          //                             color:
                          //                                 FlutterTheme.of(context)
                          //                                     .primaryBtnText,
                          //                           ),
                          //                     ),
                          //                     Expanded(
                          //                       child: Text(
                          //                         BaseUrlGroup.carDetailCall
                          //                             .pricetype(
                          //                               productDetailPageCarDetailResponse
                          //                                   .jsonBody,
                          //                             )
                          //                             .toString(),
                          //                         textAlign: TextAlign.start,
                          //                         style: FlutterTheme.of(context)
                          //                             .bodyMedium
                          //                             .override(
                          //                               fontFamily: 'Urbanist',
                          //                               color: FlutterTheme.of(
                          //                                       context)
                          //                                   .primaryBtnText,
                          //                             ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          // Padding(
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 0.0),
                          //   child: Container(
                          //     width: double.infinity,
                          //     height: 50.0,
                          //     decoration: BoxDecoration(),
                          //     child: Column(
                          //       mainAxisSize: MainAxisSize.min,
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           mainAxisSize: MainAxisSize.min,
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             // Text(
                          //             //   valueOrDefault<String>(
                          //             //     BaseUrlGroup.carDetailCall
                          //             //         .carMenufacture(
                          //             //           productDetailPageCarDetailResponse
                          //             //               .jsonBody,
                          //             //         )
                          //             //         .toString(),
                          //             //     'Tesla',
                          //             //   ),
                          //             //   textAlign: TextAlign.start,
                          //             //   style: FlutterTheme.of(context)
                          //             //       .bodyMedium
                          //             //       .override(
                          //             //         fontFamily: 'Urbanist',
                          //             //         fontSize: 20.0,
                          //             //         fontWeight: FontWeight.bold,
                          //             //       ),
                          //             // ),
                          //             Text(
                          //               BaseUrlGroup.carDetailCall
                          //                   .carName(
                          //                     productDetailPageCarDetailResponse
                          //                         .jsonBody,
                          //                   )
                          //                   .toString(),
                          //               textAlign: TextAlign.start,
                          //               style: FlutterTheme.of(context)
                          //                   .bodyMedium
                          //                   .override(
                          //                     fontFamily: 'Urbanist',
                          //                     fontSize: 20.0,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //             ),
                          //             Expanded(
                          //               child: Text(
                          //                 BaseUrlGroup.carDetailCall
                          //                     .carmake(
                          //                       productDetailPageCarDetailResponse
                          //                           .jsonBody,
                          //                     )
                          //                     .toString(),
                          //                 textAlign: TextAlign.start,
                          //                 style: FlutterTheme.of(context)
                          //                     .bodyMedium
                          //                     .override(
                          //                       fontFamily: 'Urbanist',
                          //                       fontSize: 20.0,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //               ),
                          //             ),
                          //           ].divide(SizedBox(width: 4.0)),
                          //         ),
                          //         Flexible(
                          //           child: Text(
                          //             BaseUrlGroup.carDetailCall
                          //                 .pick_address1(
                          //               productDetailPageCarDetailResponse
                          //                   .jsonBody,
                          //             )
                          //                 .toString(),
                          //             style: FlutterTheme.of(context).bodyMedium,
                          //           ),
                          //         ),
                          //         // Expanded(
                          //         //   child: Row(
                          //         //     mainAxisSize: MainAxisSize.min,
                          //         //     children: [
                          //         //       RatingBarIndicator(
                          //         //         itemBuilder: (context, index) => Icon(
                          //         //           Icons.star_rounded,
                          //         //           color:
                          //         //               FlutterTheme.of(context).warning,
                          //         //         ),
                          //         //         direction: Axis.horizontal,
                          //         //         rating: functions.newstringToDouble(
                          //         //             BaseUrlGroup.carDetailCall
                          //         //                 .rating(
                          //         //                   productDetailPageCarDetailResponse
                          //         //                       .jsonBody,
                          //         //                 )
                          //         //                 .toString())!,
                          //         //         unratedColor:
                          //         //             FlutterTheme.of(context).accent3,
                          //         //         itemCount: 5,
                          //         //         itemSize: 20.0,
                          //         //       ),
                          //         //       Text(
                          //         //         BaseUrlGroup.carDetailCall
                          //         //             .totalRating(
                          //         //               productDetailPageCarDetailResponse
                          //         //                   .jsonBody,
                          //         //             )
                          //         //             .toString(),
                          //         //         style:
                          //         //             FlutterTheme.of(context).bodyMedium,
                          //         //       ),
                          //         //     ],
                          //         //   ),
                          //         // ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: Container(
                              height: 161.2,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 157.2,
                                    width: MediaQuery.of(context).size.width / 2.8,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        _carDetailsModel!.data!.carImage![0].image.toString(),
                                        // BaseUrlGroup.carDetailCall.carImage(
                                        //   productDetailPageCarDetailResponse.jsonBody,
                                        // )[0].toString(),
                                        fit: BoxFit.cover, // Use BoxFit.cover or BoxFit.fill
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 157.2,
                                    width: MediaQuery.of(context).size.width / 1.9,
                                    child: GridView.builder(
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // Number of columns in the grid
                                        crossAxisSpacing: 5, // Spacing between columns
                                        mainAxisSpacing: 5, // Spacing between rows
                                        childAspectRatio: 2.6 / 2, // Aspect ratio for each item
                                      ),
                                      // itemCount: BaseUrlGroup.carDetailCall.carImage(
                                      //   productDetailPageCarDetailResponse.jsonBody,
                                      // ).length - 1, // Exclude the 0th index
                                      itemCount:  _carDetailsModel!.data!.carImage!.length-1,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(20),
                                            child: Image.network(
                                              _carDetailsModel!.data!.carImage![index + 1].image.toString(), // Start from the 1st index
                                              fit: BoxFit.cover, // Use BoxFit.cover or BoxFit.fill
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            _carDetailsModel!.data!.rating!
                                                .toString()=="0.00"?"5.0":_carDetailsModel!.data!.rating!.toString(), style: FlutterTheme.of(context).titleSmall.override(
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
                                ],
                              ),
                              SizedBox(
                                width: 8.8,
                              ),
                              // Row(
                              //   children: [
                              //     Container(
                              //       height: 26,
                              //       width: 101,
                              //       decoration: BoxDecoration(
                              //         color: Colors.grey.withOpacity(0.2),
                              //         borderRadius: BorderRadius.circular(5)
                              //       ),
                              //       child: Row(
                              //         mainAxisAlignment: MainAxisAlignment.center,
                              //         crossAxisAlignment: CrossAxisAlignment.center,
                              //         children: [
                              //           Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
                              //           Text(
                              //            widget.distance.toString(), style: FlutterTheme.of(context).titleSmall.override(
                              //               fontFamily: 'Urbanist',
                              //               color: Color(0xff0D0C0F),fontSize: 12,fontWeight: FontWeight.w600
                              //           ),
                              //           ),
                              //           Text(
                              //            " ( ${widget.time})" ,style: FlutterTheme.of(context).titleSmall.override(
                              //             fontFamily: 'Urbanist',fontSize: 12,
                              //             color: Color(0xff7C8BA0),fontWeight: FontWeight.w400
                              //           ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: FlutterTheme.of(context).ashGray,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _carDetailsModel!.data!.carName!
                                        .toString(), style: FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                    color: Color(0xff7C8BA0),
                                  ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    _carDetailsModel!.data!.brandName!
                                        .toString(), style: FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w600,
                                    color: Color(0xff0D0C0F),
                                  ),
                                  ),
                                ],

                              ),
                              Row(
                                children: [
                                  Text(
                                    "\$${  _carDetailsModel!.data!.carCost!
                                        .toString()}", style: FlutterTheme.of(context).titleSmall.override(
                                      fontFamily: 'Urbanist',
                                      color: Color(0xff0D0C0F),fontSize: 16
                                  ),
                                  ),
                                  Text(
                                    "/${    _carDetailsModel!.data!.priceType!
                                        .toString()}",

                                    style: FlutterTheme.of(context).titleSmall.override(
                                      fontFamily: 'Urbanist',fontSize: 12,
                                      color: Color(0xff7C8BA0),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Owner Details",textAlign: TextAlign.start,
                                style: FlutterTheme.of(context).titleSmall.override(
                                  fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      _carDetailsModel!.data!.userProfile!
                                          .toString()==""?
                                      Image.asset('assets/images/default_profile_image.png',height: 42,width: 42,):
                                      ClipOval(
                                        child: Image.network( _carDetailsModel!.data!.userProfile!
                                            .toString(),height: 42,width: 42,),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Owned by",
                                            style: FlutterTheme.of(context).titleSmall.override(
                                              fontFamily: 'Urbanist',fontSize: 14,fontWeight: FontWeight.w400,
                                              color: Color(0xff7C8BA0),
                                            ),
                                          ),
                                          Text(
                                            _carDetailsModel!.data!.userName!
                                                .toString(),
                                            style: FlutterTheme.of(context).titleSmall.override(
                                              fontFamily: 'Urbanist',fontSize: 18,fontWeight: FontWeight.w400,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // SvgPicture.asset(
                                  //   'assets/images/check_orange.svg',
                                  //   width: 25,
                                  //   height: 25,
                                  // ),
                                  // Icon(Icons.check_circle,color: FlutterTheme.of(context).secondary,)
                                ],
                              ),
                            ],
                          ),

                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Car Location",textAlign: TextAlign.start,
                                  style: FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 58,
                                      width: MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        _carDetailsModel!.data!.pickAddress1!
                                            .toString(),textAlign: TextAlign.start,
                                        style: FlutterTheme.of(context).titleSmall.override(
                                            fontFamily: 'Urbanist',fontSize: 13,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                        ),
                                      ),
                                    ),
                                    Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () {
                                                print("hellloooo======");
                                                Helper.moveToScreenwithPush(context, Helper.moveToScreenwithPush(context, YourMapWidget(
                                                  pick_lat:
                                                  double.parse(startLocation.latitude.toString()),
                                                  pick_long: double.parse(   startLocation.longitude.toString()),
                                                  drop_lat: double.parse(     _carDetailsModel!.data!.pickLat1!
                                                      .toString(),),
                                                  drop_long: double.parse(    _carDetailsModel!.data!.pickLong1!
                                                      .toString(),), )));
                                              },
                                              child: Container(
                                                width: 104,
                                                height: 58,
                                                child: InkWell(
                                                  onTap: () {
                                                    print("hellloooo======");
                                                    Helper.moveToScreenwithPush(context, YourMapWidget(

                                                      pick_lat:
                                                      double.parse(startLocation.latitude.toString()),
                                                      pick_long: double.parse(   startLocation.longitude.toString()),
                                                      drop_lat: double.parse(     _carDetailsModel!.data!.pickLat1!
                                                          .toString(),),
                                                      drop_long: double.parse(    _carDetailsModel!.data!.pickLong1!
                                                          .toString(),), ));
                                                  },
                                                  child: GoogleMap(
                                                    zoomControlsEnabled: false, // Disable zoom controls
                                                    onMapCreated: (GoogleMapController controller) {
                                                      _mapController = controller;
                                                    },
                                                    initialCameraPosition: CameraPosition(
                                                      target: _initialPosition,
                                                      zoom: 14.0,
                                                    ),
                                                    // No markers are added here
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                print("hellloooo======");
                                                Helper.moveToScreenwithPush(context, YourMapWidget(

                                                pick_lat:
                                                double.parse(startLocation.latitude.toString()),
                                                pick_long: double.parse(   startLocation.longitude.toString()),
                                                drop_lat: double.parse(     _carDetailsModel!.data!.pickLat1!
                                                    .toString(),),
                                                drop_long: double.parse(    _carDetailsModel!.data!.pickLong1!
                                                    .toString(),), ));
                                              },
                                              child: Icon(Icons.location_on_outlined)
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Car Details",textAlign: TextAlign.start,
                                      style: FlutterTheme.of(context).titleSmall.override(
                                        fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     setState(() {
                                    //       isExpanded = !isExpanded;
                                    //     });
                                    //   },
                                    //   child: Row(
                                    //     children: [
                                    //       Text(
                                    //         isExpanded ? "View Less" : "View More",
                                    //         textAlign: TextAlign.start,
                                    //         style: GoogleFonts.raleway(
                                    //             fontSize: 16,
                                    //             decoration: TextDecoration.underline,
                                    //             color: FlutterTheme.of(context).secondary,
                                    //             decorationColor:  FlutterTheme.of(context).secondary,decorationThickness: 1, // Underline color
                                    //             fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                    //         ),
                                    //       ),
                                    //       SizedBox(
                                    //         width: 5,
                                    //       ),
                                    //       isExpanded ?  SvgPicture.asset(
                                    //         'assets/images/view_less.svg',
                                    //         width: 6,
                                    //         height: 10,
                                    //       ) :SvgPicture.asset(
                                    //         'assets/images/view_more.svg',
                                    //         width: 6,
                                    //         height: 10,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Descriptions",textAlign: TextAlign.start,
                                          style: FlutterTheme.of(context).titleSmall.override(
                                            fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        _carDetailsModel!.data!.description!
                                            .toString(),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontFamily: 'Urbanist',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff7C8BA0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Divider(
                                  color: Color(0xff64748B3B).withOpacity(0.23),
                                  thickness: 1,
                                ),
                                // if (isExpanded)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'hv7ydtqz' /* Features */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                              height:10
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Automatic transmission  ",
                                                // FFLocalizations.of(context).getText(
                                                //   'y90sqru4' /* Automatic transmission: Yes */,
                                                // ),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.automaticTransmission!

                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Car Color  ",
                                                // FFLocalizations.of(context).getText(
                                                //   'y90sqru4' /* Automatic transmission: Yes */,
                                                // ),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.carColour!

                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Vehicle Number  ",
                                                // FFLocalizations.of(context).getText(
                                                //   'y90sqru4' /* Automatic transmission: Yes */,
                                                // ),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.carNumber!

                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Air bags  ",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.airBooking!
                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Vehicle Category ",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.vehicle_category!
                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Safety rating : ",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.safetyRaring!
                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Seats ",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.seatCapacity!
                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Color(0xff64748B3B).withOpacity(0.23),
                                            thickness: 1,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Specification ",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                              Text(
                                                _carDetailsModel!.data!.specification!
                                                    .toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:10
                                          ),
                                        ]
                                    ),
                                  ),
                                // Flexible(
                                //   child: Align(
                                //     alignment: AlignmentDirectional(-1.00, 0.00),
                                //     child: Padding(
                                //       padding: EdgeInsetsDirectional.fromSTEB(
                                //           12.0, 0.0, 12.0, 0.0),
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             FFLocalizations.of(context).getText(
                                //               'mk4g2ktn' /* Descriptions */,
                                //             ),
                                //             style: FlutterTheme.of(context)
                                //                 .bodyMedium
                                //                 .override(
                                //                   fontFamily: 'Urbanist',
                                //                   fontSize: 20.0,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //           ),
                                //           AutoSizeText(
                                //             BaseUrlGroup.carDetailCall
                                //                 .description(
                                //                   productDetailPageCarDetailResponse
                                //                       .jsonBody,
                                //                 )
                                //                 .toString(),
                                //             textAlign: TextAlign.start,
                                //             maxLines: 200,
                                //             style: FlutterTheme.of(context)
                                //                 .bodyMedium
                                //                 .override(
                                //                   fontFamily: 'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight: FontWeight.w500,
                                //                 ),
                                //           ),
                                //         ].divide(SizedBox(height: 12.0)),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Flexible(
                                //   child: Align(
                                //     alignment: AlignmentDirectional(-1.00, 0.00),
                                //     child: Padding(
                                //       padding: EdgeInsetsDirectional.fromSTEB(
                                //           12.0, 0.0, 12.0, 0.0),
                                //       child: Column(
                                //         mainAxisSize: MainAxisSize.min,
                                //         mainAxisAlignment: MainAxisAlignment.center,
                                //         crossAxisAlignment: CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             FFLocalizations.of(context).getText(
                                //               'ri8keepz' /* Specification */,
                                //             ),
                                //             style: FlutterTheme.of(context)
                                //                 .bodyMedium
                                //                 .override(
                                //                   fontFamily: 'Urbanist',
                                //                   fontSize: 20.0,
                                //                   fontWeight: FontWeight.bold,
                                //                 ),
                                //           ),
                                //           AutoSizeText(
                                //             BaseUrlGroup.carDetailCall
                                //                 .specification(
                                //                   productDetailPageCarDetailResponse
                                //                       .jsonBody,
                                //                 )
                                //                 .toString(),
                                //             textAlign: TextAlign.start,
                                //             maxLines: 200,
                                //             style: FlutterTheme.of(context)
                                //                 .bodyMedium
                                //                 .override(
                                //                   fontFamily: 'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight: FontWeight.w500,
                                //                 ),
                                //           ),
                                //         ].divide(SizedBox(height: 12.0)),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         FFLocalizations.of(context).getText(
                                //           '9ljxt6nm' /* Where to find */,
                                //         ),
                                //         style: FlutterTheme.of(context)
                                //             .bodyMedium
                                //             .override(
                                //               fontFamily: 'Urbanist',
                                //               fontSize: 20.0,
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //       ),
                                //       Container(
                                //         width: double.infinity,
                                //         height: 250.0,
                                //         decoration: BoxDecoration(
                                //           color: FlutterTheme.of(context)
                                //               .secondaryBackground,
                                //         ),
                                //         child: FlutterGoogleMap(
                                //           controller: _model.googleMapsController,
                                //           onCameraIdle: (latLng) =>
                                //               _model.googleMapsCenter = latLng,
                                //           initialLocation: _model.googleMapsCenter ??=
                                //               LatLng(13.106061, -59.613158),
                                //           markerColor: GoogleMarkerColor.violet,
                                //           mapType: MapType.normal,
                                //           style: GoogleMapStyle.standard,
                                //           initialZoom: 14.0,
                                //           allowInteraction: true,
                                //           allowZoom: true,
                                //           showZoomControls: true,
                                //           showLocation: true,
                                //           showCompass: false,
                                //           showMapToolbar: false,
                                //           showTraffic: false,
                                //           centerMapOnMarkerTap: true,
                                //         ),
                                //       ),
                                //     ].divide(SizedBox(height: 12.0)),
                                //   ),
                                // ),
                                // Padding(
                                //   padding:
                                //       EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.min,
                                //     mainAxisAlignment: MainAxisAlignment.center,
                                //     crossAxisAlignment: CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         FFLocalizations.of(context).getText(
                                //           'pvhvrom9' /* Similar Vehicles  */,
                                //         ),
                                //         style: FlutterTheme.of(context)
                                //             .bodyMedium
                                //             .override(
                                //               fontFamily: 'Urbanist',
                                //               fontSize: 20.0,
                                //               fontWeight: FontWeight.bold,
                                //             ),
                                //       ),
                                //       Card(
                                //         clipBehavior: Clip.antiAliasWithSaveLayer,
                                //         color: FlutterTheme.of(context)
                                //             .secondaryBackground,
                                //         elevation: 4.0,
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius: BorderRadius.circular(8.0),
                                //         ),
                                //         child: Align(
                                //           alignment: AlignmentDirectional(0.00, 1.00),
                                //           child: Row(
                                //             mainAxisSize: MainAxisSize.max,
                                //             crossAxisAlignment: CrossAxisAlignment.end,
                                //             children: [
                                //               Expanded(
                                //                 child: Column(
                                //                   mainAxisSize: MainAxisSize.max,
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.center,
                                //                   children: [
                                //                     Card(
                                //                       clipBehavior:
                                //                           Clip.antiAliasWithSaveLayer,
                                //                       color: FlutterTheme.of(context)
                                //                           .secondaryBackground,
                                //                       elevation: 4.0,
                                //                       shape: RoundedRectangleBorder(
                                //                         borderRadius:
                                //                             BorderRadius.circular(8.0),
                                //                       ),
                                //                       child: Padding(
                                //                         padding:
                                //                             EdgeInsetsDirectional.fromSTEB(
                                //                                 2.0, 2.0, 2.0, 2.0),
                                //                         child: ClipRRect(
                                //                           borderRadius:
                                //                               BorderRadius.circular(8.0),
                                //                           child: Image.network(
                                //                             BaseUrlGroup.carDetailCall
                                //                                 .carImage(
                                //                               productDetailPageCarDetailResponse
                                //                                   .jsonBody,
                                //                             ).toString(),
                                //                             width: 175.0,
                                //                             height: 102.0,
                                //                             fit: BoxFit.cover,
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Row(
                                //                       mainAxisSize: MainAxisSize.max,
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment.center,
                                //                       children: [
                                //                         Text(
                                //                           FFLocalizations.of(context)
                                //                               .getText(
                                //                             'uc5oqgba' /* $ */,
                                //                           ),
                                //                           style:
                                //                               FlutterTheme.of(context)
                                //                                   .bodyMedium
                                //                                   .override(
                                //                                     fontFamily: 'Urbanist',
                                //                                     color:
                                //                                         FlutterTheme.of(
                                //                                                 context)
                                //                                             .primaryText,
                                //                                   ),
                                //                         ),
                                //                         Text(
                                //                           BaseUrlGroup.carDetailCall
                                //                               .carCost(
                                //                                 productDetailPageCarDetailResponse
                                //                                     .jsonBody,
                                //                               )
                                //                               .toString(),
                                //                           style:
                                //                               FlutterTheme.of(context)
                                //                                   .bodyMedium
                                //                                   .override(
                                //                                     fontFamily: 'Urbanist',
                                //                                     color:
                                //                                         FlutterTheme.of(
                                //                                                 context)
                                //                                             .primaryText,
                                //                                   ),
                                //                         ),
                                //                         Text(
                                //                           FFLocalizations.of(context)
                                //                               .getText(
                                //                             'g5ane3oy' /* / */,
                                //                           ),
                                //                           style:
                                //                               FlutterTheme.of(context)
                                //                                   .bodyMedium
                                //                                   .override(
                                //                                     fontFamily: 'Urbanist',
                                //                                     color:
                                //                                         FlutterTheme.of(
                                //                                                 context)
                                //                                             .primaryText,
                                //                                   ),
                                //                         ),
                                //                         Text(
                                //                           BaseUrlGroup.carDetailCall
                                //                               .pricetype(
                                //                                 productDetailPageCarDetailResponse
                                //                                     .jsonBody,
                                //                               )
                                //                               .toString(),
                                //                           style:
                                //                               FlutterTheme.of(context)
                                //                                   .bodyMedium
                                //                                   .override(
                                //                                     fontFamily: 'Urbanist',
                                //                                     color:
                                //                                         FlutterTheme.of(
                                //                                                 context)
                                //                                             .primaryText,
                                //                                   ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ]
                                //                       .divide(SizedBox(height: 8.0))
                                //                       .addToEnd(SizedBox(height: 8.0)),
                                //                 ),
                                //               ),
                                //               Flexible(
                                //                 child: Column(
                                //                   mainAxisSize: MainAxisSize.max,
                                //                   mainAxisAlignment: MainAxisAlignment.end,
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment.start,
                                //                   children: [
                                //                     Padding(
                                //                       padding:
                                //                           EdgeInsetsDirectional.fromSTEB(
                                //                               0.0, 0.0, 8.0, 0.0),
                                //                       child: Text(
                                //                         BaseUrlGroup.carDetailCall
                                //                             .carName(
                                //                               productDetailPageCarDetailResponse
                                //                                   .jsonBody,
                                //                             )
                                //                             .toString(),
                                //                         style: FlutterTheme.of(context)
                                //                             .bodyMedium
                                //                             .override(
                                //                               fontFamily: 'Urbanist',
                                //                               color: FlutterTheme.of(
                                //                                       context)
                                //                                   .primary,
                                //                             ),
                                //                       ),
                                //                     ),
                                //                     Material(
                                //                       color: Colors.transparent,
                                //                       elevation: 1.0,
                                //                       shape: RoundedRectangleBorder(
                                //                         borderRadius:
                                //                             BorderRadius.circular(12.5),
                                //                       ),
                                //                       child: Container(
                                //                         width: 60.0,
                                //                         height: 25.0,
                                //                         decoration: BoxDecoration(
                                //                           color:
                                //                               FlutterTheme.of(context)
                                //                                   .secondaryBackground,
                                //                           borderRadius:
                                //                               BorderRadius.circular(12.5),
                                //                           shape: BoxShape.rectangle,
                                //                           border: Border.all(
                                //                             color:
                                //                                 FlutterTheme.of(context)
                                //                                     .warning,
                                //                             width: 1.0,
                                //                           ),
                                //                         ),
                                //                         child: Padding(
                                //                           padding: EdgeInsetsDirectional
                                //                               .fromSTEB(4.0, 4.0, 4.0, 4.0),
                                //                           child: Row(
                                //                             mainAxisSize: MainAxisSize.max,
                                //                             mainAxisAlignment:
                                //                                 MainAxisAlignment.center,
                                //                             crossAxisAlignment:
                                //                                 CrossAxisAlignment.center,
                                //                             children: [
                                //                               Icon(
                                //                                 Icons.star_rate,
                                //                                 color: FlutterTheme.of(
                                //                                         context)
                                //                                     .warning,
                                //                                 size: 16.0,
                                //                               ),
                                //                               SizedBox(
                                //                                 height: 0.0,
                                //                                 child: VerticalDivider(
                                //                                   width: 5.0,
                                //                                   thickness: 1.0,
                                //                                   color:
                                //                                       FlutterTheme.of(
                                //                                               context)
                                //                                           .accent4,
                                //                                 ),
                                //                               ),
                                //                               Flexible(
                                //                                 child: Text(
                                //                                   BaseUrlGroup.carDetailCall
                                //                                       .rating(
                                //                                         productDetailPageCarDetailResponse
                                //                                             .jsonBody,
                                //                                       )
                                //                                       .toString(),
                                //                                   style:
                                //                                       FlutterTheme.of(
                                //                                               context)
                                //                                           .bodyMedium,
                                //                                 ),
                                //                               ),
                                //                             ],
                                //                           ),
                                //                         ),
                                //                       ),
                                //                     ),
                                //                     Row(
                                //                       mainAxisSize: MainAxisSize.max,
                                //                       mainAxisAlignment:
                                //                           MainAxisAlignment.end,
                                //                       crossAxisAlignment:
                                //                           CrossAxisAlignment.center,
                                //                       children: [
                                //                         Expanded(
                                //                           child: FFButtonWidget(
                                //                             onPressed: () async {
                                //                               context.pushNamed(
                                //                                 'product_detail_page',
                                //                                 queryParameters: {
                                //                                   'carId': serializeParam(
                                //                                     BaseUrlGroup
                                //                                         .carDetailCall
                                //                                         .carId(
                                //                                           productDetailPageCarDetailResponse
                                //                                               .jsonBody,
                                //                                         )
                                //                                         .toString(),
                                //                                     ParamType.String,
                                //                                   ),
                                //                                 }.withoutNulls,
                                //                               );
                                //                             },
                                //                             text:
                                //                                 FFLocalizations.of(context)
                                //                                     .getText(
                                //                               'dee2pi5u' /* Details */,
                                //                             ),
                                //                             options: FFButtonOptions(
                                //                               width: 120.0,
                                //                               height: 40.0,
                                //                               padding: EdgeInsetsDirectional
                                //                                   .fromSTEB(
                                //                                       24.0, 0.0, 24.0, 0.0),
                                //                               iconPadding:
                                //                                   EdgeInsetsDirectional
                                //                                       .fromSTEB(0.0, 0.0,
                                //                                           0.0, 0.0),
                                //                               color: FlutterTheme.of(
                                //                                       context)
                                //                                   .secondary,
                                //                               textStyle: FlutterTheme
                                //                                       .of(context)
                                //                                   .titleSmall
                                //                                   .override(
                                //                                     fontFamily: 'Urbanist',
                                //                                     color: Colors.white,
                                //                                   ),
                                //                               elevation: 3.0,
                                //                               borderSide: BorderSide(
                                //                                 color: Colors.transparent,
                                //                                 width: 1.0,
                                //                               ),
                                //                               borderRadius:
                                //                                   BorderRadius.only(
                                //                                 bottomLeft:
                                //                                     Radius.circular(0.0),
                                //                                 bottomRight:
                                //                                     Radius.circular(16.0),
                                //                                 topLeft:
                                //                                     Radius.circular(16.0),
                                //                                 topRight:
                                //                                     Radius.circular(0.0),
                                //                               ),
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       ],
                                //                     ),
                                //                   ].divide(SizedBox(height: 8.0)),
                                //                 ),
                                //               ),
                                //             ].divide(SizedBox(width: 12.0)),
                                //           ),
                                //         ),
                                //       ),
                                //     ].divide(SizedBox(height: 12.0)),
                                //   ),
                                // ),
                                Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        12.0, 0.0, 12.0, 0.0),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {

                                        Helper.moveToScreenwithPush(context, BookingPageWidget(
                                          carDetailBooking:_carDetailsModel!.data!.toJson(),
                                          priceType: _carDetailsModel!.data!.priceType.toString(),
                                          supplierid: _carDetailsModel!.data!.supplierId.toString(),
                                          carid: _carDetailsModel!.data!.carId.toString(),
                                          ownername: _carDetailsModel!.data!.userName!
                                              .toString(),
                                          carCost:double.parse(_carDetailsModel!.data!.carCost.toString()),
                                          car_type: _carDetailsModel!.data!.carType.toString(),));
                                        // car_type: '',)):

                                        print("double.parse(_carDetailsModel!.data!.carCost.toString())${double.parse(_carDetailsModel!.data!.carCost.toString())}");
                                        print("double.parse(_carDetailsModel!.data!.carType.toString())"
                                            "${_carDetailsModel!.data!.carType.toString()}");
                                        // "");
                                        // context.pushNamed(
                                        //   'booking_page',
                                        //   queryParameters: {
                                        //     'carDetailBooking': serializeParam(
                                        //       BaseUrlGroup.carDetailCall.data(
                                        //         productDetailPageCarDetailResponse.jsonBody,
                                        //       ),
                                        //       ParamType.JSON,
                                        //     ),
                                        //     'priceType': serializeParam(
                                        //       BaseUrlGroup.carDetailCall
                                        //           .pricetype(
                                        //             productDetailPageCarDetailResponse
                                        //                 .jsonBody,
                                        //           )
                                        //           .toString(),
                                        //       ParamType.String,
                                        //     ),
                                        //     'supplierid': serializeParam(
                                        //       BaseUrlGroup.carDetailCall
                                        //           .supplierid(
                                        //         productDetailPageCarDetailResponse
                                        //             .jsonBody,
                                        //       )
                                        //           .toString(),
                                        //       ParamType.String,
                                        //     ),
                                        //     'carId': serializeParam(
                                        //       BaseUrlGroup.carDetailCall
                                        //           .carId(
                                        //         productDetailPageCarDetailResponse
                                        //             .jsonBody,
                                        //       )
                                        //           .toString(),
                                        //       ParamType.String,
                                        //     ),
                                        //
                                        //     'carCost': serializeParam(
                                        //       getJsonField(
                                        //         productDetailPageCarDetailResponse.jsonBody,
                                        //         r'''$.car_cost''',
                                        //       ),
                                        //       ParamType.double,
                                        //     ),
                                        //
                                        //   }.withoutNulls,
                                        // );
                                        // print("=====carid=====${ BaseUrlGroup.carDetailCall
                                        //     .carId(
                                        //   productDetailPageCarDetailResponse
                                        //       .jsonBody,
                                        // )
                                        //     .toString()}");
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context).btnclr,
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0.00, 0.00),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '30q5685b' /* Rent It */,
                                            ),
                                            style: FlutterTheme.of(context).labelLarge.override(
                                              fontFamily: 'Urbanist',
                                              color: Colors.white,
                                              fontSize: 18.0,
                                            ),
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              ]
                            // .divide(SizedBox(height: 12.0))
                            // .addToEnd(SizedBox(height: 12.0)),
                          ),
                        ] ),
                  ),
                ),
                Helper.getProgressBarWhite(context, _isVisible)
              ],
            ),
          ),
        ));
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> cardetails() async {


    print("<=============cardetails Api============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
      'user_id': FFAppState().UserId,
      'car_id':widget.carId
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.car_detail), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CarDetailsModel model = CarDetailsModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _carDetailsModel=model;

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

