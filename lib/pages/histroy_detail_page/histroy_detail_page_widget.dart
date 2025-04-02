import '/backend/api_requests/api_calls.dart';
import '/components/rating_view_page_widget.dart';
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'histroy_detail_page_model.dart';
export 'histroy_detail_page_model.dart';

class HistroyDetailPageWidget extends StatefulWidget {
  const HistroyDetailPageWidget({
    Key? key,
    this.bookingId,
  }) : super(key: key);

  final String? bookingId;

  @override
  _HistroyDetailPageWidgetState createState() =>
      _HistroyDetailPageWidgetState();
}

class _HistroyDetailPageWidgetState extends State<HistroyDetailPageWidget> {
  late HistroyDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistroyDetailPageModel());
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
        bookingId: widget.bookingId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final histroyDetailPageBookingdetailResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 102.0,
                icon: Icon(
                  Icons.arrow_back,
                  color: FlutterTheme.of(context).primaryText,
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                FFLocalizations.of(context).getText(
                  '8vsmwv6i' /* History Details */,
                ),
                style: FlutterTheme.of(context).headlineMedium.override(
                      fontFamily: 'Urbanist',
                      color: FlutterTheme.of(context).primaryText,
                      fontSize: 22.0,
                    ),
              ),
              actions: [],
              centerTitle: true,
              elevation: 2.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.00, 1.00),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0.0, 1.0),
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: 258.0,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDCD2FF),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 16.0, 16.0, 16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  valueOrDefault<String>(
                                                    BaseUrlGroup
                                                        .bookingdetailCall
                                                        .carImage(
                                                      histroyDetailPageBookingdetailResponse
                                                          .jsonBody,
                                                    ),
                                                    'https://images.unsplash.com/photo-1583121274602-3e2820c69888?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw1fHxjYXJzfGVufDB8fHx8MTY5NTEyOTg2N3ww&ixlib=rb-4.0.3&q=80&w=1080',
                                                  ),
                                          // child: Image.asset('assets/images/carimg.png',
                                                  width: 320.0,
                                                  height: 216.0,
                                                  fit: BoxFit.fill
                                          //   ,
                                          //       ),
                                              )),
                                            ].divide(SizedBox(height: 8.0)),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 4.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Container(
                                            width: 226.0,
                                            height: 40.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterTheme.of(context)
                                                      .error,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              border: Border.all(
                                                color:
                                                    FlutterTheme.of(context)
                                                        .primaryBtnText,
                                                width: 3.0,
                                              ),
                                            ),
                                            alignment: AlignmentDirectional(
                                                1.00, 1.00),
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, 0.00),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        1.0, 1.0, 1.0, 1.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'aexfonwp' /* $ */,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                ),
                                                      ),
                                                    ),
                                                    Text(
                                                      BaseUrlGroup
                                                          .bookingdetailCall
                                                          .carCost(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                          .toString(),
                                                      textAlign: TextAlign.end,
                                                      style:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                color: FlutterTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                              ),
                                                    ),
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'irweqdj5' /* / */,
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
                                                                    .primaryBtnText,
                                                              ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        BaseUrlGroup
                                                            .bookingdetailCall
                                                            .pricetype(
                                                              histroyDetailPageBookingdetailResponse
                                                                  .jsonBody,
                                                            )
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterTheme.of(
                                                                          context)
                                                                      .primaryBtnText,
                                                                ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 100.0,
                                    decoration: BoxDecoration(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .carManufacture(
                                                    histroyDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .carName(
                                                    histroyDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                            Text(
                                              BaseUrlGroup.bookingdetailCall
                                                  .carMake(
                                                    histroyDetailPageBookingdetailResponse
                                                        .jsonBody,
                                                  )
                                                  .toString(),
                                              textAlign: TextAlign.start,
                                              style:
                                                  FlutterTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ].divide(SizedBox(width: 4.0)),
                                        ),
                                        Flexible(
                                          child: Text(
                                            BaseUrlGroup.bookingdetailCall
                                                .address(
                                                  histroyDetailPageBookingdetailResponse
                                                      .jsonBody,
                                                )
                                                .toString(),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RatingBarIndicator(
                                                itemBuilder: (context, index) =>
                                                    Icon(
                                                  Icons.star_rounded,
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .warning,
                                                ),
                                                direction: Axis.horizontal,
                                                // rating:
                                                //     functions.newstringToDouble(
                                                //         BaseUrlGroup
                                                //             .bookingdetailCall
                                                //             .rating(
                                                //               histroyDetailPageBookingdetailResponse
                                                //                   .jsonBody,
                                                //             )
                                                //             .toString())!,
                                                unratedColor:
                                                    FlutterTheme.of(context)
                                                        .accent3,
                                                itemCount: 5,
                                                itemSize: 20.0,
                                              ),
                                              BaseUrlGroup
                                                  .bookingdetailCall
                                                  .rating(
                                                histroyDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )=="0.00"|| BaseUrlGroup
                                                  .bookingdetailCall
                                                  .rating(
                                                histroyDetailPageBookingdetailResponse
                                                    .jsonBody,
                                              )=="0" ?
                                              Builder(
                                                builder: (context) =>
                                                    FFButtonWidget(
                                                  onPressed: () async {
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
                                                          color: Colors
                                                              .transparent,
                                                          child:
                                                              GestureDetector(
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
                                                              height: 250.0,
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  RatingViewPageWidget(
                                                                carId: BaseUrlGroup
                                                                    .bookingdetailCall
                                                                    .carid(
                                                                      histroyDetailPageBookingdetailResponse
                                                                          .jsonBody,
                                                                    )
                                                                    .toString(),
                                                                userId:
                                                                    FFAppState()
                                                                        .UserId,
                                                                carData:
                                                                    BaseUrlGroup
                                                                        .bookingdetailCall
                                                                        .data(
                                                                  histroyDetailPageBookingdetailResponse
                                                                      .jsonBody,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        setState(() {}));
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'mf4o3v9b' /* Review */,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 40.0,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(24.0, 0.0,
                                                                24.0, 0.0),
                                                    iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterTheme.of(
                                                            context)
                                                        .secondary,
                                                    textStyle: FlutterTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Colors.white,
                                                        ),
                                                    elevation: 3.0,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                ),
                                              ):SizedBox(),
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
                                Align(
                                  alignment: AlignmentDirectional(0.00, -1.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  FFLocalizations.of(context)
                                                      .getText(
                                                    '0fkd0m1k' /* Driver Detail */,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: FlutterTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily:
                                                            'Urbanist',
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                      ),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    AutoSizeText(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'jin2pifz' /* Driver Name */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 200,
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      BaseUrlGroup
                                                          .bookingdetailCall
                                                          .drivername(
                                                        histroyDetailPageBookingdetailResponse
                                                            .jsonBody,
                                                      )
                                                          .toString(),
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    AutoSizeText(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'z9ac1rtp' /* Driver Phone Number */,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 200,
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                    ),
                                                    Text(
                                                      BaseUrlGroup
                                                          .bookingdetailCall
                                                          .drivercontact(
                                                        histroyDetailPageBookingdetailResponse
                                                            .jsonBody,
                                                      )
                                                          .toString(),
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 12.0)),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1.0,
                                            color: FlutterTheme.of(context).ashGray,
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                // Column(
                                                //   mainAxisSize:
                                                //       MainAxisSize.max,
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment
                                                //           .start,
                                                //   children: [
                                                //     Text(
                                                //       FFLocalizations.of(
                                                //               context)
                                                //           .getText(
                                                //         '880638lp' /* Availability */,
                                                //       ),
                                                //       style: FlutterTheme
                                                //               .of(context)
                                                //           .bodyMedium
                                                //           .override(
                                                //             fontFamily:
                                                //                 'Urbanist',
                                                //             fontSize: 20.0,
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .bold,
                                                //           ),
                                                //     ),
                                                //     AutoSizeText(
                                                //       FFLocalizations.of(
                                                //               context)
                                                //           .getText(
                                                //         'h87bx4ig' /* Minimum Days: 2 Days */,
                                                //       ),
                                                //       textAlign:
                                                //           TextAlign.start,
                                                //       maxLines: 200,
                                                //       style: FlutterTheme
                                                //               .of(context)
                                                //           .bodyMedium
                                                //           .override(
                                                //             fontFamily:
                                                //                 'Urbanist',
                                                //             fontSize: 16.0,
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .w500,
                                                //           ),
                                                //     ),
                                                //   ].divide(
                                                //       SizedBox(height: 4.0)),
                                                // ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '21h5gnww' /* Car Seats */,
                                                      ),
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                    AutoSizeText(
                                                      BaseUrlGroup
                                                          .bookingdetailCall
                                                          .carSeat(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 200,
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        '1ag8ozwz' /* Descriptions */,
                                                      ),
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                    AutoSizeText(
                                                      BaseUrlGroup
                                                          .bookingdetailCall
                                                          .description(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 200,
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                          ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'qczvar83' /* Features */,
                                                      ),
                                                      style: FlutterTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Urbanist',
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                          ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                         "Automatic transmission : ",
                                                          style: FlutterTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        Text(
                                                          BaseUrlGroup
                                                              .bookingdetailCall
                                                              .automatic_transmission(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                              .toString(),
                                                          style: FlutterTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Urbanist',
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Airbags : ",
                                                          style: FlutterTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          BaseUrlGroup
                                                              .bookingdetailCall
                                                              .air_booking(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                              .toString(),
                                                          style: FlutterTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Safety rating : ",
                                                          style: FlutterTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          BaseUrlGroup
                                                              .bookingdetailCall
                                                              .safety_raring(
                                                            histroyDetailPageBookingdetailResponse
                                                                .jsonBody,
                                                          )
                                                              .toString(),
                                                          style: FlutterTheme
                                                              .of(context)
                                                              .bodyMedium
                                                              .override(
                                                            fontFamily:
                                                            'Urbanist',
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 4.0)),
                                                ),
                                              ].divide(SizedBox(height: 8.0)),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                                child: Text("Location",
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
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                                color: Colors.white,
                                                elevation: 4.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(8.0),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
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
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                          color: Color(0xffEFEFF0)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Text(
                                                            BaseUrlGroup
                                                                .bookingdetailCall
                                                                .address(
                                                              histroyDetailPageBookingdetailResponse
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
                                                              color: FlutterTheme.of(
                                                                  context)
                                                                  .accent3,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                        ),
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
                                                          18.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w600,
                                                        ),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: Color(0xffEFEFF0)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Text(
                                                            BaseUrlGroup
                                                                .bookingdetailCall
                                                                .dropOffAddress(
                                                              histroyDetailPageBookingdetailResponse
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
                                                              color: FlutterTheme.of(
                                                                  context)
                                                                  .accent3,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
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
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
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
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                                color: Colors.white,
                                                elevation: 4.0,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [

                                                      Text(
                                                       "Pickup date",
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
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: Color(0xffEFEFF0)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Text(
                                                            BaseUrlGroup
                                                                .bookingdetailCall
                                                                .startdate(
                                                              histroyDetailPageBookingdetailResponse
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
                                                              color: FlutterTheme.of(
                                                                  context)
                                                                  .accent3,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "Return date",
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
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(12),
                                                            color: Color(0xffEFEFF0)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(15.0),
                                                          child: Text(
                                                            BaseUrlGroup
                                                                .bookingdetailCall
                                                                .endData(
                                                              histroyDetailPageBookingdetailResponse
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
                                                              color: FlutterTheme.of(
                                                                  context)
                                                                  .accent3,
                                                              fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                            ),
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
                                                ),
                                              ),
                                            ],
                                          ),
                                          Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: FlutterTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'q36z8wq8' /* Rental  Fee */,
                                                    ),
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'ie29xnxc' /* Total fees */,
                                                              ),
                                                              style: FlutterTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Urbanist',
                                                                    color: FlutterTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                    fontSize:
                                                                        18.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '88euir1v' /*  $ */,
                                                                ),
                                                                style: FlutterTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      color: FlutterTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      fontSize:
                                                                          18.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                              Text(
                                                                BaseUrlGroup
                                                                    .bookingdetailCall
                                                                    .tripeCost(
                                                                      histroyDetailPageBookingdetailResponse
                                                                          .jsonBody,
                                                                    )
                                                                    .toString(),
                                                                style: FlutterTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Urbanist',
                                                                      color: FlutterTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      fontSize:
                                                                          18.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                        ].divide(SizedBox(
                                                            width: 2.0)),
                                                      ),
                                                    ],
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            clipBehavior:
                                                Clip.antiAliasWithSaveLayer,
                                            color: FlutterTheme.of(context)
                                                .secondaryBackground,
                                            elevation: 4.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'bhxchf0e' /* Booking Status */,
                                                    ),
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                  FFButtonWidget(
                                                    onPressed: () {
                                                      print(
                                                          'Button pressed ...');
                                                    },
                                                    text: BaseUrlGroup
                                                                .bookingdetailCall
                                                                .status(
                                                                  histroyDetailPageBookingdetailResponse
                                                                      .jsonBody,
                                                                )
                                                                .toString() ==
                                                            '5'
                                                        ? FFLocalizations.of(context).getText('booking_status_cancelled')
                                                        : FFLocalizations.of(context).getText('booking_status_delivered'),
                                                    options: FFButtonOptions(
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
                                                      color: BaseUrlGroup
                                                                  .bookingdetailCall
                                                                  .status(
                                                                    histroyDetailPageBookingdetailResponse
                                                                        .jsonBody,
                                                                  )
                                                                  .toString() ==
                                                              '5'
                                                          ? Color(0xffFF3B30)
                                                          : Color(0xff4ADB06),
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
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 16.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(height: 12.0)),
                            ),
                          ),
                        ]
                            .divide(SizedBox(height: 8.0))
                            .addToStart(SizedBox(height: 0.0))
                            .addToEnd(SizedBox(height: 16.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
