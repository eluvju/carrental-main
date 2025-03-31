import '../../constant.dart';
import '../../map_screen.dart';
import '../../model/search_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vehicle_listing_page_model.dart';
export 'vehicle_listing_page_model.dart';
import 'package:http/http.dart'as http;

class VehicleListingPageWidget extends StatefulWidget {
  dynamic lat ;
  dynamic long ;
  dynamic lat2 ;
  dynamic long2 ;
  dynamic lat3 ;
  dynamic long3 ;
  String car_id ;


  VehicleListingPageWidget({required this.lat,required this.long,required this.lat2,
    required this.long2,required this.lat3,required this.long3,required this.car_id});


  @override
  _VehicleListingPageWidgetState createState() =>
      _VehicleListingPageWidgetState();
}

class _VehicleListingPageWidgetState extends State<VehicleListingPageWidget> {
  late VehicleListingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  SearchCarModel?_searchCarModel;
  bool _hasData = true;
  bool _isVisible = false;
  final List<Data> items = [];
  TextEditingController pickup_address1=TextEditingController();
  List<Data> filteredItems = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VehicleListingPageModel());
     Helper.checkInternet(vehiclelistingapi());
    print("=========lat=====${widget.lat}");
    print("=========long=====${widget.long}");

    // On page load action.
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      setState(() {
        _model.carType = 'Days';
        _model.categoryName = 'All';
      });
      print("=======  _model.carType = 'Days'======${_model.carType}");
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        title: Text(
          FFLocalizations.of(context).getText(
            'w94vsybl' /* Vehicle Listing */,
          ),
          style: FlutterTheme.of(context).headlineMedium.override(
                fontFamily: 'Urbanist',
                color: FlutterTheme.of(context).primaryText,
                fontSize: 22.0,
              ),
        ),
        actions: [
        ],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                  child: Material(
                    color: Colors.transparent,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:  TextFormField(
                      onTap: () {
                        Helper.moveToScreenwithPush(context, PriceCalculationLocation(callback: (String, Lat,Lng,lat2,long2,lat3,long3) {
                          pickup_address1.text=String;
                          widget.lat=Lat;
                          widget.long=Lng;
                          print("=====String addresss====${String}");
                          print("=====String lat====${Lat}");
                          print("=====String Lng====${Lng}");
                        },));
                        // Helper.moveToScreenwithPushreplaceemt(context, EditPickShopAddress(size: widget.size, catergory: widget.catergory, quantity: widget.quantity, vehicle_type: widget.vehicle_type, callback: (String, LatLng) {  },));
                      },
                      controller: pickup_address1,
                      // focusNode:
                      // _model.textFieldManufactureFocusNode6,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelStyle: FlutterTheme.of(context)
                            .displaySmall
                            .override(
                          fontFamily: 'Outfit',
                          color:
                          FlutterTheme.of(context)
                              .primaryText,
                          fontSize: 16.0,
                        ),
                        hintText:"Location",
                        hintStyle: FlutterTheme.of(context).bodyMedium,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF1F1F1),
                            width: 2.0,
                          ),
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF1F1F1),
                            width: 2.0,
                          ),
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterTheme.of(context)
                                .error,
                            width: 2.0,
                          ),
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterTheme.of(context)
                                .error,
                            width: 2.0,
                          ),
                          borderRadius:
                          BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF1F1F1),
                      ),
                      style: FlutterTheme.of(context).bodyMedium,
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsetsDirectional.fromSTEB(
              //       8.0, 0.0, 8.0, 0.0),
              //   child: TextFormField(
              //     onTap: () {
              //       Helper.moveToScreenwithPush(context, PriceCalculationLocation(callback: (String, Lat,Lng,lat2,long2,lat3,long3) {
              //         pickup_address1.text=String;
              //         widget.lat=Lat;
              //         widget.long=Lng;
              //         print("=====String====${String}");
              //       },));
              //       // Helper.moveToScreenwithPushreplaceemt(context, EditPickShopAddress(size: widget.size, catergory: widget.catergory, quantity: widget.quantity, vehicle_type: widget.vehicle_type, callback: (String, LatLng) {  },));
              //     },
              //     controller: pickup_address1,
              //     // focusNode:
              //     // _model.textFieldManufactureFocusNode6,
              //     autofocus: true,
              //     obscureText: false,
              //     decoration: InputDecoration(
              //       labelStyle: FlutterTheme.of(context)
              //           .displaySmall
              //           .override(
              //         fontFamily: 'Outfit',
              //         color:
              //         FlutterTheme.of(context)
              //             .primaryText,
              //         fontSize: 16.0,
              //       ),
              //       hintText:"Location",
              //       hintStyle: FlutterTheme.of(context).bodyMedium,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFF1F1F1),
              //           width: 2.0,
              //         ),
              //         borderRadius:
              //         BorderRadius.circular(12.0),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Color(0xFFF1F1F1),
              //           width: 2.0,
              //         ),
              //         borderRadius:
              //         BorderRadius.circular(12.0),
              //       ),
              //       errorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterTheme.of(context)
              //               .error,
              //           width: 2.0,
              //         ),
              //         borderRadius:
              //         BorderRadius.circular(12.0),
              //       ),
              //       focusedErrorBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: FlutterTheme.of(context)
              //               .error,
              //           width: 2.0,
              //         ),
              //         borderRadius:
              //         BorderRadius.circular(12.0),
              //       ),
              //       filled: true,
              //       fillColor: Color(0xFFF1F1F1),
              //     ),
              //     style: FlutterTheme.of(context)
              //         .bodyMedium
              //         .override(
              //       fontFamily: 'Outfit',
              //       color: FlutterTheme.of(context)
              //           .alternate,
              //       fontSize: 14.0,
              //     ),
              //   ),
              // ),


              Flexible(
                child: Container(
                  height: 58.0,
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          setState(() {
                            _model.carType = 'Days';
                            performSearchptype( _model.carType.toString());
                          });
                        },
                        text: FFLocalizations.of(context).getText(
                          '1f26sndv' /* Days */,
                        ),
                        options: FFButtonOptions(
                          width: 156.0,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: valueOrDefault<Color>(
                            _model.carType == 'Days'
                                ? FlutterTheme.of(context).error
                                : FlutterTheme.of(context).accent4,
                            FlutterTheme.of(context).error,
                          ),
                          textStyle:
                          FlutterTheme.of(context).titleSmall.override(
                            fontFamily: 'Urbanist',
                            color: _model.carType == 'Days'
                                ? FlutterTheme.of(context)
                                .primaryBtnText
                                : FlutterTheme.of(context).primary,
                            fontSize: 18.0,
                          ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          setState(() {
                            _model.carType = 'Hours';
                            performSearchptype( _model.carType.toString());
                          });
                        },
                        text: FFLocalizations.of(context).getText(
                          '9nrrtl81' /* Hours */,
                        ),
                        options: FFButtonOptions(
                          width: 156.0,
                          height: 44.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: valueOrDefault<Color>(
                            _model.carType == 'Hours'
                                ? FlutterTheme.of(context).error
                                : FlutterTheme.of(context).accent4,
                            FlutterTheme.of(context).accent4,
                          ),
                          textStyle:
                          FlutterTheme.of(context).titleSmall.override(
                            fontFamily: 'Urbanist',
                            color: _model.carType == 'Hours'
                                ? FlutterTheme.of(context)
                                .primaryBtnText
                                : FlutterTheme.of(context).primary,
                            fontSize: 18.0,
                          ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ].divide(SizedBox(width: 8.0)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                  ),
                  child: FutureBuilder<ApiCallResponse>(
                    future: BaseUrlGroup.categoryCall.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return a loading indicator while data is being fetched
                        return Center(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: SpinKitFadingGrid(
                              color: FlutterTheme.of(context).primary,
                              size: 40.0,
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        // Handle the error case
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData) {
                        // Handle the case where there is no data available
                        return Center(
                          child: Text('No data available'),
                        );
                      } else {
                        final listViewCategoryResponse = snapshot.data!;
                        final eachCategoryList = BaseUrlGroup.categoryCall
                            .carCategoryData(listViewCategoryResponse.jsonBody)
                            ?.toList() ?? [];

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          itemCount: eachCategoryList.length,
                          itemBuilder: (context, eachCategoryListIndex) {
                            final eachCategoryListItem = eachCategoryList[eachCategoryListIndex];
                            bool isSelected = _model.categoryName == getJsonField(
                              eachCategoryListItem,
                              r'''$.category_name''',
                            ).toString();

                            return InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                setState(() {
                                  _model.categoryName = getJsonField(
                                    eachCategoryListItem,
                                    r'''$.category_name''',
                                  ).toString();
                                  print("Selected index:${eachCategoryList[eachCategoryListIndex]}");
                                  performSearch(_model.carType.toString(), _model.categoryName);
                                  print("Selected=======:${_model.carType.toString()}");
                                });
                              },
                              child: Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                color: isSelected ?  FlutterTheme.of(context).error : FlutterTheme.of(context).accent4,
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    getJsonField(
                                      eachCategoryListItem,
                                      r'''$.category_name''',
                                    ).toString(),
                                    style: isSelected ? FlutterTheme.of(context).bodyMedium.copyWith(color: Colors.white) : FlutterTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),

                ),
              ),


              _searchCarModel == null
                  ? _hasData
                  ? Container()
                  : Container(
                child: Center(
                  child: Text("NO DATA"),
                ),
              )
                  : filteredItems.isEmpty
                  ? Container(
                height: 400,

                child: Center(
                  child: Text("No cars available"),
                ),
              ):
             ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount:filteredItems.isEmpty?_searchCarModel!.data!.length: filteredItems.length,
        itemBuilder: (context, item) {
          final bool isDaysPriceType =
          filteredItems.isEmpty
              ? _searchCarModel!.data![item].priceType!.toLowerCase() == "Days"
              : filteredItems[item].priceType!.toLowerCase() == "Hours";
          // final eachCarListItem =
          // eachCarList[eachCarListIndex];
          return Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterTheme.of(context)
                .secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Align(
              alignment:
              AlignmentDirectional(0.00, 1.00),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Card(
                          clipBehavior: Clip
                              .antiAliasWithSaveLayer,
                          color: FlutterTheme.of(
                              context)
                              .secondaryBackground,
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                8.0),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional
                                .fromSTEB(2.0, 2.0,
                                2.0, 2.0),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(
                                  8.0),
                              // $.data[:].car_image[:].image
                              child: Image.network(
                                filteredItems.isEmpty? _searchCarModel!.data![item].carImage![0].image.toString(): filteredItems[item].carImage![0].image.toString(),
                                width: 175.0,
                                height: 102.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize:
                          MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Text(
                              FFLocalizations.of(
                                  context)
                                  .getText(
                                '2mlzstcu' /* $ */,
                              ),
                              style:
                              FlutterTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                color: FlutterTheme.of(
                                    context)
                                    .primaryText,
                              ),
                            ),
                            Text(
                              filteredItems.isEmpty? _searchCarModel!.data![item].carCost.toString(): filteredItems[item].carCost.toString(),
                              style:
                              FlutterTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                color: FlutterTheme.of(
                                    context)
                                    .primaryText,
                              ),
                            ),
                            Text(
                              FFLocalizations.of(
                                  context)
                                  .getText(
                                'uklnmth2' /* / */,
                              ),
                              style:
                              FlutterTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                color: FlutterTheme.of(
                                    context)
                                    .primaryText,
                              ),
                            ),
                            Text(
                              filteredItems.isEmpty? _searchCarModel!.data![item].priceType!.toString(): filteredItems[item].priceType!.toString(),
                              style:
                              FlutterTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                color: FlutterTheme.of(
                                    context)
                                    .primaryText,
                              ),
                            ),
                          ],
                        ),
                      ]
                          .divide(SizedBox(height: 8.0))
                          .addToEnd(
                          SizedBox(height: 8.0)),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional
                              .fromSTEB(
                              0.0, 0.0, 8.0, 0.0),
                          child: Text(
                            filteredItems.isEmpty? _searchCarModel!.data![item].carName!.toString(): filteredItems[item].carName!.toString(),
                            style: FlutterTheme.of(
                                context)
                                .bodyMedium
                                .override(
                              fontFamily:
                              'Urbanist',
                              color: FlutterTheme
                                  .of(context)
                                  .primary,
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                12.5),
                          ),
                          child: Container(
                            width: 60.0,
                            height: 30.0,
                            decoration: BoxDecoration(
                              color: FlutterTheme
                                  .of(context)
                                  .secondaryBackground,
                              borderRadius:
                              BorderRadius.circular(
                                  12.5),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                color:
                                FlutterTheme.of(
                                    context)
                                    .warning,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding:
                              EdgeInsetsDirectional
                                  .fromSTEB(
                                  4.0,
                                  4.0,
                                  4.0,
                                  4.0),
                              child: Row(
                                mainAxisSize:
                                MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                children: [
                                  Icon(
                                    Icons.star_rate,
                                    color: FlutterTheme
                                        .of(context)
                                        .warning,
                                    size: 16.0,
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                    child:
                                    VerticalDivider(
                                      width: 5.0,
                                      thickness: 1.0,
                                      color: FlutterTheme
                                          .of(context)
                                          .accent4,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      filteredItems.isEmpty? _searchCarModel!.data![item].rating!.toString(): filteredItems[item].rating!.toString(),
                                      style: FlutterTheme
                                          .of(context)
                                          .bodyMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize:
                          MainAxisSize.max,
                          mainAxisAlignment:
                          MainAxisAlignment.end,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () async {
                                   // Helper.moveToScreenwithPush(context, filteredItems.isEmpty? _searchCarModel!.data![item].carId!.toString(): filteredItems[item].carId!.toString(),);
                                  context.pushNamed(
                                    'product_detail_page',
                                    queryParameters: {
                                      'carId': serializeParam(
                                        filteredItems.isEmpty? _searchCarModel!.data![item].carId!.toString(): filteredItems[item].carId!.toString(),
                                        ParamType.String,
                                      ),
                                    },
                                  );
                                  print("==========car_id=======${  _searchCarModel!.data![item].carId!.toString()}");
                                },
                                text:
                                FFLocalizations.of(
                                    context)
                                    .getText(
                                  'xf936hfw' /* Details */,
                                ),
                                options:
                                FFButtonOptions(
                                  width: 120.0,
                                  height: 40.0,
                                  padding:
                                  EdgeInsetsDirectional
                                      .fromSTEB(
                                      24.0,
                                      0.0,
                                      24.0,
                                      0.0),
                                  iconPadding:
                                  EdgeInsetsDirectional
                                      .fromSTEB(
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0),
                                  color: FlutterTheme
                                      .of(context)
                                      .secondary,
                                  textStyle:
                                  FlutterTheme.of(
                                      context)
                                      .titleSmall
                                      .override(
                                    fontFamily:
                                    'Urbanist',
                                    color: Colors
                                        .white,
                                  ),
                                  elevation: 3.0,
                                  borderSide:
                                  BorderSide(
                                    color: Colors
                                        .transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius:
                                  BorderRadius.only(
                                    bottomLeft:
                                    Radius.circular(
                                        0.0),
                                    bottomRight:
                                    Radius.circular(
                                        16.0),
                                    topLeft:
                                    Radius.circular(
                                        16.0),
                                    topRight:
                                    Radius.circular(
                                        0.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ].divide(SizedBox(width: 12.0)),
              ),
            ),
          );
        },
      )

              // FutureBuilder<ApiCallResponse>(
              //   future: BaseUrlGroup.carsCall.call(
              //     categoryType: _model.categoryName,
              //     priceType: _model.carType,
              //   ),
              //   builder: (context, snapshot) {
              //     // Customize what your widget looks like when it's loading.
              //     if (!snapshot.hasData) {
              //       return Center(
              //         child: SizedBox(
              //           width: 50.0,
              //           height: 50.0,
              //           child: CircularProgressIndicator(
              //             valueColor: AlwaysStoppedAnimation<Color>(
              //               FlutterTheme.of(context).primary,
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //     final conditionalBuilderCarsResponse = snapshot.data!;
              //     return Builder(
              //       builder: (context) {
              //         if (BaseUrlGroup.carsCall.response(
              //           conditionalBuilderCarsResponse.jsonBody,
              //         )) {
              //           return Padding(
              //             padding: EdgeInsetsDirectional.fromSTEB(
              //                 8.0, 8.0, 8.0, 8.0),
              //             child: Builder(
              //               builder: (context) {
              //                 final eachCarList = BaseUrlGroup.carsCall
              //                         .carData(
              //                           conditionalBuilderCarsResponse.jsonBody,
              //                         )
              //                         ?.toList() ??
              //                     [];
              //                 if (eachCarList.isEmpty) {
              //                   return Image.asset(
              //                     '',
              //                     fit: BoxFit.contain,
              //                   );
              //                 }
              //                 return ListView.builder(
              //                   padding: EdgeInsets.zero,
              //                   shrinkWrap: true,
              //                   physics: NeverScrollableScrollPhysics(),
              //                   scrollDirection: Axis.vertical,
              //                   itemCount: eachCarList.length,
              //                   itemBuilder: (context, eachCarListIndex) {
              //                     final eachCarListItem =
              //                         eachCarList[eachCarListIndex];
              //                     return Card(
              //                       clipBehavior: Clip.antiAliasWithSaveLayer,
              //                       color: FlutterTheme.of(context)
              //                           .secondaryBackground,
              //                       elevation: 4.0,
              //                       shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(8.0),
              //                       ),
              //                       child: Align(
              //                         alignment:
              //                             AlignmentDirectional(0.00, 1.00),
              //                         child: Row(
              //                           mainAxisSize: MainAxisSize.max,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.end,
              //                           children: [
              //                             Expanded(
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.max,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.center,
              //                                 children: [
              //                                   Card(
              //                                     clipBehavior: Clip
              //                                         .antiAliasWithSaveLayer,
              //                                     color: FlutterTheme.of(
              //                                             context)
              //                                         .secondaryBackground,
              //                                     elevation: 4.0,
              //                                     shape: RoundedRectangleBorder(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               8.0),
              //                                     ),
              //                                     child: Padding(
              //                                       padding:
              //                                           EdgeInsetsDirectional
              //                                               .fromSTEB(2.0, 2.0,
              //                                                   2.0, 2.0),
              //                                       child: ClipRRect(
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 8.0),
              //                                         // $.data[:].car_image[:].image
              //                                         child: Image.network(
              //                                           getJsonField(
              //                                             eachCarListItem,
              //                                             r'''$.car_image[0].image''',
              //                                           ).toString(),
              //                                           width: 175.0,
              //                                           height: 102.0,
              //                                           fit: BoxFit.cover,
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Row(
              //                                     mainAxisSize:
              //                                         MainAxisSize.max,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.center,
              //                                     children: [
              //                                       Text(
              //                                         FFLocalizations.of(
              //                                                 context)
              //                                             .getText(
              //                                           '2mlzstcu' /* $ */,
              //                                         ),
              //                                         style:
              //                                             FlutterTheme.of(
              //                                                     context)
              //                                                 .bodyMedium
              //                                                 .override(
              //                                                   fontFamily:
              //                                                       'Urbanist',
              //                                                   color: FlutterTheme.of(
              //                                                           context)
              //                                                       .primaryText,
              //                                                 ),
              //                                       ),
              //                                       Text(
              //                                         getJsonField(
              //                                           eachCarListItem,
              //                                           r'''$.car_cost''',
              //                                         ).toString(),
              //                                         style:
              //                                             FlutterTheme.of(
              //                                                     context)
              //                                                 .bodyMedium
              //                                                 .override(
              //                                                   fontFamily:
              //                                                       'Urbanist',
              //                                                   color: FlutterTheme.of(
              //                                                           context)
              //                                                       .primaryText,
              //                                                 ),
              //                                       ),
              //                                       Text(
              //                                         FFLocalizations.of(
              //                                                 context)
              //                                             .getText(
              //                                           'uklnmth2' /* / */,
              //                                         ),
              //                                         style:
              //                                             FlutterTheme.of(
              //                                                     context)
              //                                                 .bodyMedium
              //                                                 .override(
              //                                                   fontFamily:
              //                                                       'Urbanist',
              //                                                   color: FlutterTheme.of(
              //                                                           context)
              //                                                       .primaryText,
              //                                                 ),
              //                                       ),
              //                                       Text(
              //                                         getJsonField(
              //                                           eachCarListItem,
              //                                           r'''$.price_type''',
              //                                         ).toString(),
              //                                         style:
              //                                             FlutterTheme.of(
              //                                                     context)
              //                                                 .bodyMedium
              //                                                 .override(
              //                                                   fontFamily:
              //                                                       'Urbanist',
              //                                                   color: FlutterTheme.of(
              //                                                           context)
              //                                                       .primaryText,
              //                                                 ),
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 ]
              //                                     .divide(SizedBox(height: 8.0))
              //                                     .addToEnd(
              //                                         SizedBox(height: 8.0)),
              //                               ),
              //                             ),
              //                             Flexible(
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.max,
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.end,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: [
              //                                   Padding(
              //                                     padding: EdgeInsetsDirectional
              //                                         .fromSTEB(
              //                                             0.0, 0.0, 8.0, 0.0),
              //                                     child: Text(
              //                                       getJsonField(
              //                                         eachCarListItem,
              //                                         r'''$.car_name''',
              //                                       ).toString(),
              //                                       style: FlutterTheme.of(
              //                                               context)
              //                                           .bodyMedium
              //                                           .override(
              //                                             fontFamily:
              //                                                 'Urbanist',
              //                                             color: FlutterTheme
              //                                                     .of(context)
              //                                                 .primary,
              //                                           ),
              //                                     ),
              //                                   ),
              //                                   Material(
              //                                     color: Colors.transparent,
              //                                     elevation: 1.0,
              //                                     shape: RoundedRectangleBorder(
              //                                       borderRadius:
              //                                           BorderRadius.circular(
              //                                               12.5),
              //                                     ),
              //                                     child: Container(
              //                                       width: 60.0,
              //                                       height: 25.0,
              //                                       decoration: BoxDecoration(
              //                                         color: FlutterTheme
              //                                                 .of(context)
              //                                             .secondaryBackground,
              //                                         borderRadius:
              //                                             BorderRadius.circular(
              //                                                 12.5),
              //                                         shape: BoxShape.rectangle,
              //                                         border: Border.all(
              //                                           color:
              //                                               FlutterTheme.of(
              //                                                       context)
              //                                                   .warning,
              //                                           width: 1.0,
              //                                         ),
              //                                       ),
              //                                       child: Padding(
              //                                         padding:
              //                                             EdgeInsetsDirectional
              //                                                 .fromSTEB(
              //                                                     4.0,
              //                                                     4.0,
              //                                                     4.0,
              //                                                     4.0),
              //                                         child: Row(
              //                                           mainAxisSize:
              //                                               MainAxisSize.max,
              //                                           mainAxisAlignment:
              //                                               MainAxisAlignment
              //                                                   .center,
              //                                           crossAxisAlignment:
              //                                               CrossAxisAlignment
              //                                                   .center,
              //                                           children: [
              //                                             Icon(
              //                                               Icons.star_rate,
              //                                               color: FlutterTheme
              //                                                       .of(context)
              //                                                   .warning,
              //                                               size: 16.0,
              //                                             ),
              //                                             SizedBox(
              //                                               height: 0.0,
              //                                               child:
              //                                                   VerticalDivider(
              //                                                 width: 5.0,
              //                                                 thickness: 1.0,
              //                                                 color: FlutterTheme
              //                                                         .of(context)
              //                                                     .accent4,
              //                                               ),
              //                                             ),
              //                                             Flexible(
              //                                               child: Text(
              //                                                 getJsonField(
              //                                                   eachCarListItem,
              //                                                   r'''$.rating''',
              //                                                 ).toString(),
              //                                                 style: FlutterTheme
              //                                                         .of(context)
              //                                                     .bodyMedium,
              //                                               ),
              //                                             ),
              //                                           ],
              //                                         ),
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Row(
              //                                     mainAxisSize:
              //                                         MainAxisSize.max,
              //                                     mainAxisAlignment:
              //                                         MainAxisAlignment.end,
              //                                     crossAxisAlignment:
              //                                         CrossAxisAlignment.center,
              //                                     children: [
              //                                       Expanded(
              //                                         child: FFButtonWidget(
              //                                           onPressed: () async {
              //                                             context.pushNamed(
              //                                               'product_detail_page',
              //                                               queryParameters: {
              //                                                 'carId':
              //                                                     serializeParam(
              //                                                   getJsonField(
              //                                                     eachCarListItem,
              //                                                     r'''$.car_id''',
              //                                                   ).toString(),
              //                                                   ParamType
              //                                                       .String,
              //                                                 ),
              //                                               }.withoutNulls,
              //                                             );
              //                                           },
              //                                           text:
              //                                               FFLocalizations.of(
              //                                                       context)
              //                                                   .getText(
              //                                             'xf936hfw' /* Details */,
              //                                           ),
              //                                           options:
              //                                               FFButtonOptions(
              //                                             width: 120.0,
              //                                             height: 40.0,
              //                                             padding:
              //                                                 EdgeInsetsDirectional
              //                                                     .fromSTEB(
              //                                                         24.0,
              //                                                         0.0,
              //                                                         24.0,
              //                                                         0.0),
              //                                             iconPadding:
              //                                                 EdgeInsetsDirectional
              //                                                     .fromSTEB(
              //                                                         0.0,
              //                                                         0.0,
              //                                                         0.0,
              //                                                         0.0),
              //                                             color: FlutterTheme
              //                                                     .of(context)
              //                                                 .secondary,
              //                                             textStyle:
              //                                                 FlutterTheme.of(
              //                                                         context)
              //                                                     .titleSmall
              //                                                     .override(
              //                                                       fontFamily:
              //                                                           'Urbanist',
              //                                                       color: Colors
              //                                                           .white,
              //                                                     ),
              //                                             elevation: 3.0,
              //                                             borderSide:
              //                                                 BorderSide(
              //                                               color: Colors
              //                                                   .transparent,
              //                                               width: 1.0,
              //                                             ),
              //                                             borderRadius:
              //                                                 BorderRadius.only(
              //                                               bottomLeft:
              //                                                   Radius.circular(
              //                                                       0.0),
              //                                               bottomRight:
              //                                                   Radius.circular(
              //                                                       16.0),
              //                                               topLeft:
              //                                                   Radius.circular(
              //                                                       16.0),
              //                                               topRight:
              //                                                   Radius.circular(
              //                                                       0.0),
              //                                             ),
              //                                           ),
              //                                         ),
              //                                       ),
              //                                     ],
              //                                   ),
              //                                 ].divide(SizedBox(height: 8.0)),
              //                               ),
              //                             ),
              //                           ].divide(SizedBox(width: 12.0)),
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                 );
              //               },
              //             ),
              //           );
              //         } else {
              //           return Align(
              //             alignment: AlignmentDirectional(0.00, 0.00),
              //             child: Padding(
              //               padding: EdgeInsetsDirectional.fromSTEB(
              //                   8.0, 8.0, 8.0, 8.0),
              //               child: Text(
              //                 BaseUrlGroup.carsCall
              //                     .message(
              //                       conditionalBuilderCarsResponse.jsonBody,
              //                     )
              //                     .toString(),
              //                 textAlign: TextAlign.center,
              //                 style: FlutterTheme.of(context).bodyMedium,
              //               ),
              //             ),
              //           );
              //         }
              //       },
              //     );
              //   },
              // ),
            ],
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
  Future<void> vehiclelistingapi() async {


    print("<=============vehiclelistingapi=============>${FFAppState().UserId}");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token':"booking12345",
      'lat':widget.lat.toString(),
      'long':widget.long.toString()
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.search_car), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          SearchCarModel model = SearchCarModel.fromJson(jsonResponse);

          if (model.response == true) {
            items.add(model.data!.first);

            print("Model status true");
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            setProgress(false);
            _hasData=false;
            final jsonResp = jsonResponse["data"];
            for (Map<String,dynamic> user in jsonResp) {

              print("======data===${user}");
              Data chatListdata = Data.fromJson(user);
              items.add(chatListdata);
              print("=====chatListdata====${chatListdata}");
            }
            print("Model status true");
            setProgress(false);

            setState(() {
              _searchCarModel=model;
              performSearchptype('Days');

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



          }
          else {
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
  }

  void performSearch(String priceType, String categoryName) {
    setState(() {
      filteredItems = _searchCarModel!.data!
          .where((item) =>
      item.priceType!.toLowerCase() == priceType.toLowerCase() &&
          item.vehicleCategory!.toLowerCase() == categoryName.toLowerCase())
          .toList();
      if (filteredItems.isNotEmpty) {
        print("=======filteredItems=====${filteredItems.first.priceType}");
      } else {
        print("=======filteredItems is empty=====");
      }
    });
  }

  void performSearchptype(String priceType) {
    setState(() {
      filteredItems = _searchCarModel!.data!
          .where((item) =>
      item.priceType!.toLowerCase() == priceType.toLowerCase())
          .toList();
      if (filteredItems.isNotEmpty) {
        print("Filtered items found for price type: $priceType");
      } else {
        print("No filtered items found for price type: $priceType");
      }
    });
  }

  // void performSearch(String query, String priceType) {
  //   setState(() {
  //     filteredItems = _searchCarModel!.data!
  //         .where((item) =>
  //     item.pickAddress1!.toLowerCase().contains(query.toLowerCase()) &&
  //         item.priceType!.toLowerCase() == priceType.toLowerCase())
  //         .toList();
  //     print("=======filteredItems=====${filteredItems.first.pickAddress1}");
  //     print("=======pricetype=====${filteredItems.first.priceType}");
  //   });
  // }

}
