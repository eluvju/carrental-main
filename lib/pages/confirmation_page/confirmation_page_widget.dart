import 'dart:io';

import '../../constant.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'confirmation_page_model.dart';
export 'confirmation_page_model.dart';

class ConfirmationPageWidget extends StatefulWidget {
  const ConfirmationPageWidget({
    Key? key,
    this.bookingDetails,
    String? driverType,
    String? ownername,
    String? car_type,
    bool? daysAndHourlyType,
    String? pickupLocation,
    String? dropoffLocation,
    String? userName,
    String? contactnumber,
    required this.pickupDate,
    required this.dropoffDate,
    required this.licenceForntImage,
    required this.licenceBackImage,
    String? totalAmount,
    required this.totalDays,
    required this.hoursAndMin,
    required this.supplierid,
    required this.coupon_code,
    // required this.ownername,

  })  : this.driverType = driverType ?? 'Driver',
        this.daysAndHourlyType = daysAndHourlyType ?? false,
        this.pickupLocation = pickupLocation ?? 'indore',
        this.dropoffLocation = dropoffLocation ?? 'dewsh',
        this.userName = userName ?? 'Pty',
        this.ownername = ownername ?? '',
        this.car_type = car_type ?? '',
        this.contactnumber = contactnumber ?? '8827904764',
        this.totalAmount = totalAmount ?? '120',
        super(key: key);

  final dynamic bookingDetails;
  final String driverType;
  final bool daysAndHourlyType;
  final String pickupLocation;
  final String dropoffLocation;
  final String userName;
  final String ownername;
  final String car_type;
  final String contactnumber;
  final String? pickupDate;
  final String? dropoffDate;
  final FFUploadedFile? licenceForntImage;
  final FFUploadedFile? licenceBackImage;
  final String totalAmount;
  final int? totalDays;
  final double? hoursAndMin;
  final String? supplierid;
  final String? coupon_code;

  @override
  _ConfirmationPageWidgetState createState() => _ConfirmationPageWidgetState();
}

