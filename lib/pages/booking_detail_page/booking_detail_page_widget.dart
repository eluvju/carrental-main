import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';
import 'package:http/http.dart'as http;
import '../../constant.dart';
import '../../model/rating_model.dart';
import '../../notificationservice/local_notification_service.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/alert_cancel_page_widget.dart';
import '/components/alert_controller_back_page_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'booking_detail_page_model.dart';
export 'booking_detail_page_model.dart';

class BookingDetailPageWidget extends StatefulWidget {
  const BookingDetailPageWidget({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  final double? bookingId;

  @override
  _BookingDetailPageWidgetState createState() =>
      _BookingDetailPageWidgetState();
}

class _BookingDetailPageWidgetState extends State<BookingDetailPageWidget> {
  late BookingDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<ApiCallResponse> _apiCallResponseFuture;
  bool isExpanded = false;
  double _currentRating = 0.0;
  bool _hasRated = false;
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingDetailPageModel());
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
          _apiCallResponseFuture = BaseUrlGroup.bookingdetailCall.call(
            bookingId: widget.bookingId?.toString(),
          );

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
          _apiCallResponseFuture = BaseUrlGroup.bookingdetailCall.call(
            bookingId: widget.bookingId?.toString(),
          );
          // Helper.checkInternet(deliveriesdeatailsApi());
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
      future: BaseUrlGroup.bookingdetailCall.call(
        bookingId: widget.bookingId?.toString(),
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
        final bookingDetailPageBookingdetailResponse = snapshot.data!;
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
            //   leading: FlutterIconButton(
            //     borderColor: Colors.transparent,
            //     borderRadius: 30.0,
            //     borderWidth: 1.0,
            //     buttonSize: 102.0,
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: FlutterTheme.of(context).primaryText,
            //       size: 30.0,
            //     ),
            //     onPressed: () async {
            //       context.pop();
            //     },
            //   ),
            //   title: Text(
            //     FFLocalizations.of(context).getText(
            //       'z5umyfkd' /* Booking Details */,
            //     ),
            //     style: FlutterTheme.of(context).headlineMedium.override(
            //           fontFamily: 'Urbanist',
            //           color: FlutterTheme.of(context).primaryText,
            //           fontSize: 22.0,
            //         ),
            //   ),
            //   actions: [],
            //   centerTitle: true,
            //   elevation: 2.0,
            // ),
            // appBar: AppBar(
            //   backgroundColor: FlutterTheme.of(context).secondaryBackground,
            //   automaticallyImplyLeading: false,
            //   title: Text(
            //     FFLocalizations.of(context).getText(
            //       'z5umyfkd' /* Booking */,
            //     ),
            //     style: FlutterTheme.of(context).headlineMedium.override(
            //         fontFamily: 'Urbanist',
            //         color: FlutterTheme.of(context).primaryText,
            //         fontSize: 18.0,fontWeight: FontWeight.w500
            //     ),
            //   ),
            //   actions: [],
            //   centerTitle: true,
            //   elevation: 2.0,
            // ),
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
              title: Text(
                FFLocalizations.of(context).getText(
                  'z5umyfkd' /* More Filter */,
                ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                    BaseUrlGroup.bookingdetailCall.carImage(
                                      bookingDetailPageBookingdetailResponse
                                          .jsonBody,
                                    )[0].toString(),
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
                                  itemCount: BaseUrlGroup.bookingdetailCall.carImage(
                                    bookingDetailPageBookingdetailResponse.jsonBody,
                                  ).length - 1, // Exclude the 0th index
                                  itemBuilder: (context, index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          BaseUrlGroup.bookingdetailCall.carImage(
                                            bookingDetailPageBookingdetailResponse.jsonBody,
                                          )[index + 1].toString(), // Start from the 1st index
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
                          // Row(
                          //   children: [
                          //     Container(
                          //       width: 72,
                          //       height: 24,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xffFFFFFF
                          //         ),
                          //         border: Border.all(
                          //             color: Color(0xff0D0C0F),width: 0.5
                          //         ),
                          //         borderRadius: BorderRadius.circular(8.0),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 0.0,vertical: 0),
                          //         child: Row(
                          //           children: [
                          //             SizedBox(
                          //               width: 5,
                          //             ),
                          //             Icon(Icons.star,size: 11,color: Color(0xffFFBB35),),
                          //             SizedBox(
                          //               width: 5,
                          //             ),
                          //             Text(
                          //               "4.7", style: FlutterTheme.of(context).titleSmall.override(
                          //                 fontFamily: 'Urbanist',
                          //                 color: Color(0xff0D0C0F),fontSize: 12,fontWeight: FontWeight.w600
                          //             ),
                          //             ),
                          //             Text(
                          //               "(109)", style: FlutterTheme.of(context).titleSmall.override(
                          //                 fontFamily: 'Urbanist',fontSize: 12,
                          //                 color: Color(0xff7C8BA0),fontWeight: FontWeight.w400
                          //             ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 8.8,
                          //     ),
                          //     Container(
                          //       width: 85,
                          //       height: 24,
                          //       decoration: BoxDecoration(
                          //         color: Color(0xff4ADB06).withOpacity(0.06),
                          //         borderRadius: BorderRadius.circular(6.0),
                          //       ),
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 0),
                          //         child: Center(
                          //           child: Text(
                          //             "Available now", style: FlutterTheme.of(context).titleSmall.override(
                          //               fontFamily: 'Urbanist',
                          //               color: Color(0xff4ADB06),fontSize: 12
                          //           ),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   width: 8.8,
                          // ),
                          // Row(
                          //   children: [
                          //     Container(
                          //       height: 26,
                          //       width: 101,
                          //       decoration: BoxDecoration(
                          //           color: Colors.grey.withOpacity(0.2),
                          //           borderRadius: BorderRadius.circular(5)
                          //       ),
                          //       child: Row(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Icon(Icons.directions_walk,color: Color(0xff7C8BA0),size: 12,),
                          //           // Text(
                          //           //   widget.distance.toString(), style: FlutterTheme.of(context).titleSmall.override(
                          //           //     fontFamily: 'Urbanist',
                          //           //     color: Color(0xff0D0C0F),fontSize: 12,fontWeight: FontWeight.w600
                          //           // ),
                          //           // ),
                          //           // Text(
                          //           //   " ( ${widget.time})" ,style: FlutterTheme.of(context).titleSmall.override(
                          //           //     fontFamily: 'Urbanist',fontSize: 12,
                          //           //     color: Color(0xff7C8BA0),fontWeight: FontWeight.w400
                          //           // ),
                          //           // ),
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
                      // Align(
                      //   alignment: AlignmentDirectional(0.00, 1.00),
                      //   child: Stack(
                      //     alignment: AlignmentDirectional(0.0, 1.0),
                      //     children: [
                      //       Container(
                      //         width: double.infinity,
                      //         height: 258.0,
                      //         decoration: BoxDecoration(
                      //           color: Color(0xFFDCD2FF),
                      //         ),
                      //         child: Padding(
                      //           padding: EdgeInsetsDirectional.fromSTEB(
                      //               16.0, 16.0, 16.0, 16.0),
                      //           child: Column(
                      //             mainAxisSize: MainAxisSize.max,
                      //             children: [
                      //               ClipRRect(
                      //                 borderRadius: BorderRadius.circular(8.0),
                      //                 child: Image.network(
                      //                   BaseUrlGroup.bookingdetailCall.carImage(
                      //                     bookingDetailPageBookingdetailResponse
                      //                         .jsonBody,
                      //                   ),
                      //                   width: 320.0,
                      //                   height: 216.0,
                      //                   fit: BoxFit.cover,
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
                      //                   mainAxisSize: MainAxisSize.max,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     Expanded(
                      //                       child: Text(
                      //                         FFLocalizations.of(context).getText(
                      //                           '1dbmam87' /* $ */,
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
                      //                       BaseUrlGroup.bookingdetailCall
                      //                           .carCost(
                      //                             bookingDetailPageBookingdetailResponse
                      //                                 .jsonBody,
                      //                           )
                      //                           .toString(),
                      //                       textAlign: TextAlign.end,
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
                      //                         'x7qgqosd' /* / */,
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
                      //                         BaseUrlGroup.bookingdetailCall
                      //                             .pricetype(
                      //                               bookingDetailPageBookingdetailResponse
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
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                        child: Container(
                          width: double.infinity,
                          height: 76.0,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      BaseUrlGroup.bookingdetailCall
                                          .carManufacture(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      BaseUrlGroup.bookingdetailCall
                                          .carName(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    Text(
                                      BaseUrlGroup.bookingdetailCall
                                          .carMake(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 4.0)),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  BaseUrlGroup.bookingdetailCall
                                      .address(
                                        bookingDetailPageBookingdetailResponse
                                            .jsonBody,
                                      )
                                      .toString(),
                                  style: FlutterTheme.of(context).bodyMedium,
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    RatingBarIndicator(
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star_rounded,
                                        color:
                                            FlutterTheme.of(context).warning,
                                      ),
                                      direction: Axis.horizontal,
                                      rating: functions.newstringToDouble(
                                          BaseUrlGroup.bookingdetailCall
                                              .rating(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
                                              .toString())!,
                                      unratedColor:
                                          FlutterTheme.of(context).accent3,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterTheme.of(context).ashGray,
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         width: double.infinity,
                      //         height: 50.0,
                      //         decoration: BoxDecoration(
                      //           color: FlutterTheme.of(context)
                      //               .secondaryBackground,
                      //           image: DecorationImage(
                      //             fit: BoxFit.cover,
                      //             image: Image.asset(
                      //               'assets/images/contact.png',
                      //             ).image,
                      //           ),
                      //           borderRadius: BorderRadius.circular(31.0),
                      //         ),
                      //         child: Opacity(
                      //           opacity: 0.0,
                      //           child: FFButtonWidget(
                      //             onPressed: () {
                      //               print('Button pressed ...');
                      //             },
                      //             text: '',
                      //             options: FFButtonOptions(
                      //               height: 16.0,
                      //               padding: EdgeInsetsDirectional.fromSTEB(
                      //                   24.0, 0.0, 24.0, 0.0),
                      //               iconPadding: EdgeInsetsDirectional.fromSTEB(
                      //                   0.0, 0.0, 0.0, 0.0),
                      //               color: Color(0x0022282F),
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
                      //               borderRadius: BorderRadius.circular(20.0),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ].divide(SizedBox(height: 12.0)),
                      //   ),
                      // ),
                      // Divider(
                      //   thickness: 1.0,
                      //   color: FlutterTheme.of(context).ashGray,
                      // ),
                      Align(
                        alignment: AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'sac1yk3s' /* Driver Detail */,
                                          ),
                                          textAlign: TextAlign.start,
                                          style: FlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        // InkWell(
                                        //   onTap: () {
                                        //     launchWhatsApp(      BaseUrlGroup.bookingdetailCall
                                        //         .contact(
                                        //       bookingDetailPageBookingdetailResponse
                                        //           .jsonBody,
                                        //     )
                                        //         .toString());
                                        //
                                        //   },
                                        //   child: SvgPicture.asset(
                                        //     'assets/images/whatsapp_2.svg',
                                        //     width: 40.33,
                                        //     height: 40.5,
                                        //   ),
                                        // ),
                                        InkWell(
                                          onTap: () {

                                            launchWhatsApp(      BaseUrlGroup.bookingdetailCall
                                                .driver_country_code(
                                              bookingDetailPageBookingdetailResponse
                                                  .jsonBody,
                                            )
                                                .toString()+BaseUrlGroup.bookingdetailCall
                                                .drivercontact(
                                              bookingDetailPageBookingdetailResponse
                                                  .jsonBody,
                                            )
                                                .toString());
                                            print("====phone=====${BaseUrlGroup.bookingdetailCall
                                                .drivercontact(
                                              bookingDetailPageBookingdetailResponse
                                                  .jsonBody,
                                            )
                                                .toString()+FFAppState().country_code}");
                                            print("FFAppState().country_code${FFAppState().Countrycode}");

                                          },
                                          child: SvgPicture.asset(
                                            'assets/images/whatsapp_2.svg',
                                            width: 40.33,
                                            height: 40.5,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              FFLocalizations.of(context).getText(
                                                'rpgy9djv' /* Driver Name */,
                                              ),
                                              textAlign: TextAlign.start,
                                              maxLines: 200,
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            AutoSizeText(
                                              " :-",
                                              textAlign: TextAlign.start,
                                              maxLines: 200,
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          BaseUrlGroup.bookingdetailCall
                                              .drivername(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                              .toString(),
                                          style: FlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 4.0)),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              FFLocalizations.of(context).getText(
                                                'hffbxk2l' /* Driver Phone Number */,
                                              ),
                                              textAlign: TextAlign.start,
                                              maxLines: 200,
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            AutoSizeText(
                                             " :-",
                                              textAlign: TextAlign.start,
                                              maxLines: 200,
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          BaseUrlGroup.bookingdetailCall
                                              .drivercontact(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                              .toString(),
                                          style: FlutterTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Divider(
                                  thickness: 1.0,
                                  color: FlutterTheme.of(context).ashGray,
                                ),
                                // Padding(
                                //   padding: EdgeInsetsDirectional.fromSTEB(
                                //       8.0, 8.0, 8.0, 8.0),
                                //   child: Column(
                                //     mainAxisSize: MainAxisSize.max,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.stretch,
                                //     children: [
                                //       Column(
                                //         mainAxisSize: MainAxisSize.max,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             FFLocalizations.of(context).getText(
                                //               'fpl9ns3f' /* Car Seats */,
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
                                //             BaseUrlGroup.bookingdetailCall
                                //                 .carSeat(
                                //                   bookingDetailPageBookingdetailResponse
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
                                //         ].divide(SizedBox(height: 4.0)),
                                //       ),
                                //       Column(
                                //         mainAxisSize: MainAxisSize.max,
                                //         crossAxisAlignment:
                                //             CrossAxisAlignment.start,
                                //         children: [
                                //           Text(
                                //             FFLocalizations.of(context).getText(
                                //               'lcww4gsd' /* Descriptions */,
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
                                //             BaseUrlGroup.bookingdetailCall
                                //                 .description(
                                //                   bookingDetailPageBookingdetailResponse
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
                                //         ].divide(SizedBox(height: 4.0)),
                                //       ),
                                //       Column(
                                //         mainAxisSize:
                                //         MainAxisSize.max,
                                //         crossAxisAlignment:
                                //         CrossAxisAlignment
                                //             .stretch,
                                //         children: [
                                //           Text(
                                //             FFLocalizations.of(
                                //                 context)
                                //                 .getText(
                                //               'qczvar83' /* Features */,
                                //             ),
                                //             style: FlutterTheme
                                //                 .of(context)
                                //                 .bodyMedium
                                //                 .override(
                                //               fontFamily:
                                //               'Urbanist',
                                //               fontSize: 20.0,
                                //               fontWeight:
                                //               FontWeight
                                //                   .bold,
                                //             ),
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Automatic transmission : ",
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //               Text(
                                //                 BaseUrlGroup
                                //                     .bookingdetailCall
                                //                     .automatic_transmission(
                                //                   bookingDetailPageBookingdetailResponse
                                //                       .jsonBody,
                                //                 )
                                //                     .toString(),
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Airbags : ",
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //               Text(
                                //                 BaseUrlGroup
                                //                     .bookingdetailCall
                                //                     .air_booking(
                                //                   bookingDetailPageBookingdetailResponse
                                //                       .jsonBody,
                                //                 )
                                //                     .toString(),
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //           Row(
                                //             children: [
                                //               Text(
                                //                 "Safety rating : ",
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //               Text(
                                //                 BaseUrlGroup
                                //                     .bookingdetailCall
                                //                     .safety_raring(
                                //                   bookingDetailPageBookingdetailResponse
                                //                       .jsonBody,
                                //                 )
                                //                     .toString(),
                                //                 style: FlutterTheme
                                //                     .of(context)
                                //                     .bodyMedium
                                //                     .override(
                                //                   fontFamily:
                                //                   'Urbanist',
                                //                   fontSize: 16.0,
                                //                   fontWeight:
                                //                   FontWeight
                                //                       .w500,
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ].divide(
                                //             SizedBox(height: 4.0)),
                                //       ),
                                //     ].divide(SizedBox(height: 8.0)),
                                //   ),
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText('car_details'),
                                      textAlign: TextAlign.start,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                      child: Text(
                                        isExpanded ? FFLocalizations.of(context).getText('view_less') : FFLocalizations.of(context).getText('view_more'),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                          fontFamily: 'Urbanist',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText('descriptions'),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        BaseUrlGroup.carDetailCall
                                            .description(
                                          bookingDetailPageBookingdetailResponse.jsonBody,
                                        )
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
                                if (isExpanded)
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

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context).getText('automatic_transmission'),
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
                                              BaseUrlGroup.carDetailCall
                                                  .automatictransmission(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
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
                                              FFLocalizations.of(context).getText('air_bags'),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                              ),
                                            ),
                                            Text(
                                              BaseUrlGroup.carDetailCall
                                                  .airbooking(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
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
                                              FFLocalizations.of(context).getText('safety_rating'),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                              ),
                                            ),
                                            Text(
                                              BaseUrlGroup.carDetailCall
                                                  .safetyraring(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
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
                                              FFLocalizations.of(context).getText('seats'),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                              ),
                                            ),
                                            Text(
                                              BaseUrlGroup.carDetailCall
                                                  .seat_capacity(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
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
                                              FFLocalizations.of(context).getText('specification'),
                                              style: FlutterTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xff7C8BA0)
                                              ),
                                            ),
                                            Text(
                                              BaseUrlGroup.carDetailCall
                                                  .specification(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
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
                                      ].divide(SizedBox(height: 12.0)),
                                    ),
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
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start ,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [


                                    Container(
                                      height: 93,
                                      width: MediaQuery.of(context).size.width / 2.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          BaseUrlGroup.bookingdetailCall.licencefront(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          ),
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      height: 93,
                                      width: MediaQuery.of(context).size.width / 2.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: Image.network(
                                          BaseUrlGroup.bookingdetailCall.licenceback(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          ),
                                          width: 100.0,
                                          height: 100.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )



                                  ],
                                ),

                                 SizedBox(
                                   height: 10,
                                 ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
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
                                        18.0,
                                        fontWeight:
                                        FontWeight
                                            .w600,
                                      ),
                                    ),
                                    Text(
                                      BaseUrlGroup.bookingdetailCall
                                          .address(
                                        bookingDetailPageBookingdetailResponse
                                            .jsonBody,
                                      )
                                          .toString(),
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
                                    Divider(
                                      color:Color(0xff64748B3B) ,
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText('drop_off_address'),
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
                                        BaseUrlGroup.bookingdetailCall
                                            .dropOffAddress(
                                          bookingDetailPageBookingdetailResponse
                                              .jsonBody,
                                        )
                                            .toString(),
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

                                  ],
                                ),
                                Text(
                                  FFLocalizations.of(
                                      context)
                                      .getText(
                                    '0ril64r9' /* Pickup and Return */,
                                  ),
                                  style: FlutterTheme
                                      .of(context)
                                      .bodyMedium
                                      .override(
                                    fontFamily:
                                    'Urbanist',
                                    fontSize: 18.0,
                                    fontWeight:
                                    FontWeight
                                        .w500,
                                  ),
                                ),
                                // Card(
                                //   clipBehavior:
                                //   Clip.antiAliasWithSaveLayer,
                                //   color: Colors.white,
                                //   elevation: 4.0,
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                //     child: Column(
                                //       mainAxisSize:
                                //       MainAxisSize.max,
                                //       crossAxisAlignment:
                                //       CrossAxisAlignment
                                //           .stretch,
                                //       children: [
                                //
                                //         Text(
                                //           "Pickup date",
                                //           style:
                                //           FlutterTheme.of(
                                //               context)
                                //               .bodyMedium
                                //               .override(
                                //             fontFamily:
                                //             'Urbanist',
                                //             color: FlutterTheme.of(
                                //                 context)
                                //                 .primary,
                                //             fontSize:
                                //             18.0,
                                //             fontWeight:
                                //             FontWeight
                                //                 .w600,
                                //           ),
                                //         ),
                                //         Container(
                                //           decoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(12),
                                //               color: Color(0xffEFEFF0)
                                //           ),
                                //           child: Padding(
                                //             padding: const EdgeInsets.all(15.0),
                                //             child: Text(
                                //               BaseUrlGroup.bookingdetailCall
                                //                   .startdate(
                                //                 bookingDetailPageBookingdetailResponse
                                //                     .jsonBody,
                                //               )
                                //                   .toString(),
                                //               textAlign:
                                //               TextAlign
                                //                   .start,
                                //               style: FlutterTheme
                                //                   .of(context)
                                //                   .bodyMedium
                                //                   .override(
                                //                 fontFamily:
                                //                 'Urbanist',
                                //                 color: FlutterTheme.of(
                                //                     context)
                                //                     .accent3,
                                //                 fontWeight:
                                //                 FontWeight
                                //                     .normal,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         Text(
                                //           "Return date",
                                //           style:
                                //           FlutterTheme.of(
                                //               context)
                                //               .bodyMedium
                                //               .override(
                                //             fontFamily:
                                //             'Urbanist',
                                //             color: FlutterTheme.of(
                                //                 context)
                                //                 .primary,
                                //             fontSize:
                                //             18.0,
                                //             fontWeight:
                                //             FontWeight
                                //                 .w600,
                                //           ),
                                //         ),
                                //         Container(
                                //           decoration: BoxDecoration(
                                //               borderRadius: BorderRadius.circular(12),
                                //               color: Color(0xffEFEFF0)
                                //           ),
                                //           child: Padding(
                                //             padding: const EdgeInsets.all(15.0),
                                //             child: Text(
                                //               BaseUrlGroup.bookingdetailCall
                                //                   .endData(
                                //                 bookingDetailPageBookingdetailResponse
                                //                     .jsonBody,
                                //               )
                                //                   .toString(),
                                //               textAlign:
                                //               TextAlign
                                //                   .start,
                                //               style: FlutterTheme
                                //                   .of(context)
                                //                   .bodyMedium
                                //                   .override(
                                //                 fontFamily:
                                //                 'Urbanist',
                                //                 color: FlutterTheme.of(
                                //                     context)
                                //                     .accent3,
                                //                 fontWeight:
                                //                 FontWeight
                                //                     .normal,
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         // Row(
                                //         //   mainAxisSize:
                                //         //       MainAxisSize.max,
                                //         //   mainAxisAlignment:
                                //         //       MainAxisAlignment
                                //         //           .spaceBetween,
                                //         //   children: [
                                //         //     Expanded(
                                //         //       child: Text(
                                //         //         BaseUrlGroup
                                //         //             .bookingdetailCall
                                //         //             .startdate(
                                //         //               histroyDetailPageBookingdetailResponse
                                //         //                   .jsonBody,
                                //         //             )
                                //         //             .toString(),
                                //         //         textAlign:
                                //         //             TextAlign
                                //         //                 .center,
                                //         //         style: FlutterTheme
                                //         //                 .of(context)
                                //         //             .bodyMedium
                                //         //             .override(
                                //         //               fontFamily:
                                //         //                   'Urbanist',
                                //         //               color: FlutterTheme.of(
                                //         //                       context)
                                //         //                   .accent3,
                                //         //               fontWeight:
                                //         //                   FontWeight
                                //         //                       .normal,
                                //         //             ),
                                //         //       ),
                                //         //     ),
                                //         //     FaIcon(
                                //         //       FontAwesomeIcons
                                //         //           .exchangeAlt,
                                //         //       color: FlutterTheme
                                //         //               .of(context)
                                //         //           .secondaryText,
                                //         //       size: 30.0,
                                //         //     ),
                                //         //     Expanded(
                                //         //       child: Text(
                                //         //         BaseUrlGroup
                                //         //             .bookingdetailCall
                                //         //             .endData(
                                //         //               histroyDetailPageBookingdetailResponse
                                //         //                   .jsonBody,
                                //         //             )
                                //         //             .toString(),
                                //         //         textAlign:
                                //         //             TextAlign
                                //         //                 .center,
                                //         //         style: FlutterTheme
                                //         //                 .of(context)
                                //         //             .bodyMedium
                                //         //             .override(
                                //         //               fontFamily:
                                //         //                   'Urbanist',
                                //         //               color: FlutterTheme.of(
                                //         //                       context)
                                //         //                   .accent3,
                                //         //               fontWeight:
                                //         //                   FontWeight
                                //         //                       .normal,
                                //         //             ),
                                //         //       ),
                                //         //     ),
                                //         //   ].divide(SizedBox(
                                //         //       width: 8.0)),
                                //         // ),
                                //       ],
                                //     ),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month,color: Colors.white,size: 20,),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .startdate(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
                                                  .toString(),
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
                                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                                        child: Row(
                                          children: [
                                            Icon(Icons.calendar_month,color: Colors.white,size: 20,),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .endData(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
                                                  .toString(),
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
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'yfakuji7' /* Rental  Amount */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'aalh5yj0' /* Total fees */,
                                                ),
                                                style: FlutterTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .secondary,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '57a4seeo' /*  $ */,
                                              ),
                                              style: FlutterTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color:
                                                        FlutterTheme.of(
                                                                context)
                                                            .secondary,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .tripeCost(
                                                    bookingDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString(),
                                              style: FlutterTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color:
                                                        FlutterTheme.of(
                                                                context)
                                                            .secondary,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                  ),
                                            ),
                                          ].divide(SizedBox(width: 2.0)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'booking_status'),
                                      // FFLocalizations.of(context).getText(
                                      //   'yfakuji7' /* Rental  Amount */,
                                      // ),

                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                               "Status",

                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                      context)
                                                      .primary,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              (BaseUrlGroup
                                                  .bookingdetailCall
                                                  .status(
                                                bookingDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )
                                                  .toString()  == "1")
                                                  ? FFLocalizations.of(context).getText('booking_status_open')
                                                  : (BaseUrlGroup.bookingdetailCall.status(bookingDetailPageBookingdetailResponse.jsonBody,).toString()  == "2")
                                                  ? FFLocalizations.of(context).getText('booking_status_accepted')
                                                  : (BaseUrlGroup.bookingdetailCall.status(bookingDetailPageBookingdetailResponse.jsonBody,).toString()  == "3")
                                                  ? FFLocalizations.of(context).getText('booking_status_picked_up')
                                                  : FFLocalizations.of(context).getText('booking_status_delivered'),
                                              style: FlutterTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                FlutterTheme.of(
                                                    context)
                                                    .accent3,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 2.0)),
                                        ),
                                        BaseUrlGroup.bookingdetailCall.status(bookingDetailPageBookingdetailResponse.jsonBody,).toString()  == "1"||
                                            BaseUrlGroup.bookingdetailCall.status(bookingDetailPageBookingdetailResponse.jsonBody,).toString()  == "2"||
                                            BaseUrlGroup.bookingdetailCall.status(bookingDetailPageBookingdetailResponse.jsonBody,).toString()  == "3"?
                                        SizedBox():
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                FFLocalizations.of(context).getText('rate_car'),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                      context)
                                                      .primary,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),

                                            RatingBar.builder(
                                              initialRating:double.parse(
                                                  BaseUrlGroup.bookingdetailCall.rate(bookingDetailPageBookingdetailResponse.jsonBody).toString()
                                              )==0 ?_currentRating:double.parse(
                                                  BaseUrlGroup.bookingdetailCall.rate(bookingDetailPageBookingdetailResponse.jsonBody).toString()
                                              ),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,

                                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                String carId = BaseUrlGroup.bookingdetailCall
                                                    .carid(bookingDetailPageBookingdetailResponse.jsonBody)
                                                    .toString();
                                                String order_id = BaseUrlGroup.bookingdetailCall
                                                    .bookingId(bookingDetailPageBookingdetailResponse.jsonBody)
                                                    .toString();

                                                if (double.parse(
                                                    BaseUrlGroup.bookingdetailCall.rate(bookingDetailPageBookingdetailResponse.jsonBody).toString()
                                                )==0) {
                                                  // Proceed with the rating API call
                                                  Helper.checkInternet(ratingapi(rating.toString(), carId, order_id));

                                                  if (!_hasRated) {
                                                    setState(() {
                                                      _currentRating = rating;
                                                      _hasRated = true; // Set the flag to true after rating
                                                    });

                                                    // Optionally, show a confirmation message
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text("Thank you for your rating!"),
                                                      ),
                                                    );
                                                  }
                                                } else {
                                                  // Show a message that the user has already rated
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text("You have already rated this."),
                                                    ),
                                                  );
                                                }
                                              },
                                              // Disable interaction if the user has already rated or if the existing rating is not 0.0
                                              ignoreGestures: _hasRated || double.parse(
                                                  BaseUrlGroup.bookingdetailCall.rate(bookingDetailPageBookingdetailResponse.jsonBody).toString()
                                              ) != 0,
                                            ),

                                          ].divide(SizedBox(width: 2.0)),
                                        ),
                                      ],
                                    ),
                                  ].divide(SizedBox(height: 8.0)),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Expanded(
                                    //   child: Opacity(
                                    //     opacity: BaseUrlGroup.bookingdetailCall
                                    //                 .status(
                                    //                   bookingDetailPageBookingdetailResponse
                                    //                       .jsonBody,
                                    //                 )
                                    //                 .toString() ==
                                    //             '1'
                                    //         ? 1.0
                                    //         : 0.5,
                                    //     child: Builder(
                                    //       builder: (context) => FFButtonWidget(
                                    //         onPressed: BaseUrlGroup
                                    //                     .bookingdetailCall
                                    //                     .status(
                                    //                       bookingDetailPageBookingdetailResponse
                                    //                           .jsonBody,
                                    //                     )
                                    //                     .toString() !=
                                    //                 '1'
                                    //             ? null
                                    //             : () async {
                                    //                 await showAlignedDialog(
                                    //                   context: context,
                                    //                   isGlobal: true,
                                    //                   avoidOverflow: false,
                                    //                   targetAnchor:
                                    //                       AlignmentDirectional(
                                    //                               0.0, 0.0)
                                    //                           .resolve(
                                    //                               Directionality.of(
                                    //                                   context)),
                                    //                   followerAnchor:
                                    //                       AlignmentDirectional(
                                    //                               0.0, 0.0)
                                    //                           .resolve(
                                    //                               Directionality.of(
                                    //                                   context)),
                                    //                   builder: (dialogContext) {
                                    //                     return Material(
                                    //                       color:
                                    //                           Colors.transparent,
                                    //                       child: GestureDetector(
                                    //                         onTap: () => _model
                                    //                                 .unfocusNode
                                    //                                 .canRequestFocus
                                    //                             ? FocusScope.of(
                                    //                                     context)
                                    //                                 .requestFocus(
                                    //                                     _model
                                    //                                         .unfocusNode)
                                    //                             : FocusScope.of(
                                    //                                     context)
                                    //                                 .unfocus(),
                                    //                         child: Container(
                                    //                           height: 180.0,
                                    //                           width:
                                    //                               double.infinity,
                                    //                           child:
                                    //                               AlertCancelPageWidget(
                                    //                             bookingId:
                                    //                                 formatNumber(
                                    //                               widget
                                    //                                   .bookingId,
                                    //                               formatType:
                                    //                                   FormatType
                                    //                                       .decimal,
                                    //                               decimalType:
                                    //                                   DecimalType
                                    //                                       .periodDecimal,
                                    //                             ),
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     );
                                    //                   },
                                    //                 ).then((value) =>
                                    //                     setState(() {}));
                                    //               },
                                    //         text: FFLocalizations.of(context)
                                    //             .getText(
                                    //           'akx9iwst' /* Cancel */,
                                    //         ),
                                    //         options: FFButtonOptions(
                                    //           width: double.infinity,
                                    //           height: 50.0,
                                    //           padding:
                                    //               EdgeInsetsDirectional.fromSTEB(
                                    //                   0.0, 0.0, 0.0, 0.0),
                                    //           iconPadding:
                                    //               EdgeInsetsDirectional.fromSTEB(
                                    //                   0.0, 0.0, 0.0, 0.0),
                                    //           color: FlutterTheme.of(context)
                                    //               .error,
                                    //           textStyle:
                                    //               FlutterTheme.of(context)
                                    //                   .titleSmall
                                    //                   .override(
                                    //                     fontFamily: 'Urbanist',
                                    //                     color:
                                    //                         FlutterTheme.of(
                                    //                                 context)
                                    //                             .primaryBtnText,
                                    //                   ),
                                    //           elevation: 3.0,
                                    //           borderSide: BorderSide(
                                    //             width: 0.0,
                                    //           ),
                                    //           borderRadius:
                                    //               BorderRadius.circular(25.0),
                                    //           disabledColor:
                                    //               FlutterTheme.of(context)
                                    //                   .accent3,
                                    //           disabledTextColor:
                                    //               FlutterTheme.of(context)
                                    //                   .primaryBtnText,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    Expanded(
                                      child: Builder(
                                        builder: (context) {
                                          if (BaseUrlGroup.bookingdetailCall
                                                  .status(
                                                    bookingDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString() ==
                                              '1') {
                                            return SizedBox();



                                            //   Builder(
                                            //   builder: (context) =>
                                            //       FFButtonWidget(
                                            //     onPressed: () async {
                                            //       _model.apiAcceptResponse =
                                            //           await BaseUrlGroup
                                            //               .acceptCall
                                            //               .call(
                                            //         bookingId: widget.bookingId
                                            //             ?.toString(),
                                            //         userId: FFAppState().UserId,
                                            //       );
                                            //       if ((_model.apiAcceptResponse
                                            //               ?.succeeded ??
                                            //           true)) {
                                            //         await showAlignedDialog(
                                            //           context: context,
                                            //           isGlobal: true,
                                            //           avoidOverflow: false,
                                            //           targetAnchor:
                                            //               AlignmentDirectional(
                                            //                       0.0, 0.0)
                                            //                   .resolve(
                                            //                       Directionality.of(
                                            //                           context)),
                                            //           followerAnchor:
                                            //               AlignmentDirectional(
                                            //                       0.0, 0.0)
                                            //                   .resolve(
                                            //                       Directionality.of(
                                            //                           context)),
                                            //           builder: (dialogContext) {
                                            //             return Material(
                                            //               color:
                                            //                   Colors.transparent,
                                            //               child: GestureDetector(
                                            //                 onTap: () => _model
                                            //                         .unfocusNode
                                            //                         .canRequestFocus
                                            //                     ? FocusScope.of(
                                            //                             context)
                                            //                         .requestFocus(
                                            //                             _model
                                            //                                 .unfocusNode)
                                            //                     : FocusScope.of(
                                            //                             context)
                                            //                         .unfocus(),
                                            //                 child: Container(
                                            //                   height: 200.0,
                                            //                   child:
                                            //                       AlertControllerBackPageWidget(
                                            //                     message:
                                            //                         getJsonField(
                                            //                       (_model.apiAcceptResponse
                                            //                               ?.jsonBody ??
                                            //                           ''),
                                            //                       r'''$.message''',
                                            //                     ).toString(),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             );
                                            //           },
                                            //         ).then((value) =>
                                            //             setState(() {}));
                                            //       } else {
                                            //         await showAlignedDialog(
                                            //           context: context,
                                            //           isGlobal: true,
                                            //           avoidOverflow: false,
                                            //           targetAnchor:
                                            //               AlignmentDirectional(
                                            //                       0.0, 0.0)
                                            //                   .resolve(
                                            //                       Directionality.of(
                                            //                           context)),
                                            //           followerAnchor:
                                            //               AlignmentDirectional(
                                            //                       0.0, 0.0)
                                            //                   .resolve(
                                            //                       Directionality.of(
                                            //                           context)),
                                            //           builder: (dialogContext) {
                                            //             return Material(
                                            //               color:
                                            //                   Colors.transparent,
                                            //               child: GestureDetector(
                                            //                 onTap: () => _model
                                            //                         .unfocusNode
                                            //                         .canRequestFocus
                                            //                     ? FocusScope.of(
                                            //                             context)
                                            //                         .requestFocus(
                                            //                             _model
                                            //                                 .unfocusNode)
                                            //                     : FocusScope.of(
                                            //                             context)
                                            //                         .unfocus(),
                                            //                 child: Container(
                                            //                   height: 200.0,
                                            //                   child:
                                            //                       AlertControllerBackPageWidget(
                                            //                     message:
                                            //                         getJsonField(
                                            //                       (_model.apiAcceptResponse
                                            //                               ?.jsonBody ??
                                            //                           ''),
                                            //                       r'''$.message''',
                                            //                     ).toString(),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             );
                                            //           },
                                            //         ).then((value) =>
                                            //             setState(() {}));
                                            //       }
                                            //
                                            //       setState(() {});
                                            //     },
                                            //     text: FFLocalizations.of(context)
                                            //         .getText(
                                            //       'skx8itm3' /* Pick-up */,
                                            //     ),
                                            //     options: FFButtonOptions(
                                            //       width: double.infinity,
                                            //       height: 50.0,
                                            //       padding: EdgeInsetsDirectional
                                            //           .fromSTEB(
                                            //               0.0, 0.0, 0.0, 0.0),
                                            //       iconPadding:
                                            //           EdgeInsetsDirectional
                                            //               .fromSTEB(
                                            //                   0.0, 0.0, 0.0, 0.0),
                                            //       color:
                                            //           FlutterTheme.of(context)
                                            //               .secondary,
                                            //       textStyle: FlutterTheme.of(
                                            //               context)
                                            //           .titleSmall
                                            //           .override(
                                            //             fontFamily: 'Urbanist',
                                            //             color:
                                            //                 FlutterTheme.of(
                                            //                         context)
                                            //                     .primaryBtnText,
                                            //           ),
                                            //       elevation: 3.0,
                                            //       borderSide: BorderSide(
                                            //         width: 0.0,
                                            //       ),
                                            //       borderRadius:
                                            //           BorderRadius.circular(25.0),
                                            //     ),
                                            //   ),
                                            // );
                                          } else if (BaseUrlGroup
                                                  .bookingdetailCall
                                                  .status(
                                                    bookingDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString() ==
                                              '2') {
                                            return Builder(
                                              builder: (context) =>
                                                  FFButtonWidget(
                                                onPressed: () async {
                                                  _model.apipickupResponse =
                                                      await BaseUrlGroup
                                                          .pickupCall
                                                          .call(
                                                    userId: FFAppState().UserId,
                                                    bookingId: widget.bookingId
                                                        ?.toString(),
                                                  );
                                                  if ((_model.apipickupResponse
                                                          ?.succeeded ??
                                                      true)) {
                                                    await showAlignedDialog(
                                                      context: context,
                                                      isGlobal: true,
                                                      avoidOverflow: false,
                                                      targetAnchor:
                                                          AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      followerAnchor:
                                                          AlignmentDirectional(
                                                                  0.0, 0.0)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
                                                      builder: (dialogContext) {
                                                        return Material(
                                                          color:
                                                              Colors.transparent,
                                                          child: GestureDetector(
                                                            onTap: () => _model
                                                                    .unfocusNode
                                                                    .canRequestFocus
                                                                ? FocusScope.of(
                                                                        context)
                                                                    .requestFocus(
                                                                        _model
                                                                            .unfocusNode)
                                                                : FocusScope.of(
                                                                        context)
                                                                    .unfocus(),
                                                            child: Container(
                                                              height: 200.0,
                                                              child:
                                                                  AlertControllerBackPageWidget(
                                                                message:
                                                                    getJsonField(
                                                                  (_model.apipickupResponse
                                                                          ?.jsonBody ??
                                                                      ''),
                                                                  r'''$.message''',
                                                                ).toString(),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        setState(() {}));
                                                  }

                                                  setState(() {});
                                                },
                                                text: "Pick up the car",
                                                options: FFButtonOptions(
                                                  width: double.infinity,
                                                  height: 50.0,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 0.0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              0.0, 0.0, 0.0, 0.0),
                                                  color:
                                                      FlutterTheme.of(context)
                                                          .secondary,
                                                  textStyle: FlutterTheme.of(
                                                          context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .primaryBtnText,
                                                      ),
                                                  elevation: 3.0,
                                                  borderSide: BorderSide(
                                                    width: 0.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(25.0),
                                                ),
                                              ),
                                            );
                                          }
                                          else if(BaseUrlGroup
                                              .bookingdetailCall
                                              .status(
                                            bookingDetailPageBookingdetailResponse
                                                .jsonBody,
                                          )
                                              .toString() ==
                                              '3')
                                            return FFButtonWidget(
                                            onPressed: () {
                                              showAlertDialog(context);
                                            },
                                            // onPressed: () async {
                                            //   _model.apiCompletedResponse =
                                            //       await BaseUrlGroup
                                            //           .completeCall
                                            //           .call(
                                            //     userId: FFAppState().UserId,
                                            //     bookingId: widget.bookingId
                                            //         ?.toString(),
                                            //   );
                                            //   if ((_model.apiCompletedResponse
                                            //           ?.succeeded ??
                                            //       true)) {
                                            //     context.safePop();
                                            //   }
                                            //
                                            //   setState(() {});
                                            // },
                                            text: "Deliver the car",
                                            options: FFButtonOptions(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                              FlutterTheme.of(context)
                                                  .secondary,
                                              textStyle:
                                              FlutterTheme.of(context)
                                                  .titleSmall
                                                  .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                FlutterTheme.of(
                                                    context)
                                                    .primaryBtnText,
                                              ),
                                              elevation: 3.0,
                                              borderSide: BorderSide(
                                                width: 0.0,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(25.0),
                                            ),
                                          );

                                          else {
                                            return FFButtonWidget(
                                              onPressed: () {
                                                // showAlertDialog(context);
                                              },
                                              // onPressed: () async {
                                              //   _model.apiCompletedResponse =
                                              //       await BaseUrlGroup
                                              //           .completeCall
                                              //           .call(
                                              //     userId: FFAppState().UserId,
                                              //     bookingId: widget.bookingId
                                              //         ?.toString(),
                                              //   );
                                              //   if ((_model.apiCompletedResponse
                                              //           ?.succeeded ??
                                              //       true)) {
                                              //     context.safePop();
                                              //   }
                                              //
                                              //   setState(() {});
                                              // },
                                              text: "Delivered",
                                              options: FFButtonOptions(
                                                width: double.infinity,
                                                height: 50.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                iconPadding: EdgeInsetsDirectional
                                                    .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterTheme.of(context)
                                                        .secondary,
                                                textStyle:
                                                    FlutterTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Urbanist',
                                                          color:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .primaryBtnText,
                                                        ),
                                                elevation: 3.0,
                                                borderSide: BorderSide(
                                                  width: 0.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(25.0),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(height: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 8.0))
                        .addToEnd(SizedBox(height: 20.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  setProgress(bool show)    {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  launchWhatsApp(phone) async {
    final link = WhatsAppUnilink(
      phoneNumber:phone,
      text: "This is carrental app",
    );
    // print("phone number====${country_code+phone}");
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launch('$link');
  }
  Future<void> ratingapi(String rating,String car_id,String order_id) async {

    print("<=============rating=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token': "booking12345",
      'user_id': FFAppState().UserId,
      'car_id':car_id,
      'rate': rating,
      'order_id': order_id,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.rating), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          RatingModel model = RatingModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            // _saveRememberMeStatus();
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);



            setProgress(false);

            print("successs==============");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );

            // context.pushNamed('UserHomePage');
            // ToastMessage.msg(model.message.toString());
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
            //     route) => false);
          } else {
            setProgress(false);
            print("false ### ============>");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
          }
        } catch (e) {
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        //  ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    setProgress(false);
  }
  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Notice!!",
                style: FlutterTheme.of(context).bodyMedium.override(
                  fontFamily:
                  FlutterTheme.of(context).bodyMediumFamily,
                  color: FlutterTheme.of(context).primary,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Text(
                "Are you sure you want to complete this delivery?",
                textAlign: TextAlign.center,
                style: FlutterTheme.of(context).bodyMedium.override(
                  fontFamily:
                  FlutterTheme.of(context).bodyMediumFamily,
                  color: FlutterTheme.of(context).black600,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      FlutterTheme.of(context)
                          .secondary,),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    // Perform actions when "Yes" button is clicked
                    _model.apiCompletedResponse =
                    await BaseUrlGroup.completeCall.call(
                      userId: FFAppState().UserId,
                      bookingId: widget.bookingId?.toString(),
                    );
                    if ((_model.apiCompletedResponse?.succeeded ?? true)) {
                      Navigator.of(context).pop(); // Close dialog
                    }
                    setState(() {});
                  },
                  child: Text(
                    "Yes",
                    textAlign: TextAlign.center,
                    style: FlutterTheme.of(context).bodyMedium.override(
                      fontFamily:
                      FlutterTheme.of(context).bodyMediumFamily,
                      color: FlutterTheme.of(context).primaryBtnText,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(0xFFFE2121),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Helper.popScreen(context);
                  },
                  child: Text(
                    "No",
                    textAlign: TextAlign.center,
                    style: FlutterTheme.of(context).bodyMedium.override(
                      fontFamily:
                      FlutterTheme.of(context).bodyMediumFamily,
                      color: FlutterTheme.of(context).primaryBtnText,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
