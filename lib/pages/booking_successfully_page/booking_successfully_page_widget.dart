import 'package:flutter_svg/svg.dart';

import '../../constant.dart';
import '../../invoice_screen_confirmation.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'booking_successfully_page_model.dart';
export 'booking_successfully_page_model.dart';

class BookingSuccessfullyPageWidget extends StatefulWidget {
  const BookingSuccessfullyPageWidget({
    Key? key,
    String? carName,
    String? coupon_code,
    String? car_type,
    String? username,
    String? ownername,
    String? pickLocation,
    String? dropoffLocation,
    String? pickupdate,
    String? dropoffDate,
    String? parDayRent,
    String? totalAmount,
    String? totalFees,
    required this.responseData,
  })  : this.carName = carName ?? 'mini',
        this.pickLocation = pickLocation ?? 'h',
        this.dropoffLocation = dropoffLocation ?? 'h',
        this.pickupdate = pickupdate ?? 'h',
        this.dropoffDate = dropoffDate ?? 'h',
        this.coupon_code = coupon_code ?? 'h',
        this.ownername = ownername ?? 'h',
        this.username = username ?? 'h',
        this.car_type = car_type ?? 'h',
        this.parDayRent = parDayRent ?? 'h',
        this.totalAmount = totalAmount ?? 'h',
        this.totalFees = totalFees ?? 'h',
        super(key: key);

  final String carName;
  final String pickLocation;
  final String dropoffLocation;
  final String pickupdate;
  final String ownername;
  final String username;
  final String dropoffDate;
  final String car_type;
  final String parDayRent;
  final String coupon_code;
  final String totalAmount;
  final String totalFees;
  final dynamic responseData;

  @override
  _BookingSuccessfullyPageWidgetState createState() =>
      _BookingSuccessfullyPageWidgetState();
}