class _ConfirmationPageWidgetState extends State<ConfirmationPageWidget> {
  late ConfirmationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    print("======widget.licenceForntImage?.name ?? ''==${widget.licenceForntImage}");
    _model = createModel(context, () => ConfirmationPageModel());
    print("========supplierid======${widget.supplierid}");
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResulPrice = await BaseUrlGroup.driverPriceCall.call();
      if ((_model.apiResulPrice?.succeeded ?? true)) {
        return;
      }
      return;
    });

    _model.textController1 ??= TextEditingController(text: widget.userName);
    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textController2 ??=
        TextEditingController(text: widget.contactnumber);
    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textController3 ??= TextEditingController();
    _model.textFieldFocusNode3 ??= FocusNode();
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
      child:WillPopScope(
        onWillPop: () async {
          return false;
        },

        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterTheme.of(context).secondaryBackground,
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
            title: Text("Review Booking Details",
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
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'dx0o2bhy' /* Please  Review Your Request an... */,
                      ),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).secondary,
                          ),
                    ),
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      color: FlutterTheme.of(context).secondaryBackground,
                      // elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        getJsonField(
                                          widget.bookingDetails,
                                          // r'''$.car_image''',
                                          r'''$.car_image[0].image''',
                                        ),
                                        'https://images.unsplash.com/photo-1494976388531-d1058494cdd8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwyfHxjYXJzfGVufDB8fHx8MTY5NTMwNDMzOHww&ixlib=rb-4.0.3&q=80&w=1080',
                                      ),
                                      width: 60.0,
                                      height: 60.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          valueOrDefault<String>(
                                            getJsonField(
                                              widget.bookingDetails,
                                              r'''$.car_name''',
                                            ).toString(),
                                            'Mercedes',
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .primary,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        Text(
                                          valueOrDefault<String>(
                                            getJsonField(
                                              widget.bookingDetails,
                                              r'''$.car_manufacturer''',
                                            ).toString(),
                                            'Bens w176',
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .primary,
                                                fontSize: 12.0,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ].divide(SizedBox(width: 8.0)),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'vy3zwxy0' /* $ */,
                                  ),
                                  textAlign: TextAlign.end,
                                  style: FlutterTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterTheme.of(context).info,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      widget.bookingDetails,
                                      r'''$.car_cost''',
                                    ).toString(),
                                    '\$202',
                                  ),
                                  textAlign: TextAlign.end,
                                  style: FlutterTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterTheme.of(context).info,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                  child: VerticalDivider(
                                    thickness: 1.0,
                                    color: FlutterTheme.of(context).accent4,
                                  ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    getJsonField(
                                      widget.bookingDetails,
                                      r'''$.price_type''',
                                    ).toString(),
                                    'day',
                                  ),
                                  textAlign: TextAlign.start,
                                  style: FlutterTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color:
                                            FlutterTheme.of(context).accent2,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment:
                      CrossAxisAlignment.stretch,
                      children: [

                        Column(
                          mainAxisSize:
                          MainAxisSize.max,
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .stretch,
                          children: [
                            Text("Location",
                              // FFLocalizations.of(
                              //     context)
                              //     .getText(
                              //   'lochcfgh' /* Features */,
                              // ),
                              style: FlutterTheme
                                  .of(context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                fontSize: 16,
                                fontWeight:
                                FontWeight
                                    .w500,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              FFLocalizations.of(
                                  context)
                                  .getText(
                                'vmuwnnz6' /* Pickup Address */,
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
                                    .primary,
                                fontSize:
                                16,
                                fontWeight:
                                FontWeight
                                    .w700,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                // color: Color(0xffEFEFF0)
                              ),
                              child: Text(
                                widget.pickupLocation,
                                textAlign:
                                TextAlign
                                    .start,overflow: TextOverflow.ellipsis,
                                style: FlutterTheme
                                    .of(context)
                                    .bodyMedium
                                    .override(
                                    fontFamily:
                                    'Urbanist',
                                    color: Color(0xff6F7C8E),
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    fontSize: 13
                                ),
                              ),
                            ),
                            Divider(
                              color:Color(0xff64748B3B) ,
                            ),
                            Text(
                              "Drop off Address",
                              style:
                              FlutterTheme.of(
                                  context)
                                  .bodyMedium
                                  .override(
                                fontFamily:
                                'Urbanist',
                                color: FlutterTheme.of(
                                    context)
                                    .primary,
                                fontSize:
                                16,
                                fontWeight:
                                FontWeight
                                    .w700,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                // color: Color(0xffEFEFF0)
                              ),
                              child: Text(
                                widget.dropoffLocation,
                                textAlign:
                                TextAlign
                                    .start,
                                style: FlutterTheme
                                    .of(context)
                                    .bodyMedium
                                    .override(
                                    fontFamily:
                                    'Urbanist',
                                    color: Color(0xff6F7C8E),
                                    fontWeight:
                                    FontWeight
                                        .w400,
                                    fontSize: 13
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisSize:
                            //       MainAxisSize.max,
                            //   mainAxisAlignment:
                            //       MainAxisAlignment
                            //           .spaceBetween,
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         BaseUrlGroup
                            //             .bookingdetailCall
                            //             .address(
                            //               histroyDetailPageBookingdetailResponse
                            //                   .jsonBody,
                            //             )
                            //             .toString(),
                            //         textAlign:
                            //             TextAlign
                            //                 .center,
                            //         style: FlutterTheme
                            //                 .of(context)
                            //             .bodyMedium
                            //             .override(
                            //               fontFamily:
                            //                   'Urbanist',
                            //               color: FlutterTheme.of(
                            //                       context)
                            //                   .accent3,
                            //               fontWeight:
                            //                   FontWeight
                            //                       .normal,
                            //             ),
                            //       ),
                            //     ),
                            //     FaIcon(
                            //       FontAwesomeIcons
                            //           .exchangeAlt,
                            //       color: FlutterTheme
                            //               .of(context)
                            //           .secondaryText,
                            //       size: 30.0,
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         BaseUrlGroup
                            //             .bookingdetailCall
                            //             .dropOffAddress(
                            //               histroyDetailPageBookingdetailResponse
                            //                   .jsonBody,
                            //             )
                            //             .toString(),
                            //         textAlign:
                            //             TextAlign
                            //                 .center,
                            //         style: FlutterTheme
                            //                 .of(context)
                            //             .bodyMedium
                            //             .override(
                            //               fontFamily:
                            //                   'Urbanist',
                            //               color: FlutterTheme.of(
                            //                       context)
                            //                   .accent3,
                            //               fontWeight:
                            //                   FontWeight
                            //                       .normal,
                            //             ),
                            //       ),
                            //     ),
                            //   ].divide(SizedBox(
                            //       width: 8.0)),
                            // ),
                          ],
                        ),


                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Your Details",
                          style: FlutterTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Urbanist',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _model.textController1,
                          focusNode: _model.textFieldFocusNode1,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: FFLocalizations.of(context).getText(
                              'g8u9edbp' /* Full Name */,
                            ),
                            hintText: FFLocalizations.of(context).getText(
                              'xck1b5m9' /* Name */,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle:
                            FlutterTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Color(0xff7C8BA0),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: FlutterTheme.of(context).bodyMedium,
                          validator: _model.textController1Validator
                              .asValidator(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _model.textController2,
                          focusNode: _model.textFieldFocusNode2,
                          obscureText: false,
                          decoration: InputDecoration(
                            // fillColor: Color(0xffEFEFF0),
                            // filled: true,
                            labelText: FFLocalizations.of(context).getText(
                              'neqmcvn4' /* Mobile Number */,
                            ),
                            hintText: FFLocalizations.of(context).getText(
                              '8cgwoodc' /* Mobile Number */,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle:
                            FlutterTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Color(0xff7C8BA0),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: FlutterTheme.of(context).bodyMedium,
                          validator: _model.textController2Validator
                              .asValidator(context),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _model.textController3,
                          focusNode: _model.textFieldFocusNode3,
                          obscureText: false,
                          decoration: InputDecoration(
                            // fillColor: Color(0xffEFEFF0),
                            // filled: true,
                            labelText: FFLocalizations.of(context).getText(
                              'q0u6kl6c' /* Email */,
                            ),
                            hintText: FFLocalizations.of(context).getText(
                              'n6r3zyp1' /* Email */,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                            hintStyle:
                            FlutterTheme.of(context).labelMedium,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Color(0xff7C8BA0),
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          style: FlutterTheme.of(context).bodyMedium,
                          validator: _model.textController3Validator
                              .asValidator(context),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      mainAxisSize:
                      MainAxisSize.max,
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .stretch,
                      children: [
                        // Text(
                        //   FFLocalizations.of(
                        //       context)
                        //       .getText(
                        //     '0ril64r9' /* Pickup and Return */,
                        //   ),
                        //   style: FlutterTheme.of(context)
                        //       .bodyMedium
                        //       .override(
                        //     fontFamily: 'Urbanist',
                        //     fontSize: 18.0,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // Text(
                        //   widget.daysAndHourlyType
                        //       ? 'Start Date'
                        //       : 'Start Time',
                        //
                        //   style:
                        //   FlutterTheme.of(
                        //       context)
                        //       .bodyMedium
                        //       .override(
                        //     fontFamily:
                        //     'Urbanist',
                        //     color: FlutterTheme.of(
                        //         context)
                        //         .primary,
                        //     fontSize:
                        //   16,
                        //     fontWeight:
                        //     FontWeight
                        //         .w600,
                        //   ),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: FlutterTheme.of(context).secondary
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month,color: Colors.white,size: 20,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        widget.pickupDate,
                                        '1.1',
                                      ),
                                      textAlign:
                                      TextAlign
                                          .start,
                                      style: FlutterTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Urbanist',
                                        color:Colors.white,fontSize: 14,
                                        fontWeight:
                                        FontWeight
                                            .w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: FlutterTheme.of(context).secondary
                              ),

                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_month,color: Colors.white,size: 20,),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      valueOrDefault<String>(
                                        widget.dropoffDate,
                                        '1.1',
                                      ),
                                      textAlign:
                                      TextAlign
                                          .start,
                                      style: FlutterTheme
                                          .of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily:
                                        'Urbanist',
                                        color:Colors.white,fontSize: 14,
                                        fontWeight:
                                        FontWeight
                                            .w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Text(
                        //   widget.daysAndHourlyType
                        //       ? 'End Date'
                        //       : 'End Time',
                        //   style:
                        //   FlutterTheme.of(
                        //       context)
                        //       .bodyMedium
                        //       .override(
                        //     fontFamily:
                        //     'Urbanist',
                        //     color: FlutterTheme.of(
                        //         context)
                        //         .primary,
                        //     fontSize:
                        //     16,
                        //     fontWeight:
                        //     FontWeight
                        //         .w600,
                        //   ),
                        // ),

                        // Row(
                        //   mainAxisSize:
                        //       MainAxisSize.max,
                        //   mainAxisAlignment:
                        //       MainAxisAlignment
                        //           .spaceBetween,
                        //   children: [
                        //     Expanded(
                        //       child: Text(
                        //         BaseUrlGroup
                        //             .bookingdetailCall
                        //             .startdate(
                        //               histroyDetailPageBookingdetailResponse
                        //                   .jsonBody,
                        //             )
                        //             .toString(),
                        //         textAlign:
                        //             TextAlign
                        //                 .center,
                        //         style: FlutterTheme
                        //                 .of(context)
                        //             .bodyMedium
                        //             .override(
                        //               fontFamily:
                        //                   'Urbanist',
                        //               color: FlutterTheme.of(
                        //                       context)
                        //                   .accent3,
                        //               fontWeight:
                        //                   FontWeight
                        //                       .normal,
                        //             ),
                        //       ),
                        //     ),
                        //     FaIcon(
                        //       FontAwesomeIcons
                        //           .exchangeAlt,
                        //       color: FlutterTheme
                        //               .of(context)
                        //           .secondaryText,
                        //       size: 30.0,
                        //     ),
                        //     Expanded(
                        //       child: Text(
                        //         BaseUrlGroup
                        //             .bookingdetailCall
                        //             .endData(
                        //               histroyDetailPageBookingdetailResponse
                        //                   .jsonBody,
                        //             )
                        //             .toString(),
                        //         textAlign:
                        //             TextAlign
                        //                 .center,
                        //         style: FlutterTheme
                        //                 .of(context)
                        //             .bodyMedium
                        //             .override(
                        //               fontFamily:
                        //                   'Urbanist',
                        //               color: FlutterTheme.of(
                        //                       context)
                        //                   .accent3,
                        //               fontWeight:
                        //                   FontWeight
                        //                       .normal,
                        //             ),
                        //       ),
                        //     ),
                        //   ].divide(SizedBox(
                        //       width: 8.0)),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'uwxzfxa2' /* License photo back and fornt */,
                      ),
                      style: FlutterTheme.of(context)
                          .bodyMedium
                          .override(
                        fontFamily: 'Urbanist',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // In the build method, display the images using Image.file wrapped with ClipRRect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 93,
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.licenceForntImage != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Border radius
                            child: Image.file(
                              File(widget.licenceForntImage!.name.toString()),
                              fit: BoxFit.cover, // adjust this as needed
                            ),
                          )
                              : Placeholder(), // or any other placeholder widget
                        ),
                        SizedBox(width: 10), // add some space between the images
                        Container(
                          height: 93,
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: widget.licenceForntImage != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(10), // Border radius
                            child: Image.file(
                              File(widget.licenceBackImage!.name.toString()),
                              fit: BoxFit.cover, // adjust this as needed
                            ),
                          )
                              : Placeholder(), // or any other placeholder widget
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Builder(
                      builder: (context) {
                        if (widget.daysAndHourlyType) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                              "Rental Fees",
                                style: FlutterTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) {
                                      if (widget.driverType == 'Driver') {
                                        return Container(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                   "Vehicle Cost",
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                      color: Color(0xff25212E),
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.w400,
                                                        ),
                                                  ),
                                                  // Text(
                                                  //   formatNumber(
                                                  //     widget.totalDays,
                                                  //     formatType:
                                                  //         FormatType.decimal,
                                                  //     decimalType: DecimalType
                                                  //         .periodDecimal,
                                                  //   ),
                                                  //   style: FlutterTheme.of(
                                                  //           context)
                                                  //       .bodyMedium
                                                  //       .override(
                                                  //         fontFamily:
                                                  //             'Urbanist',
                                                  //     color: Color(0xff25212E),
                                                  //     fontSize: 16.0,
                                                  //     fontWeight: FontWeight.w400,
                                                  //       ),
                                                  // ),
                                                  // Text(
                                                  //   getJsonField(
                                                  //     widget.bookingDetails,
                                                  //     r'''$.price_type''',
                                                  //   ).toString(),
                                                  //   style: FlutterTheme.of(
                                                  //           context)
                                                  //       .bodyMedium
                                                  //       .override(
                                                  //         fontFamily:
                                                  //             'Urbanist',
                                                  //     color: Color(0xff25212E),
                                                  //     fontSize: 16.0,
                                                  //     fontWeight: FontWeight.w400,
                                                  //       ),
                                                  // ),
                                                  // Text(
                                                  //   FFLocalizations.of(context)
                                                  //       .getText(
                                                  //     'cc8dnbt7' /* driver */,
                                                  //   ),
                                                  //   style: FlutterTheme.of(
                                                  //           context)
                                                  //       .bodyMedium
                                                  //       .override(
                                                  //         fontFamily:
                                                  //             'Urbanist',
                                                  //     color: Color(0xff25212E),
                                                  //     fontSize: 16.0,
                                                  //     fontWeight: FontWeight.w400,
                                                  //       ),
                                                  // ),
                                                ].divide(SizedBox(width: 2.0)),
                                              ),
                                              // Text(
                                              //   formatNumber(
                                              //     widget.totalDays,
                                              //     formatType:
                                              //         FormatType.decimal,
                                              //     decimalType: DecimalType
                                              //         .periodDecimal,
                                              //   ),
                                              //   style: FlutterTheme.of(
                                              //           context)
                                              //       .bodyMedium
                                              //       .override(
                                              //         fontFamily:
                                              //             'Urbanist',
                                              //     color: Color(0xff25212E),
                                              //     fontSize: 16.0,
                                              //     fontWeight: FontWeight.w400,
                                              //       ),
                                              // ),
                                              Text(
                                                valueOrDefault<String>(
                                                  formatNumber(
                                                    functions.multiplayData(
                                                        widget.driverType ==
                                                                'Driver'
                                                            ? functions.newstringToDouble(
                                                                BaseUrlGroup
                                                                    .driverPriceCall
                                                                    .price(
                                                                      (_model.apiResulPrice
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )
                                                                    .toString())
                                                            : functions.newstringToDouble(
                                                                BaseUrlGroup
                                                                    .driverPriceCall
                                                                    .price(
                                                                      (_model.apiResulPrice
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    )
                                                                    .toString()),
                                                        widget.daysAndHourlyType
                                                            ? widget.totalDays
                                                                ?.toDouble()
                                                            : widget.totalDays
                                                                ?.toDouble()),
                                                    formatType:
                                                        FormatType.decimal,
                                                    decimalType: DecimalType
                                                        .periodDecimal,
                                                    currency: '\$',
                                                  ),
                                                  '0.0',
                                                ),
                                                style: FlutterTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                  color: Color(0xff25212E),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                            ].divide(SizedBox(width: 2.0)),
                                          ),
                                        );
                                      } else {
                                        return Text(
                                          FFLocalizations.of(context).getText(
                                            'm60be12x' /*   */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                            color: Color(0xff25212E),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                              ),
                                        );
                                      }
                                    },
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "Total ",
                                            style: FlutterTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          // Text(
                                          //   formatNumber(
                                          //     widget.totalDays,
                                          //     formatType: FormatType.decimal,
                                          //     decimalType:
                                          //         DecimalType.periodDecimal,
                                          //   ),
                                          //   style: FlutterTheme.of(
                                          //           context)
                                          //       .bodyMedium
                                          //       .override(
                                          //         fontFamily: 'Urbanist',
                                          //         color: FlutterTheme.of(
                                          //                 context)
                                          //             .accent2,
                                          //         fontSize: 18.0,
                                          //         fontWeight: FontWeight.bold,
                                          //       ),
                                          // ),
                                          Text(
                                            FFLocalizations.of(context)
                                                .getText(
                                              'npjj1f7n' /* days */,
                                            ),
                                            style: FlutterTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            formatNumber(
                                              widget.totalDays,
                                              formatType: FormatType.decimal,
                                              decimalType:
                                              DecimalType.periodDecimal,
                                            ),
                                            style: FlutterTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context)
                                                .getText(
                                              'npjj1f7n' /* days */,
                                            ),
                                            style: FlutterTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Text(
                                      //   valueOrDefault<String>(
                                      //     formatNumber(
                                      //       functions.multiplayData(
                                      //           functions.newstringToDouble(
                                      //               getJsonField(
                                      //             widget.bookingDetails,
                                      //             r'''$.car_cost''',
                                      //           ).toString()),
                                      //           widget.totalDays?.toDouble()),
                                      //       formatType: FormatType.decimal,
                                      //       decimalType:
                                      //           DecimalType.periodDecimal,
                                      //       currency: '\$',
                                      //     ),
                                      //     '0.0',
                                      //   ),
                                      //   style: FlutterTheme.of(context)
                                      //       .bodyMedium
                                      //       .override(
                                      //         fontFamily: 'Urbanist',
                                      //         color:
                                      //             FlutterTheme.of(context)
                                      //                 .accent2,
                                      //         fontSize: 18.0,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      // ),
                                    ].divide(SizedBox(width: 2.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "Total ",
                                            style: FlutterTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          // Text(
                                          //   formatNumber(
                                          //     widget.totalDays,
                                          //     formatType: FormatType.decimal,
                                          //     decimalType:
                                          //         DecimalType.periodDecimal,
                                          //   ),
                                          //   style: FlutterTheme.of(
                                          //           context)
                                          //       .bodyMedium
                                          //       .override(
                                          //         fontFamily: 'Urbanist',
                                          //         color: FlutterTheme.of(
                                          //                 context)
                                          //             .accent2,
                                          //         fontSize: 18.0,
                                          //         fontWeight: FontWeight.bold,
                                          //       ),
                                          // ),
                                          Text(
                                           "Days" ,
                                            style: FlutterTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          Text(
                                            " Amount",
                                            style: FlutterTheme.of(
                                                context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),

                                      Text(
                                        valueOrDefault<String>(
                                          formatNumber(
                                            functions.multiplayData(
                                                functions.newstringToDouble(
                                                    getJsonField(
                                                  widget.bookingDetails,
                                                  r'''$.car_cost''',
                                                ).toString()),
                                                widget.totalDays?.toDouble()),
                                            formatType: FormatType.decimal,
                                            decimalType:
                                                DecimalType.periodDecimal,
                                            currency: '\$',
                                          ),
                                          '0.0',
                                        ),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                          color: Color(0xff25212E),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 2.0)),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text(
                                            "Coupon Amount ",
                                            style: FlutterTheme.of(
                                                    context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),

                                          // Text(
                                          //   formatNumber(
                                          //     widget.totalDays,
                                          //     formatType: FormatType.decimal,
                                          //     decimalType:
                                          //         DecimalType.periodDecimal,
                                          //   ),
                                          //   style: FlutterTheme.of(
                                          //           context)
                                          //       .bodyMedium
                                          //       .override(
                                          //         fontFamily: 'Urbanist',
                                          //         color: FlutterTheme.of(
                                          //                 context)
                                          //             .accent2,
                                          //         fontSize: 18.0,
                                          //         fontWeight: FontWeight.bold,
                                          //       ),
                                          // ),
                                        ],
                                      ),

                                      Text(
                                       widget.coupon_code.toString(),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                          color: Color(0xff25212E),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 2.0)),
                                  ),
                                  Divider(
                                    thickness: 1.0,
                                    color:
                                        FlutterTheme.of(context).accent4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          FFLocalizations.of(context).getText(
                                            'tfodefb4' /* Total fees */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                            color: Color(0xff25212E),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ),
                                      Text(
                                        widget.totalAmount,
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                          color: Color(0xff25212E),
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w400,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 2.0)),
                                  ),
                                ],
                              ),
                            ].divide(SizedBox(height: 8.0)),
                          );
                        } else {
                          return Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color:
                                FlutterTheme.of(context).secondaryBackground,
                            // elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                   "Rental Fees",
                                    style: FlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (widget.driverType == 'Driver') {
                                            return Container( padding: EdgeInsetsDirectional.fromSTEB(
                                                8.0, 0.0, 8.0, 0.0),
                                              height: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Color(0xffEFEFF0)
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'a4vmimgx' /* Total of  */,
                                                          ),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                color: Color(0xff25212E),
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.w400,
                                                                  ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<String>(
                                                            formatNumber(
                                                              widget.hoursAndMin,
                                                              formatType: FormatType
                                                                  .decimal,
                                                              decimalType:
                                                                  DecimalType
                                                                      .periodDecimal,
                                                            ),
                                                            '0',
                                                          ),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                color: Color(0xff25212E),
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.w400,
                                                                  ),
                                                        ),
                                                        Text(
                                                          valueOrDefault<String>(
                                                            getJsonField(
                                                              widget.bookingDetails,
                                                              r'''$.price_type''',
                                                            ).toString(),
                                                            '0',
                                                          ),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                color: Color(0xff25212E),
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.w400,
                                                                  ),
                                                        ),
                                                        Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'meoh2eql' /* driver */,
                                                          ),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                color: Color(0xff25212E),
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.w400,
                                                                  ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 2.0)),
                                                    ),
                                                  ),
                                                  Text(
                                                    valueOrDefault<String>(
                                                      formatNumber(
                                                        functions.multiplayData(
                                                            widget.driverType ==
                                                                    'Driver'
                                                                ? functions.newstringToDouble(
                                                                    BaseUrlGroup
                                                                        .driverPriceCall
                                                                        .price(
                                                                          (_model.apiResulPrice
                                                                                  ?.jsonBody ??
                                                                              ''),
                                                                        )
                                                                        .toString())
                                                                : 0.0,
                                                            widget.daysAndHourlyType
                                                                ? widget.hoursAndMin
                                                                : widget
                                                                    .hoursAndMin),
                                                        formatType:
                                                            FormatType.decimal,
                                                        decimalType: DecimalType
                                                            .periodDecimal,
                                                        currency: '\$',
                                                      ),
                                                      '0.0',
                                                    ),
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Urbanist',
                                                      color: Color(0xff25212E),
                                                      fontSize: 16.0,
                                                      fontWeight: FontWeight.w400,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(width: 2.0)),
                                              ),
                                            );
                                          } else {
                                            return Text(
                                              FFLocalizations.of(context).getText(
                                                '10teyk1y' /*   */,
                                              ),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                color: Color(0xff25212E),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                  ),
                                            );
                                          }
                                        },
                                      ),
                                      Container( padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 0.0),
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Color(0xffEFEFF0)
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    'x6nm0quf' /* Total of  */,
                                                  ),
                                                  style: FlutterTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                    color: Color(0xff25212E),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w400,
                                                      ),
                                                ),
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      widget.hoursAndMin,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.periodDecimal,
                                                    ),
                                                    '0',
                                                  ),
                                                  style: FlutterTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                    color: Color(0xff25212E),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w400,
                                                      ),
                                                ),
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '805xt1d3' /* hourly */,
                                                  ),
                                                  style: FlutterTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                    color: Color(0xff25212E),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w400,
                                                      ),
                                                ),
                                              ].divide(SizedBox(width: 2.0)),
                                            ),
                                            Text(
                                              valueOrDefault<String>(
                                                formatNumber(
                                                  functions.multiplayData(
                                                      functions.newstringToDouble(
                                                          getJsonField(
                                                        widget.bookingDetails,
                                                        r'''$.car_cost''',
                                                      ).toString()),
                                                      widget.hoursAndMin),
                                                  formatType: FormatType.decimal,
                                                  decimalType:
                                                      DecimalType.periodDecimal,
                                                  currency: '\$',
                                                ),
                                                '0.0',
                                              ),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                color: Color(0xff25212E),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 2.0)),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 1.0,
                                        color:
                                            FlutterTheme.of(context).accent4,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              FFLocalizations.of(context).getText(
                                                '4geu19oq' /* Total fees */,
                                              ),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                color: Color(0xff553FA5),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w400,
                                                  ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'i2sq1i0t' /*  $ */,
                                                ),
                                                style: FlutterTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                  color: Color(0xff553FA5),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                              Text(
                                                valueOrDefault<String>(
                                                  widget.totalAmount,
                                                  '0.0',
                                                ),
                                                style: FlutterTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                  color: Color(0xff553FA5),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ].divide(SizedBox(width: 2.0)),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(height: 8.0)),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    // InkWell(
                    //   splashColor: Colors.transparent,
                    //   focusColor: Colors.transparent,
                    //   hoverColor: Colors.transparent,
                    //   highlightColor: Colors.transparent,
                    //   onTap: () async {
                    //     context.pushNamed('add_my_payment_page');
                    //   },
                    //   child: Card(
                    //     clipBehavior: Clip.antiAliasWithSaveLayer,
                    //     color: FlutterTheme.of(context).secondaryBackground,
                    //     // elevation: 4.0,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     child: Padding(
                    //       padding:
                    //           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.max,
                    //         crossAxisAlignment: CrossAxisAlignment.stretch,
                    //         children: [
                    //           Column(
                    //             mainAxisSize: MainAxisSize.max,
                    //             crossAxisAlignment: CrossAxisAlignment.stretch,
                    //             children: [
                    //               Row(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   Expanded(
                    //                     child: Text(
                    //                       FFLocalizations.of(context).getText(
                    //                         '3nsfzryp' /* Payment method */,
                    //                       ),
                    //                       style: FlutterTheme.of(context)
                    //                           .bodyMedium
                    //                           .override(
                    //                             fontFamily: 'Urbanist',
                    //                             color:
                    //                                 FlutterTheme.of(context)
                    //                                     .primary,
                    //                             fontSize: 18.0,
                    //                             fontWeight: FontWeight.w600,
                    //                           ),
                    //                     ),
                    //                   ),
                    //                 ].divide(SizedBox(width: 8.0)),
                    //               ),
                    //               Row(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 children: [
                    //                   Icon(
                    //                     Icons.add_card,
                    //                     color: FlutterTheme.of(context)
                    //                         .secondaryText,
                    //                     size: 24.0,
                    //                   ),
                    //                   Expanded(
                    //                     child: Text(
                    //                       FFLocalizations.of(context).getText(
                    //                         'k90w4e0g' /* **** **** **** 1234 */,
                    //                       ),
                    //                       style: FlutterTheme.of(context)
                    //                           .bodyMedium
                    //                           .override(
                    //                             fontFamily: 'Urbanist',
                    //                             color:
                    //                                 FlutterTheme.of(context)
                    //                                     .primary,
                    //                             fontSize: 18.0,
                    //                             fontWeight: FontWeight.w600,
                    //                           ),
                    //                     ),
                    //                   ),
                    //                 ].divide(SizedBox(width: 8.0)),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  4.0, 4.0, 4.0, 4.0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  print("======widget.licenceForntImage?.name ?? ''==${widget.licenceForntImage?.name}");
                                  print("======widget.licenceBackImage?.name ?? ''==${widget.licenceBackImage?.name}");
                                  _model.responseDataCopy =
                                      await BaseUrlGroup.bookingCall.call(
                                    carId: getJsonField(
                                      widget.bookingDetails,
                                      r'''$.car_id''',
                                    ).toString(),
                                    userId: FFAppState().UserId,
                                    taxes: '2.0',
                                    userName: _model.textController1.text,
                                    contact: _model.textController2.text,
                                    address: widget.pickupLocation,
                                    endDate: widget.dropoffDate,
                                    tripCost: widget.totalAmount,
                                    startDate: widget.pickupDate,
                                    driverType: widget.driverType,
                                    licenceFront:
                                        widget.licenceForntImage?.name ?? '',
                                    licenceBack:
                                        widget.licenceBackImage?.name ?? '',
                                    supplierid: widget.supplierid,
                                    priceType: getJsonField(
                                      widget.bookingDetails,
                                      r'''$.price_type''',
                                    ).toString(),
                                    dropOffAddress: widget.dropoffLocation,
                                  );
                                  if (getJsonField(
                                    (_model.responseDataCopy?.jsonBody ?? ''),
                                    r'''$.response''',
                                  )) {
                                    context.pushNamed(
                                      'booking_successfully_page',
                                      queryParameters: {
                                        'carName': serializeParam(
                                          getJsonField(
                                            widget.bookingDetails,
                                            r'''$.car_name''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                        'pickLocation': serializeParam(
                                          widget.pickupLocation,
                                          ParamType.String,
                                        ),
                                        'username':serializeParam(
                                          widget.userName,
                                          ParamType.String,
                                        ),

                                        'ownername': serializeParam(
                                          widget.ownername,
                                          ParamType.String,
                                        ),
                                        'dropoffLocation': serializeParam(
                                          widget.dropoffLocation,
                                          ParamType.String,
                                        ),
                                        'pickupdate': serializeParam(
                                          widget.pickupDate,
                                          ParamType.String,
                                        ),
                                        'dropoffDate': serializeParam(
                                          widget.dropoffDate,
                                          ParamType.String,
                                        ),
                                        'parDayRent': serializeParam(
                                          '120',
                                          ParamType.String,
                                        ),
                                        'totalAmount': serializeParam(
                                          widget.totalAmount,
                                          ParamType.String,
                                        ),
                                        'totalFees': serializeParam(
                                          '21.2',
                                          ParamType.String,
                                        ),
                                        'responseData': serializeParam(
                                          widget.bookingDetails,
                                          ParamType.JSON,
                                        ),
                                        'car_type': serializeParam(
                                          widget.car_type,
                                          ParamType.String,
                                        ),
                                        'coupon_code': serializeParam(
                                          widget.coupon_code,
                                          ParamType.String,
                                        ),
                                        'user_name': serializeParam(
                                          widget.userName,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (alertDialogContext) {
                                        return AlertDialog(
                                          title: Text('Notice'),
                                          content: Text(getJsonField(
                                            (_model.responseDataCopy?.jsonBody ??
                                                ''),
                                            r'''$.message''',
                                          ).toString()),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                  alertDialogContext),
                                              child: Text('Ok'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }

                                  setState(() {});
                                },
                                text:"Pay",
                                // text: FFLocalizations.of(context).getText(
                                //   'qsa14vpn' /* Pay now */,
                                // ),
                                options: FFButtonOptions(
                                  height: 50.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 24.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterTheme.of(context).btnclr,
                                  textStyle: FlutterTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: Colors.white,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          // Expanded(
                          //   child: Padding(
                          //     padding: EdgeInsetsDirectional.fromSTEB(
                          //         4.0, 4.0, 4.0, 4.0),
                          //     child: FFButtonWidget(
                          //       onPressed: () async {
                          //         print("======widget.licenceForntImage?.name ?? ''==${widget.licenceForntImage?.name}");
                          //         print("======widget.licenceBackImage?.name ?? ''==${widget.licenceBackImage?.name}");
                          //         _model.responseDataCopy =
                          //             await BaseUrlGroup.bookingCall.call(
                          //           carId: getJsonField(
                          //             widget.bookingDetails,
                          //             r'''$.car_id''',
                          //           ).toString(),
                          //           userId: FFAppState().UserId,
                          //           taxes: '2.0',
                          //           userName: _model.textController1.text,
                          //           contact: _model.textController2.text,
                          //           address: widget.pickupLocation,
                          //           endDate: widget.dropoffDate,
                          //           tripCost: widget.totalAmount,
                          //           startDate: widget.pickupDate,
                          //           driverType: widget.driverType,
                          //           licenceFront:
                          //               widget.licenceForntImage?.name ?? '',
                          //           licenceBack:
                          //               widget.licenceBackImage?.name ?? '',
                          //           supplierid: widget.supplierid,
                          //           priceType: getJsonField(
                          //             widget.bookingDetails,
                          //             r'''$.price_type''',
                          //           ).toString(),
                          //           dropOffAddress: widget.dropoffLocation,
                          //         );
                          //         if (getJsonField(
                          //           (_model.responseDataCopy?.jsonBody ?? ''),
                          //           r'''$.response''',
                          //         )) {
                          //           context.pushNamed(
                          //             'booking_successfully_page',
                          //             queryParameters: {
                          //               'carName': serializeParam(
                          //                 getJsonField(
                          //                   widget.bookingDetails,
                          //                   r'''$.car_name''',
                          //                 ).toString(),
                          //                 ParamType.String,
                          //               ),
                          //               'pickLocation': serializeParam(
                          //                 widget.pickupLocation,
                          //                 ParamType.String,
                          //               ),
                          //               'dropoffLocation': serializeParam(
                          //                 widget.dropoffLocation,
                          //                 ParamType.String,
                          //               ),
                          //               'pickupdate': serializeParam(
                          //                 widget.pickupDate,
                          //                 ParamType.String,
                          //               ),
                          //               'dropoffDate': serializeParam(
                          //                 widget.dropoffDate,
                          //                 ParamType.String,
                          //               ),
                          //               'parDayRent': serializeParam(
                          //                 '120',
                          //                 ParamType.String,
                          //               ),
                          //               'totalAmount': serializeParam(
                          //                 widget.totalAmount,
                          //                 ParamType.String,
                          //               ),
                          //               'totalFees': serializeParam(
                          //                 '21.2',
                          //                 ParamType.String,
                          //               ),
                          //               'responseData': serializeParam(
                          //                 widget.bookingDetails,
                          //                 ParamType.JSON,
                          //               ),
                          //             }.withoutNulls,
                          //           );
                          //         } else {
                          //           await showDialog(
                          //             context: context,
                          //             builder: (alertDialogContext) {
                          //               return AlertDialog(
                          //                 title: Text('Notice'),
                          //                 content: Text(getJsonField(
                          //                   (_model.responseDataCopy?.jsonBody ??
                          //                       ''),
                          //                   r'''$.message''',
                          //                 ).toString()),
                          //                 actions: [
                          //                   TextButton(
                          //                     onPressed: () => Navigator.pop(
                          //                         alertDialogContext),
                          //                     child: Text('Ok'),
                          //                   ),
                          //                 ],
                          //               );
                          //             },
                          //           );
                          //         }
                          //
                          //         setState(() {});
                          //       },
                          //       text: FFLocalizations.of(context).getText(
                          //         'fub301no' /* Pay at Pick-up */,
                          //       ),
                          //       options: FFButtonOptions(
                          //         height: 50.0,
                          //         padding: EdgeInsetsDirectional.fromSTEB(
                          //             24.0, 0.0, 24.0, 0.0),
                          //         iconPadding: EdgeInsetsDirectional.fromSTEB(
                          //             0.0, 0.0, 0.0, 0.0),
                          //         color: FlutterTheme.of(context).btnclr,
                          //         textStyle: FlutterTheme.of(context)
                          //             .titleSmall
                          //             .override(
                          //               fontFamily: 'Urbanist',
                          //               color: Colors.white,
                          //             ),
                          //         elevation: 3.0,
                          //         borderSide: BorderSide(
                          //           color: Colors.transparent,
                          //           width: 1.0,
                          //         ),
                          //         borderRadius: BorderRadius.circular(8.0),
                          //       ),
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ].divide(SizedBox(height: 8.0)).around(SizedBox(height: 8.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