class _BookingSuccessfullyPageWidgetState
    extends State<BookingSuccessfullyPageWidget> {
  late BookingSuccessfullyPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingSuccessfullyPageModel());
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
          backgroundColor: FlutterTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/background_confirmation.svg',
                        // width: 170.0,
                        //  height: 130.0,
                        fit: BoxFit.contain,
                      ),
                      SvgPicture.asset(
                        'assets/images/confirmation_icon.svg',
                        // width: 170.0,
                        //  height: 130.0,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                      "Booking Successful!",
                        style: FlutterTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Urbanist',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                      "Your Amount Payable",
                        style: FlutterTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Urbanist',
                          fontSize: 14.0,
                          color: Color(0xff553FA5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                         "\$${widget.totalAmount} ",
                        style: FlutterTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Urbanist',
                          fontSize: 32.0,
                          color: Color(0xff553FA5),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/5,

                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          DateTime currentTime = DateTime.now();
                          HelperClass.moveToScreenwithPush(
                              context,
                              InvoiceScreen(
                                pdate: widget.pickupdate,
                                ddate: widget.dropoffDate,
                                car_category: widget.carName,
                                car_type: widget.car_type,
                                payment_time: currentTime.toString(), payment_method: 'Cash Payment',
                                customer_name: widget.username, car_owner: widget.ownername, totalFees: widget.totalAmount, coupon_amount: widget.coupon_code,
                                invoice_number: '',
                                // Pass the current time here
                              )
                          );},
                        text: "Generate Invoice",
                        options: FFButtonOptions(
                          height: 46.0,
                          width: MediaQuery.of(context).size.width/1.2,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              40.0, 0.0, 40.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Color(0xffF0F0F0),
                          textStyle: FlutterTheme.of(context)
                              .titleSmall
                              .override(
                            fontFamily: 'Urbanist',fontSize: 16,fontWeight: FontWeight.w400,
                            color: Color(0xff211506),
                          ),
                          elevation: 3.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      SizedBox(
                        height:20,

                      ),
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed('HomePage');
                                },
                                text: FFLocalizations.of(context).getText(
                                  'feux1yxi' /* Go To Home */,
                                ),
                                options: FFButtonOptions(
                                  height: 50.0,
                                  width: MediaQuery.of(context).size.width/1.2,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      40.0, 0.0, 40.0, 0.0),
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
                    ],
                  )
                  // Column(
                  //   mainAxisSize: MainAxisSize.max,
                  //   children: [
                  //     Icon(
                  //       Icons.check_circle_outline,
                  //       color: FlutterTheme.of(context).secondary,
                  //       size: 100.0,
                  //     ),
                  //     Text(
                  //       FFLocalizations.of(context).getText(
                  //         '8sk7o7zk' /* Booking Successfully */,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //       style: FlutterTheme.of(context).bodyMedium.override(
                  //             fontFamily: 'Urbanist',
                  //             fontSize: 18.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //     ),
                  //     Text(
                  //       FFLocalizations.of(context).getText(
                  //         'c8p568dk' /* You've booked car successfully... */,
                  //       ),
                  //       textAlign: TextAlign.center,
                  //       style: FlutterTheme.of(context).bodyMedium.override(
                  //             fontFamily: 'Urbanist',
                  //             fontSize: 16.0,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //     ),
                  //   ].divide(SizedBox(height: 8.0)),
                  // ),
                  // Card(
                  //   clipBehavior: Clip.antiAliasWithSaveLayer,
                  //   color: FlutterTheme.of(context).secondaryBackground,
                  //   elevation: 4.0,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  //   child: Padding(
                  //     padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  //     child: Column(
                  //       mainAxisSize: MainAxisSize.max,
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         Text(
                  //           FFLocalizations.of(context).getText(
                  //             'v344iihr' /* Summary */,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //           style:
                  //               FlutterTheme.of(context).bodyMedium.override(
                  //                     fontFamily: 'Urbanist',
                  //                     fontSize: 20.0,
                  //                     fontWeight: FontWeight.bold,
                  //                   ),
                  //         ),
                  //         Column(
                  //           mainAxisSize: MainAxisSize.max,
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: [
                  //             Text(
                  //               FFLocalizations.of(context).getText(
                  //                 'n8oog2rh' /* Car */,
                  //               ),
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).accent3,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //             ),
                  //             Text(
                  //               widget.carName,
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).primary,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //             ),
                  //           ],
                  //         ),
                  //         Column(
                  //           mainAxisSize: MainAxisSize.max,
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: [
                  //             Text(
                  //               FFLocalizations.of(context).getText(
                  //                 'nhpxkroy' /* Trip pickup  */,
                  //               ),
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).accent3,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //             ),
                  //             Text(
                  //               widget.pickLocation,
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).primary,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //             ),
                  //             Text(
                  //               FFLocalizations.of(context).getText(
                  //                 '8ryhnx7i' /* Return address */,
                  //               ),
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).accent3,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //             ),
                  //             Text(
                  //               widget.dropoffLocation,
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).primary,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //             ),
                  //           ].divide(SizedBox(height: 4.0)),
                  //         ),
                  //         Column(
                  //           mainAxisSize: MainAxisSize.max,
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: [
                  //             Text(
                  //               FFLocalizations.of(context).getText(
                  //                 'nbn06gp4' /* Trip start date */,
                  //               ),
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).accent3,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //             ),
                  //             Text(
                  //               widget.pickupdate,
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).primary,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //             ),
                  //             Text(
                  //               FFLocalizations.of(context).getText(
                  //                 'mbowpdmn' /* Return date */,
                  //               ),
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).accent3,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //             ),
                  //             Text(
                  //               widget.dropoffDate,
                  //               textAlign: TextAlign.start,
                  //               style: FlutterTheme.of(context)
                  //                   .bodyMedium
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: FlutterTheme.of(context).primary,
                  //                     fontSize: 16.0,
                  //                     fontWeight: FontWeight.w600,
                  //                   ),
                  //             ),
                  //           ].divide(SizedBox(height: 4.0)),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsetsDirectional.fromSTEB(
                  //               8.0, 8.0, 8.0, 8.0),
                  //           child: Card(
                  //             clipBehavior: Clip.antiAliasWithSaveLayer,
                  //             color: FlutterTheme.of(context)
                  //                 .secondaryBackground,
                  //             elevation: 4.0,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8.0),
                  //             ),
                  //             child: Padding(
                  //               padding: EdgeInsetsDirectional.fromSTEB(
                  //                   8.0, 8.0, 8.0, 8.0),
                  //               child: Column(
                  //                 mainAxisSize: MainAxisSize.max,
                  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                  //                 children: [
                  //                   Column(
                  //                     mainAxisSize: MainAxisSize.max,
                  //                     children: [
                  //                       Row(
                  //                         mainAxisSize: MainAxisSize.max,
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                         children: [
                  //                           Expanded(
                  //                             child: Text(
                  //                               FFLocalizations.of(context)
                  //                                   .getText(
                  //                                 'dur2igv0' /* Total fees */,
                  //                               ),
                  //                               style: FlutterTheme.of(
                  //                                       context)
                  //                                   .bodyMedium
                  //                                   .override(
                  //                                     fontFamily: 'Urbanist',
                  //                                     color: FlutterTheme.of(
                  //                                             context)
                  //                                         .secondary,
                  //                                     fontSize: 18.0,
                  //                                     fontWeight: FontWeight.bold,
                  //                                   ),
                  //                             ),
                  //                           ),
                  //                           Row(
                  //                             mainAxisSize: MainAxisSize.max,
                  //                             children: [
                  //                               Text(
                  //                                 FFLocalizations.of(context)
                  //                                     .getText(
                  //                                   'wbgpvwye' /*  $ */,
                  //                                 ),
                  //                                 textAlign: TextAlign.end,
                  //                                 style: FlutterTheme.of(
                  //                                         context)
                  //                                     .bodyMedium
                  //                                     .override(
                  //                                       fontFamily: 'Urbanist',
                  //                                       color:
                  //                                           FlutterTheme.of(
                  //                                                   context)
                  //                                               .secondary,
                  //                                       fontSize: 18.0,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                     ),
                  //                               ),
                  //                               Text(
                  //                                 widget.totalAmount,
                  //                                 textAlign: TextAlign.end,
                  //                                 style: FlutterTheme.of(
                  //                                         context)
                  //                                     .bodyMedium
                  //                                     .override(
                  //                                       fontFamily: 'Urbanist',
                  //                                       color:
                  //                                           FlutterTheme.of(
                  //                                                   context)
                  //                                               .secondary,
                  //                                       fontSize: 18.0,
                  //                                       fontWeight:
                  //                                           FontWeight.bold,
                  //                                     ),
                  //                               ),
                  //                             ],
                  //                           ),
                  //                         ].divide(SizedBox(width: 2.0)),
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ].divide(SizedBox(height: 8.0)),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: EdgeInsetsDirectional.fromSTEB(
                  //               4.0, 4.0, 4.0, 4.0),
                  //           child: FFButtonWidget(
                  //             onPressed: () async {
                  //               context.pushNamed('HomePage');
                  //             },
                  //             text: FFLocalizations.of(context).getText(
                  //               'feux1yxi' /* Go To Home */,
                  //             ),
                  //             options: FFButtonOptions(
                  //               height: 50.0,
                  //               padding: EdgeInsetsDirectional.fromSTEB(
                  //                   24.0, 0.0, 24.0, 0.0),
                  //               iconPadding: EdgeInsetsDirectional.fromSTEB(
                  //                   0.0, 0.0, 0.0, 0.0),
                  //               color: FlutterTheme.of(context).secondary,
                  //               textStyle: FlutterTheme.of(context)
                  //                   .titleSmall
                  //                   .override(
                  //                     fontFamily: 'Urbanist',
                  //                     color: Colors.white,
                  //                   ),
                  //               elevation: 3.0,
                  //               borderSide: BorderSide(
                  //                 color: Colors.transparent,
                  //                 width: 1.0,
                  //               ),
                  //               borderRadius: BorderRadius.circular(8.0),
                  //             ),
                  //           ),
                  //         ),
                  //       ].divide(SizedBox(height: 8.0)),
                  //     ),
                  //   ),
                  // ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
