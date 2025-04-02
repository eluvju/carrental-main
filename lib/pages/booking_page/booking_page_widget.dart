import 'dart:io';
import 'package:car_rental/backend/api_requests/api_constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../constant.dart';
import '../../model/promocode_applied.dart';
import '../../view_all_promocode.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_drop_down.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_radio_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/form_field_controller.dart';
import '/flutter/upload_data.dart';
import '/flutter/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'booking_page_model.dart';
export 'booking_page_model.dart';
import 'package:http/http.dart'as http;

class BookingPageWidget extends StatefulWidget {
  const BookingPageWidget({
    Key? key,
    this.carDetailBooking,
    required this.priceType,
    required this.ownername,
    required this.car_type,
    double? carCost,
    required this.supplierid, required this.carid,
  })  : this.carCost = carCost ?? .0,
        super(key: key);

  final dynamic carDetailBooking;
  final String? priceType;
  final String? ownername;
  final double carCost;
  final String supplierid;
  final String carid;
  final String car_type;


  @override
  _BookingPageWidgetState createState() => _BookingPageWidgetState();
}

class _BookingPageWidgetState extends State<BookingPageWidget> {
  late BookingPageModel _model;
  TextEditingController promocodecontroller=TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  File? _image;
  String imagesource = "";
  final _picker = ImagePicker();
  bool _isVisible = false;
  bool _hashData = false;
  bool _isConfirmBookingLoading = false;
  String _selectedOption = 'Self';
  PromocodeApplied?_promocodeApplyModel;

  bool isDayPriceType(String? priceType) {
    return priceType?.toLowerCase() == 'day';
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingPageModel());

    // setProgress(true);

    print("========carid====${widget.carid.toString()}");
    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _model.daysAndHour = isDayPriceType(widget.priceType);
      });
      setState(() {
        _model.driverAmount = _model.radioButtonValue == 'Self' ? 0 : 50;
      });
      _model.apiResultaPrice = await BaseUrlGroup.driverPriceCall.call();
      if ((_model.apiResultaPrice?.succeeded ?? true)) {
        return;
      }

      return;
    });

    _model.userNameController ??= TextEditingController();
    _model.userNameFocusNode ??= FocusNode();

    _model.customerPhoneNumberController ??= TextEditingController();
    _model.customerPhoneNumberFocusNode ??= FocusNode();
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
            FFLocalizations.of(context).getText('booking'),
            style: FlutterTheme.of(context).headlineMedium.override(
              fontFamily: 'Urbanist',
              color: FlutterTheme.of(context).primaryText,
              fontSize: 18.0,
              fontWeight: FontWeight.w600
            ),
          ),
          actions: [],
          centerTitle: false,
          // elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              FlutterRadioButton(
                            options: [
                              // "Self Drive",
                              FFLocalizations.of(context).getText(
                                'v8no0oyb' /* Self */,
                              ),
                              FFLocalizations.of(context).getText(
                                'jz6j8hga' /* Driver */,
                              )
                            ].toList(),
                            onChanged: (val) async {
                              setState(() {});
                              setState(() {
                                _model.driverType = valueOrDefault<bool>(
                                  _model.radioButtonValue == 'Self'
                                      ? false
                                      : true,
                                  false,
                                );
                              });
                            },
                            controller: _model.radioButtonValueController ??=
                                FormFieldController<String>(
                                    FFLocalizations.of(context).getText(
                                      '6pl2lxl3' /* Self */,
                                    )),
                            optionHeight: 32.0,
                            textStyle: FlutterTheme.of(context).labelMedium,
                            selectedTextStyle:
                            FlutterTheme.of(context).bodyMedium,
                            buttonPosition: RadioButtonPosition.left,
                            direction: Axis.horizontal,
                            radioButtonColor:
                            FlutterTheme.of(context).secondary,
                            inactiveRadioButtonColor:
                            FlutterTheme.of(context).secondaryText,
                            toggleable: false,
                            horizontalAlignment: WrapAlignment.start,
                            verticalAlignment: WrapCrossAlignment.start,
                          ),
                          if (_model.radioButtonValue == 'Driver')
                            Builder(
                              builder: (context) {
                                if (_model.radioButtonValue == 'Driver') {
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      // Text(
                                      //   FFLocalizations.of(context).getText(
                                      //     'gcruivme' /* $ */,
                                      //   ),
                                      //   style: FlutterTheme.of(context)
                                      //       .bodyMedium
                                      //       .override(
                                      //         fontFamily: 'Urbanist',
                                      //         fontSize: 18.0,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      // ),
                                      // Text(
                                      //   BaseUrlGroup.driverPriceCall
                                      //       .price(
                                      //         (_model.apiResultaPrice
                                      //                 ?.jsonBody ??
                                      //             ''),
                                      //       )
                                      //       .toString(),
                                      //   style: FlutterTheme.of(context)
                                      //       .bodyMedium
                                      //       .override(
                                      //         fontFamily: 'Urbanist',
                                      //         fontSize: 18.0,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      // ),
                                      // Text(
                                      //   FFLocalizations.of(context).getText(
                                      //     'o8e8rhpu' /*  Per Days */,
                                      //   ),
                                      //   style: FlutterTheme.of(context)
                                      //       .bodyMedium
                                      //       .override(
                                      //         fontFamily: 'Urbanist',
                                      //         fontSize: 18.0,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      // ),
                                    ],
                                  );
                                } else {
                                  return Text(
                                    FFLocalizations.of(context).getText(
                                      'sobzzdfw' /*   */,
                                    ),
                                    style: FlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Urbanist',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedOption = 'Self';
                      //           _model.driverType = false;
                      //         });
                      //       },
                      //       child: Container(
                      //         height: 46,
                      //         width: MediaQuery.of(context).size.width / 2.2,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: _selectedOption == 'Self' ? Colors.grey : Color(0xffFAFAFA),
                      //         ),
                      //         child: Center(
                      //           child: Text(
                      //             FFLocalizations.of(context).getText('v8no0oyb' /* Self */),
                      //             style: FlutterTheme.of(context).bodyMedium.override(
                      //                 fontFamily: 'Urbanist',
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: _selectedOption == 'Self' ? Colors.white : Color(0xff0D0C0F)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     InkWell(
                      //       onTap: () {
                      //         setState(() {
                      //           _selectedOption = 'Driver';
                      //           _model.driverType = true;
                      //         });
                      //       },
                      //       child: Container(
                      //         height: 46,
                      //         width: MediaQuery.of(context).size.width / 2.2,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(10),
                      //           color: _selectedOption == 'Driver' ? Colors.grey : Color(0xffFAFAFA),
                      //         ),
                      //         child: Center(
                      //           child: Text(
                      //             FFLocalizations.of(context).getText('jz6j8hga' /* Driver */),
                      //             style: FlutterTheme.of(context).bodyMedium.override(
                      //                 fontFamily: 'Urbanist',
                      //                 fontSize: 14,
                      //                 fontWeight: FontWeight.w400,
                      //                 color: _selectedOption == 'Driver' ? Colors.white : Color(0xff0D0C0F)),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),


                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //   child: Card(
                      //     clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     color: FlutterTheme.of(context).secondaryBackground,
                      //     elevation: 4.0,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     child: Padding(
                      //       padding:
                      //           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: [
                      //           Text(
                      //             FFLocalizations.of(context).getText(
                      //               'x1lc4q5d' /* $ */,
                      //             ),
                      //             style: FlutterTheme.of(context)
                      //                 .bodyMedium
                      //                 .override(
                      //                   fontFamily: 'Urbanist',
                      //                   fontSize: 18.0,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           ),
                      //           Text(
                      //             getJsonField(
                      //               widget.carDetailBooking,
                      //               r'''$.car_cost''',
                      //             ).toString(),
                      //             style: FlutterTheme.of(context)
                      //                 .bodyMedium
                      //                 .override(
                      //                   fontFamily: 'Urbanist',
                      //                   fontSize: 18.0,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           ),
                      //           Text(
                      //             FFLocalizations.of(context).getText(
                      //               's3b6u5bv' /*  Per */,
                      //             ),
                      //             style: FlutterTheme.of(context)
                      //                 .bodyMedium
                      //                 .override(
                      //                   fontFamily: 'Urbanist',
                      //                   fontSize: 18.0,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           ),
                      //           Text(
                      //             getJsonField(
                      //               widget.carDetailBooking,
                      //               r'''$.price_type''',
                      //             ).toString(),
                      //             style: FlutterTheme.of(context)
                      //                 .bodyMedium
                      //                 .override(
                      //                   fontFamily: 'Urbanist',
                      //                   fontSize: 18.0,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           ),
                      //         ].divide(SizedBox(width: 2.0)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Text(
                        FFLocalizations.of(context).getText('location'),
                        style: FlutterTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<ApiCallResponse>(
                        future: BaseUrlGroup.locationCall.call(
                            carId: widget.carid
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final conditionalBuilderLocationResponse =
                          snapshot.data!;
                          return Builder(
                            builder: (context) {
                              if (BaseUrlGroup.locationCall.response(
                                conditionalBuilderLocationResponse.jsonBody,
                              )) {
                                return FlutterDropDown<String>(
                                  controller: _model
                                      .pickupLocationValueController ??=
                                      FormFieldController<String>(null),
                                  options: (BaseUrlGroup.locationCall
                                      .locationsList(
                                    conditionalBuilderLocationResponse
                                        .jsonBody,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()!
                                      .map((e) => e.toString())
                                      .toList(),
                                  onChanged: (val) => setState(() =>
                                  _model.pickupLocationValue = val),
                                  width: double.infinity,
                                  height: 50.0,
                                  textStyle: FlutterTheme.of(context)
                                      .bodyMedium,
                                  hintText:
                                  FFLocalizations.of(context).getText(
                                    '7adfhanl' /* Please select pickup location */,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  // fillColor:Color(0xffEFEFF0),
                                  elevation: 0.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                );
                              } else {
                                return Text(
                                  BaseUrlGroup.locationCall
                                      .message(
                                    conditionalBuilderLocationResponse
                                        .jsonBody,
                                  )
                                      .toString(),
                                  style: FlutterTheme.of(context)
                                      .bodyMedium,
                                );
                              }
                            },
                          );
                        },
                      ),
                      Divider(
                        color: Color(0xff64748B3B),
                      ),
                      FutureBuilder<ApiCallResponse>(
                        future: BaseUrlGroup.locationCall.call(
                          carId: widget.carid,
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final conditionalBuilderLocationResponse =
                          snapshot.data!;
                          return Builder(
                            builder: (context) {
                              if (BaseUrlGroup.locationCall.response(
                                conditionalBuilderLocationResponse.jsonBody,
                              )) {
                                return FlutterDropDown<String>(
                                  controller: _model
                                      .dropOffLocationValueController ??=
                                      FormFieldController<String>(null),
                                  options: (BaseUrlGroup.locationCall
                                      .locationsList(
                                    conditionalBuilderLocationResponse
                                        .jsonBody,
                                  ) as List)
                                      .map<String>((s) => s.toString())
                                      .toList()!
                                      .map((e) => e.toString())
                                      .toList(),
                                  onChanged: (val) => setState(() =>
                                  _model.dropOffLocationValue = val),
                                  width: double.infinity,
                                  height: 50.0,
                                  textStyle: FlutterTheme.of(context)
                                      .bodyMedium,
                                  hintText:
                                  FFLocalizations.of(context).getText(
                                    '6bgu8ex7' /* Please select dropoff location */,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: FlutterTheme.of(context)
                                        .secondaryText,
                                    size: 24.0,
                                  ),
                                  // fillColor: FlutterTheme.of(context)
                                  //     .secondaryBackground,
                                  // elevation: 2.0,
                                  // fillColor:Color(0xffEFEFF0),
                                  elevation: 0.0,
                                  borderColor: Colors.transparent,
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
                                  margin: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  hidesUnderline: true,
                                  isSearchable: false,
                                  isMultiSelect: false,
                                );
                              } else {
                                return Text(
                                  BaseUrlGroup.locationCall
                                      .message(
                                    conditionalBuilderLocationResponse
                                        .jsonBody,
                                  )
                                      .toString(),
                                  style: FlutterTheme.of(context)
                                      .bodyMedium,
                                );
                              }
                            },
                          );
                        },
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //   child: Card(
                      //     // clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     // color: FlutterTheme.of(context).secondaryBackground,
                      //     // elevation: 4.0,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     child: Padding(
                      //       padding:
                      //           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //       child: Column(
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: [
                      //           FutureBuilder<ApiCallResponse>(
                      //             future: BaseUrlGroup.locationCall.call(
                      //                 carId: widget.carid
                      //             ),
                      //             builder: (context, snapshot) {
                      //               // Customize what your widget looks like when it's loading.
                      //               if (!snapshot.hasData) {
                      //                 return Center(
                      //                   child: SizedBox(
                      //                     width: 50.0,
                      //                     height: 50.0,
                      //                     child: CircularProgressIndicator(
                      //                       valueColor: AlwaysStoppedAnimation<Color>(
                      //                         FlutterTheme.of(context).primary,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 );
                      //               }
                      //               final conditionalBuilderLocationResponse =
                      //                   snapshot.data!;
                      //               return Builder(
                      //                 builder: (context) {
                      //                   if (BaseUrlGroup.locationCall.response(
                      //                     conditionalBuilderLocationResponse.jsonBody,
                      //                   )) {
                      //                     return FlutterDropDown<String>(
                      //                       controller: _model
                      //                               .pickupLocationValueController ??=
                      //                           FormFieldController<String>(null),
                      //                       options: (BaseUrlGroup.locationCall
                      //                               .locationsList(
                      //                         conditionalBuilderLocationResponse
                      //                             .jsonBody,
                      //                       ) as List)
                      //                           .map<String>((s) => s.toString())
                      //                           .toList()!
                      //                           .map((e) => e.toString())
                      //                           .toList(),
                      //                       onChanged: (val) => setState(() =>
                      //                           _model.pickupLocationValue = val),
                      //                       width: double.infinity,
                      //                       height: 50.0,
                      //                       textStyle: FlutterTheme.of(context)
                      //                           .bodyMedium,
                      //                       hintText:
                      //                           FFLocalizations.of(context).getText(
                      //                         '7adfhanl' /* Please select pickup location */,
                      //                       ),
                      //                       icon: Icon(
                      //                         Icons.keyboard_arrow_down_rounded,
                      //                         color: FlutterTheme.of(context)
                      //                             .secondaryText,
                      //                         size: 24.0,
                      //                       ),
                      //                       fillColor:Color(0xffEFEFF0),
                      //                       elevation: 0.0,
                      //                       borderColor: FlutterTheme.of(context)
                      //                           .alternate,
                      //                       borderWidth: 2.0,
                      //                       borderRadius: 8.0,
                      //                       margin: EdgeInsetsDirectional.fromSTEB(
                      //                           16.0, 4.0, 16.0, 4.0),
                      //                       hidesUnderline: true,
                      //                       isSearchable: false,
                      //                       isMultiSelect: false,
                      //                     );
                      //                   } else {
                      //                     return Text(
                      //                       BaseUrlGroup.locationCall
                      //                           .message(
                      //                             conditionalBuilderLocationResponse
                      //                                 .jsonBody,
                      //                           )
                      //                           .toString(),
                      //                       style: FlutterTheme.of(context)
                      //                           .bodyMedium,
                      //                     );
                      //                   }
                      //                 },
                      //               );
                      //             },
                      //           ),
                      //           FutureBuilder<ApiCallResponse>(
                      //             future: BaseUrlGroup.locationCall.call(
                      //               carId: widget.carid,
                      //             ),
                      //             builder: (context, snapshot) {
                      //               // Customize what your widget looks like when it's loading.
                      //               if (!snapshot.hasData) {
                      //                 return Center(
                      //                   child: SizedBox(
                      //                     width: 50.0,
                      //                     height: 50.0,
                      //                     child: CircularProgressIndicator(
                      //                       valueColor: AlwaysStoppedAnimation<Color>(
                      //                         FlutterTheme.of(context).primary,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 );
                      //               }
                      //               final conditionalBuilderLocationResponse =
                      //                   snapshot.data!;
                      //               return Builder(
                      //                 builder: (context) {
                      //                   if (BaseUrlGroup.locationCall.response(
                      //                     conditionalBuilderLocationResponse.jsonBody,
                      //                   )) {
                      //                     return FlutterDropDown<String>(
                      //                       controller: _model
                      //                               .dropOffLocationValueController ??=
                      //                           FormFieldController<String>(null),
                      //                       options: (BaseUrlGroup.locationCall
                      //                               .locationsList(
                      //                         conditionalBuilderLocationResponse
                      //                             .jsonBody,
                      //                       ) as List)
                      //                           .map<String>((s) => s.toString())
                      //                           .toList()!
                      //                           .map((e) => e.toString())
                      //                           .toList(),
                      //                       onChanged: (val) => setState(() =>
                      //                           _model.dropOffLocationValue = val),
                      //                       width: double.infinity,
                      //                       height: 50.0,
                      //                       textStyle: FlutterTheme.of(context)
                      //                           .bodyMedium,
                      //                       hintText:
                      //                           FFLocalizations.of(context).getText(
                      //                         '6bgu8ex7' /* Please select dropoff location */,
                      //                       ),
                      //                       icon: Icon(
                      //                         Icons.keyboard_arrow_down_rounded,
                      //                         color: FlutterTheme.of(context)
                      //                             .secondaryText,
                      //                         size: 24.0,
                      //                       ),
                      //                       // fillColor: FlutterTheme.of(context)
                      //                       //     .secondaryBackground,
                      //                       // elevation: 2.0,
                      //                       fillColor:Color(0xffEFEFF0),
                      //                       elevation: 0.0,
                      //                       borderColor: FlutterTheme.of(context)
                      //                           .alternate,
                      //                       borderWidth: 2.0,
                      //                       borderRadius: 8.0,
                      //                       margin: EdgeInsetsDirectional.fromSTEB(
                      //                           16.0, 4.0, 16.0, 4.0),
                      //                       hidesUnderline: true,
                      //                       isSearchable: false,
                      //                       isMultiSelect: false,
                      //                     );
                      //                   } else {
                      //                     return Text(
                      //                       BaseUrlGroup.locationCall
                      //                           .message(
                      //                             conditionalBuilderLocationResponse
                      //                                 .jsonBody,
                      //                           )
                      //                           .toString(),
                      //                       style: FlutterTheme.of(context)
                      //                           .bodyMedium,
                      //                     );
                      //                   }
                      //                 },
                      //               );
                      //             },
                      //           ),
                      //         ].divide(SizedBox(height: 8.0)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        FFLocalizations.of(context).getText('enter_details'),
                        style: FlutterTheme.of(context).bodyMedium.override(
                          fontFamily: 'Urbanist',
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _model.userNameController,
                        focusNode: _model.userNameFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            'nve5nwq1' /* Name of Rented */,
                          ),
                          labelStyle:
                          FlutterTheme.of(context).labelMedium,
                          hintText: FFLocalizations.of(context).getText(
                            'pli178ke' /* Please enter name */,
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
                        validator: _model.userNameControllerValidator
                            .asValidator(context),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _model.customerPhoneNumberController,
                        focusNode: _model.customerPhoneNumberFocusNode,
                        autofocus: true,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: FFLocalizations.of(context).getText(
                            '7kixyhdg' /* Phone Number */,
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          labelStyle:
                          FlutterTheme.of(context).labelMedium,
                          hintText: FFLocalizations.of(context).getText(
                            '9fwpvtje' /* Please enter contact Number */,
                          ),
                          hintStyle:
                          FlutterTheme.of(context).labelMedium,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              Color(0xff7C8BA0),
                              width: 1.0,
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
                        keyboardType: TextInputType.phone,
                        validator: _model
                            .customerPhoneNumberControllerValidator
                            .asValidator(context),
                        inputFormatters: [_model.customerPhoneNumberMask],
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      //   child: Card(
                      //     clipBehavior: Clip.antiAliasWithSaveLayer,
                      //     // color: FlutterTheme.of(context).secondaryBackground,
                      //     color: FlutterTheme.of(context).secondaryBackground,
                      //     // elevation: 4.0,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //     ),
                      //     child: Padding(
                      //       padding:
                      //           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 8.0),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         mainAxisSize: MainAxisSize.max,
                      //         children: [
                      //           Text(
                      //             "Enter Tenant Details",
                      //             style: FlutterTheme.of(context)
                      //                 .bodyMedium
                      //                 .override(
                      //               fontFamily: 'Urbanist',
                      //               fontSize: 18.0,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: EdgeInsetsDirectional.fromSTEB(
                      //                 8.0, 0.0, 8.0, 0.0),
                      //             child: TextFormField(
                      //               controller: _model.userNameController,
                      //               focusNode: _model.userNameFocusNode,
                      //               autofocus: true,
                      //               obscureText: false,
                      //               decoration: InputDecoration(
                      //                 labelText: FFLocalizations.of(context).getText(
                      //                   'nve5nwq1' /* Name of Rented */,
                      //                 ),
                      //                 labelStyle:
                      //                     FlutterTheme.of(context).labelMedium,
                      //                 hintText: FFLocalizations.of(context).getText(
                      //                   'pli178ke' /* Please enter name */,
                      //                 ),
                      //                 fillColor: Color(0xffEFEFF0),
                      //                 filled: true,
                      //                 hintStyle:
                      //                     FlutterTheme.of(context).labelMedium,
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color:
                      //                         FlutterTheme.of(context).alternate,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).primary,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 errorBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).error,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 focusedErrorBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).error,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //               ),
                      //               style: FlutterTheme.of(context).bodyMedium,
                      //               validator: _model.userNameControllerValidator
                      //                   .asValidator(context),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: EdgeInsetsDirectional.fromSTEB(
                      //                 8.0, 0.0, 8.0, 0.0),
                      //             child: TextFormField(
                      //               controller: _model.customerPhoneNumberController,
                      //               focusNode: _model.customerPhoneNumberFocusNode,
                      //               autofocus: true,
                      //               obscureText: false,
                      //               decoration: InputDecoration(
                      //                 labelText: FFLocalizations.of(context).getText(
                      //                   '7kixyhdg' /* Phone Number */,
                      //                 ),
                      //                 fillColor: Color(0xffEFEFF0),
                      //                 filled: true,
                      //                 labelStyle:
                      //                     FlutterTheme.of(context).labelMedium,
                      //                 hintText: FFLocalizations.of(context).getText(
                      //                   '9fwpvtje' /* Please enter contact Number */,
                      //                 ),
                      //                 hintStyle:
                      //                     FlutterTheme.of(context).labelMedium,
                      //                 enabledBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color:
                      //                         FlutterTheme.of(context).alternate,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 focusedBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).primary,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 errorBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).error,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //                 focusedErrorBorder: OutlineInputBorder(
                      //                   borderSide: BorderSide(
                      //                     color: FlutterTheme.of(context).error,
                      //                     width: 2.0,
                      //                   ),
                      //                   borderRadius: BorderRadius.circular(8.0),
                      //                 ),
                      //               ),
                      //               style: FlutterTheme.of(context).bodyMedium,
                      //               keyboardType: TextInputType.phone,
                      //               validator: _model
                      //                   .customerPhoneNumberControllerValidator
                      //                   .asValidator(context),
                      //               inputFormatters: [_model.customerPhoneNumberMask],
                      //             ),
                      //           ),
                      //         ].divide(SizedBox(height: 8.0)),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterTheme.of(context).secondaryBackground,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     Builder(
                            //       builder: (context) {
                            //         if (_model.daysAndHour ?? false) {
                            //           return FFButtonWidget(
                            //             icon: Icon(Icons.calendar_month),
                            //             onPressed: () async {
                            //               // startDaysTime
                            //               final _datePicked1Date =
                            //               await showDatePicker(
                            //                 context: context,
                            //                 initialDate: getCurrentTimestamp,
                            //                 firstDate: getCurrentTimestamp,
                            //                 lastDate: DateTime(2050),
                            //               );
                            //
                            //               if (_datePicked1Date != null) {
                            //                 safeSetState(() {
                            //                   _model.datePicked1 = DateTime(
                            //                     _datePicked1Date.year,
                            //                     _datePicked1Date.month,
                            //                     _datePicked1Date.day,
                            //                   );
                            //                 });
                            //               }
                            //               setState(() {
                            //                 _model.startDate = dateTimeFormat(
                            //                   'yMMMd',
                            //                   _model.datePicked1,
                            //                   locale:
                            //                   FFLocalizations.of(context)
                            //                       .languageCode,
                            //                 );
                            //               });
                            //             },
                            //             text:
                            //             FFLocalizations.of(context).getText(
                            //               '6b8vp6f5' /* Start date */,
                            //             ),
                            //             options: FFButtonOptions(
                            //               height: 40.0,
                            //               padding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   24.0, 0.0, 24.0, 0.0),
                            //               iconPadding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   0.0, 0.0, 0.0, 0.0),
                            //               color: FlutterTheme.of(context)
                            //                   .secondary,
                            //               textStyle:
                            //               FlutterTheme.of(context)
                            //                   .titleSmall
                            //                   .override(
                            //                 fontFamily: 'Urbanist',
                            //                 color: Colors.white,
                            //               ),
                            //               elevation: 3.0,
                            //               borderSide: BorderSide(
                            //                 color: Colors.transparent,
                            //                 width: 1.0,
                            //               ),
                            //               borderRadius:
                            //               BorderRadius.circular(8.0),
                            //             ),
                            //             showLoadingIndicator: false,
                            //           );
                            //         } else {
                            //           return FFButtonWidget(
                            //
                            //             onPressed: () async {
                            //               // startDaysTime
                            //
                            //               final _datePicked2Time =
                            //               await showTimePicker(
                            //                 context: context,
                            //                 initialTime: TimeOfDay.fromDateTime(
                            //                     getCurrentTimestamp),
                            //               );
                            //               if (_datePicked2Time != null) {
                            //                 safeSetState(() {
                            //                   _model.datePicked2 = DateTime(
                            //                     getCurrentTimestamp.year,
                            //                     getCurrentTimestamp.month,
                            //                     getCurrentTimestamp.day,
                            //                     _datePicked2Time.hour,
                            //                     _datePicked2Time.minute,
                            //                   );
                            //                 });
                            //               }
                            //               setState(() {
                            //                 _model.startDate = dateTimeFormat(
                            //                   'jm',
                            //                   _model.datePicked2,
                            //                   locale:
                            //                   FFLocalizations.of(context)
                            //                       .languageCode,
                            //                 );
                            //               });
                            //             },
                            //             text:
                            //             FFLocalizations.of(context).getText(
                            //               'p878gseq' /* Start time */,
                            //             ),
                            //             options: FFButtonOptions(
                            //               height: 40.0,
                            //               padding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   24.0, 0.0, 24.0, 0.0),
                            //               iconPadding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   0.0, 0.0, 0.0, 0.0),
                            //               color: FlutterTheme.of(context)
                            //                   .secondary,
                            //               textStyle:
                            //               FlutterTheme.of(context)
                            //                   .titleSmall
                            //                   .override(
                            //                 fontFamily: 'Urbanist',
                            //                 color: Colors.white,
                            //               ),
                            //               elevation: 3.0,
                            //               borderSide: BorderSide(
                            //                 color: Colors.transparent,
                            //                 width: 1.0,
                            //               ),
                            //               borderRadius:
                            //               BorderRadius.circular(8.0),
                            //             ),
                            //             icon: Icon(Icons.calendar_month),
                            //             showLoadingIndicator: false,
                            //           );
                            //         }
                            //       },
                            //     ),
                            //     // FaIcon(
                            //     //   FontAwesomeIcons.exchangeAlt,
                            //     //   color: FlutterFlowTheme.of(context)
                            //     //       .secondaryText,
                            //     //   size: 30.0,
                            //     // ),
                            //     Builder(
                            //       builder: (context) {
                            //         if (_model.daysAndHour ?? false) {
                            //           return FFButtonWidget(
                            //             icon: Icon(Icons.calendar_month),
                            //             onPressed: () async {
                            //               final _datePicked3Date =
                            //               await showDatePicker(
                            //                 context: context,
                            //                 initialDate: (_model.datePicked1 ??
                            //                     DateTime.now()),
                            //                 firstDate: (_model.datePicked1 ??
                            //                     DateTime.now()),
                            //                 lastDate: DateTime(2050),
                            //               );
                            //
                            //               if (_datePicked3Date != null) {
                            //                 safeSetState(() {
                            //                   _model.datePicked3 = DateTime(
                            //                     _datePicked3Date.year,
                            //                     _datePicked3Date.month,
                            //                     _datePicked3Date.day,
                            //                   );
                            //                 });
                            //               }
                            //               _model.endDate = dateTimeFormat(
                            //                 'yMMMd',
                            //                 _model.datePicked3,
                            //                 locale: FFLocalizations.of(context)
                            //                     .languageCode,
                            //               );
                            //               setState(() {
                            //                 _model.totalDays =
                            //                     functions.getDaysNumbers(
                            //                         _model.datePicked1,
                            //                         _model.datePicked3);
                            //               });
                            //             },
                            //
                            //             text:
                            //             FFLocalizations.of(context).getText(
                            //               '1ui0h2nb' /* End date */,
                            //             ),
                            //             options: FFButtonOptions(
                            //               height: 40.0,
                            //               padding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   24.0, 0.0, 24.0, 0.0),
                            //               iconPadding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   0.0, 0.0, 0.0, 0.0),
                            //               color: FlutterTheme.of(context)
                            //                   .secondary,
                            //               textStyle:
                            //               FlutterTheme.of(context)
                            //                   .titleSmall
                            //                   .override(
                            //                 fontFamily: 'Urbanist',
                            //                 color: Colors.white,
                            //               ),
                            //               elevation: 3.0,
                            //               borderSide: BorderSide(
                            //                 color: Colors.transparent,
                            //                 width: 1.0,
                            //               ),
                            //               borderRadius:
                            //               BorderRadius.circular(8.0),
                            //             ),
                            //             showLoadingIndicator: false,
                            //           );
                            //         } else {
                            //           return FFButtonWidget(
                            //             icon: Icon(Icons.calendar_month),
                            //             onPressed: () async {
                            //               final _datePicked4Time =
                            //               await showTimePicker(
                            //                 context: context,
                            //                 initialTime: TimeOfDay.fromDateTime(
                            //                     (_model.datePicked2 ??
                            //                         DateTime.now())),
                            //               );
                            //               if (_datePicked4Time != null) {
                            //                 safeSetState(() {
                            //                   _model.datePicked4 = DateTime(
                            //                     (_model.datePicked2 ??
                            //                         DateTime.now())
                            //                         .year,
                            //                     (_model.datePicked2 ??
                            //                         DateTime.now())
                            //                         .month,
                            //                     (_model.datePicked2 ??
                            //                         DateTime.now())
                            //                         .day,
                            //                     _datePicked4Time.hour,
                            //                     _datePicked4Time.minute,
                            //                   );
                            //                 });
                            //               }
                            //               _model.endDate = dateTimeFormat(
                            //                 'd/M h:mm a',
                            //                 _model.datePicked4,
                            //                 locale: FFLocalizations.of(context)
                            //                     .languageCode,
                            //               );
                            //               setState(() {
                            //                 _model.hoursAndMins =
                            //                     functions.getHoursAndMinutes(
                            //                         _model.datePicked2,
                            //                         _model.datePicked4);
                            //               });
                            //             },
                            //             text:
                            //             FFLocalizations.of(context).getText(
                            //               '062bdg35' /* End time */,
                            //             ),
                            //             options: FFButtonOptions(
                            //               height: 40.0,
                            //               padding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   24.0, 0.0, 24.0, 0.0),
                            //               iconPadding:
                            //               EdgeInsetsDirectional.fromSTEB(
                            //                   0.0, 0.0, 0.0, 0.0),
                            //               color: FlutterTheme.of(context)
                            //                   .secondary,
                            //               textStyle:
                            //               FlutterTheme.of(context)
                            //                   .titleSmall
                            //                   .override(
                            //                 fontFamily: 'Urbanist',
                            //                 color: Colors.white,
                            //               ),
                            //               elevation: 3.0,
                            //               borderSide: BorderSide(
                            //                 color: Colors.transparent,
                            //                 width: 1.0,
                            //               ),
                            //               borderRadius:
                            //               BorderRadius.circular(8.0),
                            //             ),
                            //             showLoadingIndicator: false,
                            //           );
                            //         }
                            //       },
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisSize: MainAxisSize.max,
                            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         _model.daysAndHour == true
                            //             ? dateTimeFormat(
                            //           'yMMMd',
                            //           _model.datePicked1,
                            //           locale: FFLocalizations.of(context)
                            //               .languageCode,
                            //         )
                            //             : dateTimeFormat(
                            //           'd/M h:mm a',
                            //           _model.datePicked2,
                            //           locale: FFLocalizations.of(context)
                            //               .languageCode,
                            //         ),
                            //         textAlign: TextAlign.center,
                            //         style:
                            //         FlutterTheme.of(context).bodyMedium,
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: Text(
                            //         _model.daysAndHour == true
                            //             ? dateTimeFormat(
                            //           'yMMMd',
                            //           _model.datePicked3,
                            //           locale: FFLocalizations.of(context)
                            //               .languageCode,
                            //         )
                            //             : dateTimeFormat(
                            //           'd/M h:mm a',
                            //           _model.datePicked4,
                            //           locale: FFLocalizations.of(context)
                            //               .languageCode,
                            //         ),
                            //         textAlign: TextAlign.center,
                            //         style:
                            //         FlutterTheme.of(context).bodyMedium,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return FFButtonWidget(
                                        icon: Icon(Icons.calendar_month),
                                        onPressed: () async {
                                          final _datePicked1Date = await showDatePicker(
                                            context: context,
                                            initialDate: _model.datePicked1 ?? DateTime.now(),
                                            firstDate: _model.datePicked1 ?? DateTime.now(),
                                            lastDate: DateTime(2050),
                                          );


                                          if (_datePicked1Date != null) {
                                            safeSetState(() {
                                              _model.datePicked1 = DateTime(
                                                _datePicked1Date.year,
                                                _datePicked1Date.month,
                                                _datePicked1Date.day,
                                              );
                                              _model.startDate = dateTimeFormat(
                                                'yMMMd',
                                                _model.datePicked1!,
                                                locale: FFLocalizations.of(context).languageCode,
                                              );
                                            });
                                          }
                                        },
                                        text: FFLocalizations.of(context).getText('6b8vp6f5' /* Start date */),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterTheme.of(context).secondary,
                                          textStyle: FlutterTheme.of(context).titleSmall.override(
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
                                        showLoadingIndicator: false,
                                      );
                                    } else {
                                      return Container(
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            final _datePicked2Time = await showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.fromDateTime(_model.datePicked2 ?? DateTime.now()),
                                              builder: (BuildContext context, Widget? child) {
                                                return MediaQuery(
                                                  data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                  child: child!,
                                                );
                                              },
                                            );

                                            if (_datePicked2Time != null) {
                                              safeSetState(() {
                                                _model.datePicked2 = DateTime(
                                                  DateTime.now().year,
                                                  DateTime.now().month,
                                                  DateTime.now().day,
                                                  _datePicked2Time.hour,
                                                  _datePicked2Time.minute,
                                                );

                                                final DateFormat formatter = DateFormat('MMM d, yyyy HH:mm');
                                                final String formattedDate = formatter.format(_model.datePicked2!);

                                                _model.startDate = formattedDate;

                                                print("==start date===${_model.startDate}");
                                              });
                                            }
                                          },
                                          text: FFLocalizations.of(context).getText('p878gseq' /* Start time */),
                                          options: FFButtonOptions(
                                            height: 40.0,
                                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                            color: FlutterTheme.of(context).secondary,
                                            textStyle: FlutterTheme.of(context).titleSmall.override(
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
                                          icon: Icon(Icons.calendar_month),
                                          showLoadingIndicator: false,
                                        ),
                                      );

                                    }
                                  },
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return FFButtonWidget(
                                        icon: Icon(Icons.calendar_month),
                                        onPressed: () async {
                                          final _datePicked3Date = await showDatePicker(
                                            context: context,
                                            initialDate: _model.datePicked1 ?? DateTime.now(),
                                            firstDate: _model.datePicked1 ?? DateTime.now(),
                                            lastDate: DateTime(2050),
                                          );

                                          if (_datePicked3Date != null) {
                                            safeSetState(() {
                                              _model.datePicked3 = DateTime(
                                                _datePicked3Date.year,
                                                _datePicked3Date.month,
                                                _datePicked3Date.day,
                                              );
                                              if (_model.datePicked3!.isBefore(_model.datePicked1!)) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text('End date must be after start date.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                _model.endDate = dateTimeFormat(
                                                  'yMMMd',
                                                  _model.datePicked3!,
                                                  locale: FFLocalizations.of(context).languageCode,
                                                );
                                                _model.totalDays = functions.getDaysNumbers(_model.datePicked1!, _model.datePicked3!);
                                              }
                                            });
                                          }
                                        },
                                        text: FFLocalizations.of(context).getText('1ui0h2nb' /* End date */),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterTheme.of(context).secondary,
                                          textStyle: FlutterTheme.of(context).titleSmall.override(
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
                                        showLoadingIndicator: false,
                                      );
                                    } else {
                                      return FFButtonWidget(
                                        icon: Icon(Icons.calendar_month),
                                        onPressed: () async {
                                          final _datePicked4Time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.fromDateTime(_model.datePicked2 ?? DateTime.now()),
                                            builder: (BuildContext context, Widget? child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (_datePicked4Time != null) {
                                            safeSetState(() {
                                              _model.datePicked4 = DateTime(
                                                (_model.datePicked2 ?? DateTime.now()).year,
                                                (_model.datePicked2 ?? DateTime.now()).month,
                                                (_model.datePicked2 ?? DateTime.now()).day,
                                                _datePicked4Time.hour,
                                                _datePicked4Time.minute,
                                              );

                                              if (_model.datePicked4!.isBefore(_model.datePicked2!)) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text('Error'),
                                                      content: Text('End time must be after start time.'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text('OK'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              } else {
                                                // Use 24-hour format for displaying the time
                                                _model.endDate = DateFormat('MMM d, yyyy HH:mm').format(_model.datePicked4!);
                                                _model.hoursAndMins = functions.getHoursAndMinutes(_model.datePicked2!, _model.datePicked4!);
                                              }
                                            });
                                          }
                                        },
                                        text: FFLocalizations.of(context).getText('062bdg35' /* End time */),
                                        options: FFButtonOptions(
                                          height: 40.0,
                                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                          color: FlutterTheme.of(context).secondary,
                                          textStyle: FlutterTheme.of(context).titleSmall.override(
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
                                        showLoadingIndicator: false,
                                      );

                                    }
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Text(
                                    _model.daysAndHour == true
                                        ? dateTimeFormat(
                                      'yMMMd',
                                      _model.datePicked1 ?? DateTime.now(),
                                      locale: FFLocalizations.of(context).languageCode,
                                    )
                                        : dateTimeFormat(
                                      'd/M h:mm a',
                                      _model.datePicked2 ?? DateTime.now(),
                                      locale: FFLocalizations.of(context).languageCode,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterTheme.of(context).bodyMedium,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    _model.daysAndHour == true
                                        ? dateTimeFormat(
                                      'yMMMd',
                                      _model.datePicked3 ?? DateTime.now(),
                                      locale: FFLocalizations.of(context).languageCode,
                                    )
                                        : dateTimeFormat(
                                      'd/M h:mm a',
                                      _model.datePicked4 ?? DateTime.now(),
                                      locale: FFLocalizations.of(context).languageCode,
                                    ),
                                    textAlign: TextAlign.center,
                                    style: FlutterTheme.of(context).bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              // InkWell(
                              //   onTap: () {
                              //     _showPicker(context);
                              //   },
                              //   child:_image != null? Stack(
                              //     children: [
                              //       Container(
                              //           width: 85.0,
                              //           height: 85.0,
                              //           clipBehavior: Clip.antiAlias,
                              //           decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //           ),
                              //           child: Image.file(
                              //             _image!,
                              //             fit: BoxFit.cover,
                              //           )
                              //       ),
                              //       Positioned(
                              //           right: 0,
                              //           bottom:5 ,
                              //           child: Icon(Icons.camera_alt))
                              //     ],
                              //   ): Stack(
                              //     children: [
                              //       Container(
                              //         width: 85.0,
                              //         height: 85.0,
                              //         clipBehavior: Clip.antiAlias,
                              //         decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             // border: Border.all(color: FlutterTheme.of(context).btnNaviBlue,width: 1)
                              //         ),
                              //
                              //         child: ClipRRect(
                              //           borderRadius: BorderRadius.circular(40),
                              //           child: Center(
                              //             child: Image.asset(
                              //               'assets/images/playstore_logo.png',
                              //               fit: BoxFit.cover,
                              //             ),
                              //           ),
                              //         ),
                              //       ),
                              //       Positioned(
                              //           right: 0,
                              //           bottom:5 ,
                              //           child: Icon(Icons.camera_alt))
                              //     ],
                              //   ),
                              // ),

                              Builder(

                                builder: (context) {
                                  if (_model.intforntimage ?? false) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          imageQuality: 100,
                                          allowPhoto: true,
                                          includeDimensions: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading1 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            // showUploadMessage(
                                            //   context,
                                            //   'Uploading file...',
                                            //   showLoading: true,
                                            // );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.filePath,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading1 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile1 =
                                                  selectedUploadedFiles.first;
                                            });
                                            // showUploadMessage(
                                            //     context, 'Success!');
                                            print("Uploaded Image Path 1: ${_model.uploadedLocalFile1}");
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload data');
                                            return;
                                          }
                                        }

                                        setState(() {
                                          _model.forntImage =
                                              _model.uploadedLocalFile1;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child:

                                        Image.memory(
                                          _model.forntImage?.bytes ??
                                              Uint8List.fromList([]),
                                          width: 170.0,
                                          height: 130.0,
                                          fit: BoxFit.contain,
                                           cacheWidth: 170,
                                           cacheHeight: 130,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          imageQuality: 100,
                                          allowPhoto: true,
                                          includeDimensions: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading2 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            // showUploadMessage(
                                            //   context,
                                            //   'Uploading file...',
                                            //   showLoading: true,
                                            // );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.filePath,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading2 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile2 =
                                                  selectedUploadedFiles.first;
                                            });
                                            // showUploadMessage(
                                            //     context, 'Success!');
                                            print("Uploaded Image Path 2: ${_model.uploadedLocalFile2}");
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload data');
                                            return;
                                          }
                                        }

                                        setState(() {
                                          _model.forntImage =
                                              _model.uploadedLocalFile2;
                                        });
                                        setState(() {
                                          _model.intforntimage = true;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/licence_icon.svg',
                                          // width: 170.0,
                                          //  height: 130.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Builder(
                                builder: (context) {
                                  if (_model.intbackimage ?? false) {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          imageQuality: 100,
                                          allowPhoto: true,
                                          includeDimensions: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading3 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            // showUploadMessage(
                                            //   context,
                                            //   'Uploading file...',
                                            //   showLoading: true,
                                            // );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.filePath,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading3 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile3 =
                                                  selectedUploadedFiles.first;
                                            });
                                            // showUploadMessage(
                                            //     context, 'Success!yeahhhh');
                                            print("Uploaded Image Path: ${_model.uploadedLocalFile3.name}");
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload data');
                                            return;
                                          }
                                        }

                                        setState(() {
                                          _model.backImage =
                                              _model.uploadedLocalFile3;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.memory(
                                          _model.backImage?.bytes ??
                                              Uint8List.fromList([]),
                                          width: 170.0,
                                          height: 130.0,
                                          fit: BoxFit.contain,
                                          cacheWidth: 170,
                                          cacheHeight: 130,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                                    width: 170.0,
                                                    height: 130.0,
                                                    fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        final selectedMedia =
                                            await selectMediaWithSourceBottomSheet(
                                          context: context,
                                          imageQuality: 100,
                                          allowPhoto: true,
                                          includeDimensions: true,
                                        );
                                        if (selectedMedia != null &&
                                            selectedMedia.every((m) =>
                                                validateFileFormat(
                                                    m.storagePath, context))) {
                                          setState(() =>
                                              _model.isDataUploading4 = true);
                                          var selectedUploadedFiles =
                                              <FFUploadedFile>[];

                                          try {
                                            // showUploadMessage(
                                            //   context,
                                            //   'Uploading file...',
                                            //   showLoading: true,
                                            // );
                                            selectedUploadedFiles =
                                                selectedMedia
                                                    .map((m) => FFUploadedFile(
                                                          name: m.filePath,
                                                          bytes: m.bytes,
                                                          height: m.dimensions
                                                              ?.height,
                                                          width: m.dimensions
                                                              ?.width,
                                                          blurHash: m.blurHash,
                                                        ))
                                                    .toList();
                                          } finally {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                            _model.isDataUploading4 = false;
                                          }
                                          if (selectedUploadedFiles.length ==
                                              selectedMedia.length) {
                                            setState(() {
                                              _model.uploadedLocalFile4 =
                                                  selectedUploadedFiles.first;
                                            });
                                            // showUploadMessage(
                                            //     context, 'Success!');
                                            print("Uploaded Image Path 4: ${_model.uploadedLocalFile4}");
                                          } else {
                                            setState(() {});
                                            showUploadMessage(context,
                                                'Failed to upload data');
                                            return;
                                          }
                                        }

                                        setState(() {
                                          _model.backImage =
                                              _model.uploadedLocalFile4;
                                        });
                                        setState(() {
                                          _model.intbackimage = true;
                                        });
                                      },
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: SvgPicture.asset(
                                          'assets/images/licence_icon.svg',
                                          // width: 170.0,
                                          //  height: 130.0,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _model.radioButtonValue != 'Driver'?
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    FFLocalizations.of(context).getText('exclusive_offers'),
                                    style: FlutterTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterTheme.of(context).primaryText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {
                                    Helper.moveToScreenwithPush(context, ViewAllPromode());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/sale_fill.svg',
                                            // width: 170.0,
                                            //  height: 130.0,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Exclusive Offers",
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Urbanist',
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context).getText('check_available'),
                                                style: FlutterTheme.of(context).bodyMedium.override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(context).primary,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.arrow_forward_ios,size: 18,color: Color(0xff7C8BA0),),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ):SizedBox(),

                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: FlutterTheme.of(context).secondaryBackground,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            Text(
                              FFLocalizations.of(context).getText('rental_fees'),
                              style: FlutterTheme.of(context).bodyMedium.override(
                                fontFamily: 'Urbanist',
                                fontSize: 17.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            _model.radioButtonValue != 'Driver'?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Opacity(
                                  opacity: 0.5,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/1.5,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xff7C8BA0),width: 1
                                      ),
                                      // color: FlutterTheme.of(context)
                                      //     .primary,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        child: TextFormField(
                                            onChanged:(value) {
                                              print("==========hey=========");
                                              setState(() {
                                                if(value==""){

                                                  _promocodeApplyModel=null;
                                                }

                                              });


                                            },
                                            onTap: () {
                                              // Helper.checkInternet(promocodeApi());
                                            },
                                            // keyboardType: TextInputType.emailAddress,
                                            // controller: _model.textController3,
                                            controller: promocodecontroller,
                                            autofocus: true,
                                            autofillHints: [
                                              AutofillHints.givenName
                                            ],
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              // suffixText: 'Applied',
                                              hintText:
                                              FFLocalizations.of(context).getText('enter_coupon'),
                                              hintStyle:
                                              FlutterTheme.of(context)
                                                  .displaySmall
                                                  .override(
                                                fontFamily:
                                                FlutterTheme.of(
                                                    context)
                                                    .displaySmallFamily,
                                                fontSize: 16.0,fontWeight: FontWeight.w400,
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterTheme.of(
                                                        context)
                                                        .displaySmallFamily), color: Color(0xff6F7C8E)
                                              ),
                                              labelStyle:
                                              FlutterTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                useGoogleFonts: GoogleFonts
                                                    .asMap()
                                                    .containsKey(
                                                    FlutterTheme.of(
                                                        context)
                                                        .labelMediumFamily), color: Color(0xff6F7C8E)
                                              ),
                                              enabledBorder: InputBorder.none,

                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                              InputBorder.none,
                                              contentPadding: EdgeInsets.all(8.0),
                                            ),
                                            style: FlutterTheme.of(context)
                                                .displaySmall
                                                .override(
                                              fontFamily:
                                              FlutterTheme.of(context)
                                                  .displaySmallFamily,
                                              fontSize: 18.0,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterTheme.of(
                                                      context)
                                                      .displaySmallFamily),
                                              color: Color(0xff6F7C8E),fontWeight: FontWeight.w400,
                                            ),

                                            cursorColor:
                                            FlutterTheme.of(context)
                                                .primary
                                        ),
                                      ),
                                    ),
                                  ),
                                ),



                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        Helper.checkInternet(promocodeApi());
                                        // promocodecontroller.text=""
                                      });

                                    },
                                    child:_promocodeApplyModel==null?Text(
                                      FFLocalizations.of(context).getText(
                                        'apply_button' /* Apply */,
                                      ),
                                      style:FlutterTheme.of(context).titleSmall.override(
                                        fontFamily: FlutterTheme.of(context).titleSmallFamily,
                                        color: FlutterTheme.of(context).primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FlutterTheme.of(context).titleSmallFamily),
                                      ),
                                    ):Text(
                                      FFLocalizations.of(context).getText(
                                        'applied_status' /* Applied */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: FlutterTheme.of(context).bodyMediumFamily,
                                            color: FlutterTheme.of(context).primary,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(FlutterTheme.of(context).bodyMediumFamily),
                                          ),
                                    )),
                              ],
                            ):SizedBox(),

                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (_model.radioButtonValue == 'Driver') {
                                      return Container(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        // height: 60,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(0),
                                                // color: Color(0xffEFEFF0)
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
                                                 FFLocalizations.of(context).getText('total_days'),
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
                                                  _model.daysAndHour!
                                                      ? formatNumber(
                                                          _model.totalDays,
                                                          formatType:
                                                              FormatType.decimal,
                                                          decimalType: DecimalType
                                                              .periodDecimal,
                                                        )
                                                      : formatNumber(
                                                          _model.hoursAndMins,
                                                          formatType:
                                                              FormatType.decimal,
                                                          decimalType: DecimalType
                                                              .periodDecimal,
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
                                                  getJsonField(
                                                    widget.carDetailBooking,
                                                    r'''$.price_type''',
                                                  ).toString(),
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
                                                    'qj2u90vy' /* driver */,
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
                                                      _model.radioButtonValue ==
                                                              'Driver'
                                                          ? functions
                                                              .newstringToDouble(
                                                                  BaseUrlGroup
                                                                      .driverPriceCall
                                                                      .price(
                                                                        (_model.apiResultaPrice
                                                                                ?.jsonBody ??
                                                                            ''),
                                                                      )
                                                                      .toString())
                                                          : 0.0,
                                                      _model.daysAndHour!
                                                          ? _model.totalDays
                                                              ?.toDouble()
                                                          : _model.hoursAndMins),
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
                                      );
                                    }
                                    else {
                                      return Text(
                                        FFLocalizations.of(context).getText(
                                          'le6zzjtl' /*   */,
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
                                SizedBox(
                                  height: 10,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return Container(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 0.0),
                                        // height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(0),
                                            // color: Color(0xffEFEFF0)
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
                                                 FFLocalizations.of(context).getText('total_days'),
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
                                                //   valueOrDefault<String>(
                                                //     formatNumber(
                                                //       _model.totalDays,
                                                //       formatType:
                                                //           FormatType.decimal,
                                                //       decimalType:
                                                //           DecimalType.periodDecimal,
                                                //     ),
                                                //     '0.0',
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
                                                    " Days",
                                                  // FFLocalizations.of(context)
                                                  //     .getText(
                                                  //   'p5ik7die' /* days */,
                                                  // ),
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
                                            Row(
                                              children: [
                                                Text(
                                                  valueOrDefault<String>(
                                                    formatNumber(
                                                      _model.totalDays,
                                                      formatType:
                                                          FormatType.decimal,
                                                      decimalType:
                                                          DecimalType.periodDecimal,
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
                                                Text(
                                                 "Days",
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
                                            //             widget.carDetailBooking,
                                            //             r'''$.car_cost''',
                                            //           ).toString()),
                                            //           _model.totalDays?.toDouble()),
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
                                      );
                                    } else {
                                      return Container(
                                        // padding: EdgeInsetsDirectional.fromSTEB(
                                        //     8.0, 0.0, 8.0, 0.0),
                                        // height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(0),
                                            // color: Color(0xffEFEFF0)
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
                                                  FFLocalizations.of(context).getText('price_type_hour'),
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
                                                // Text(
                                                //   formatNumber(
                                                //     functions.multiplayData(
                                                //         _model.hoursAndMins,
                                                //         functions.newstringToDouble(
                                                //             getJsonField(
                                                //           widget.carDetailBooking,
                                                //           r'''$.car_cost''',
                                                //         ).toString())),
                                                //     formatType: FormatType.decimal,
                                                //     decimalType:
                                                //         DecimalType.periodDecimal,
                                                //     currency: '\$',
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
                                                Text(
                                                  formatNumber(
                                                    _model.hoursAndMins,
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
                                                  " Hour",
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
                                          ].divide(SizedBox(width: 2.0)),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Divider(
                                //   thickness: 1.0,
                                //   color: FlutterTheme.of(context).accent4,
                                // ),
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'nx5oz5zu' /* Total fees */,
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
                                          Text(
                                            formatNumber(
                                              functions.addTwoNumber(
                                                  functions.multiplayData(
                                                      functions.newstringToDouble(
                                                          getJsonField(
                                                        widget.carDetailBooking,
                                                        r'''$.car_cost''',
                                                      ).toString()),
                                                      _model.totalDays
                                                          ?.toDouble()),
                                                  functions.multiplayData(
                                                      _model.radioButtonValue ==
                                                              'Driver'
                                                          ? functions
                                                              .newstringToDouble(
                                                                  BaseUrlGroup
                                                                      .driverPriceCall
                                                                      .price(
                                                                        (_model.apiResultaPrice
                                                                                ?.jsonBody ??
                                                                            ''),
                                                                      )
                                                                      .toString())
                                                          : 0.0,
                                                      _model.totalDays
                                                          ?.toDouble())),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.periodDecimal,
                                              currency: '\$',
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
                                      );
                                    } else {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'kvtmofp3' /* Total fees */,
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
                                          Text(
                                            formatNumber(
                                              functions.addTwoNumber(
                                                  functions.multiplayData(
                                                      functions.newstringToDouble(
                                                          getJsonField(
                                                        widget.carDetailBooking,
                                                        r'''$.car_cost''',
                                                      ).toString()),
                                                      _model.hoursAndMins),
                                                  functions.multiplayData(
                                                      _model.radioButtonValue ==
                                                              'Driver'
                                                          ? functions
                                                              .newstringToDouble(
                                                                  BaseUrlGroup
                                                                      .driverPriceCall
                                                                      .price(
                                                                        (_model.apiResultaPrice
                                                                                ?.jsonBody ??
                                                                            ''),
                                                                      )
                                                                      .toString())
                                                          : 0.0,
                                                      _model.hoursAndMins)),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                                  DecimalType.periodDecimal,
                                              currency: '\$',
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
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _model.radioButtonValue != 'Driver'?
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText('coupon_amount'),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: Color(0xff25212E),
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          _promocodeApplyModel==null?Text(
                                            "0",
                                            textAlign: TextAlign.start,
                                            style: FlutterTheme.of(context)
                                        .bodyMedium
                                        .override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xff25212E),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                            ),
                                          ):
                                          Text(
                                            "\$${_promocodeApplyModel!.discount!.toString()}",
                                            textAlign: TextAlign.start,
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
                                      );
                                    } else {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                           "Coupon Amount",
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                                ),
                                          ),
                                          _promocodeApplyModel==null?Text(
                                            "0",
                                            textAlign: TextAlign.start,
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                fontFamily: 'Urbanist',
                                    color: Color(0xff25212E),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                          )):
                                          Text(
                                            "\$${_promocodeApplyModel!.discount!.toString()}",
                                            textAlign: TextAlign.start,
                                            style: FlutterTheme.of(context)
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
                                          //     functions.addTwoNumber(
                                          //         functions.multiplayData(
                                          //             functions.newstringToDouble(
                                          //                 getJsonField(
                                          //               widget.carDetailBooking,
                                          //               r'''$.car_cost''',
                                          //             ).toString()),
                                          //             _model.hoursAndMins),
                                          //         functions.multiplayData(
                                          //             _model.radioButtonValue ==
                                          //                     'Driver'
                                          //                 ? functions
                                          //                     .newstringToDouble(
                                          //                         BaseUrlGroup
                                          //                             .driverPriceCall
                                          //                             .price(
                                          //                               (_model.apiResultaPrice
                                          //                                       ?.jsonBody ??
                                          //                                   ''),
                                          //                             )
                                          //                             .toString())
                                          //                 : 0.0,
                                          //             _model.hoursAndMins)),
                                          //     formatType: FormatType.decimal,
                                          //     decimalType:
                                          //         DecimalType.periodDecimal,
                                          //     currency: '\$',
                                          //   ),
                                          //   style: FlutterTheme.of(context)
                                          //       .bodyMedium
                                          //       .override(
                                          //         fontFamily: 'Urbanist',
                                          //         color:
                                          //             FlutterTheme.of(context)
                                          //                 .secondary,
                                          //         fontSize: 18.0,
                                          //         fontWeight: FontWeight.bold,
                                          //       ),
                                          // ),
                                        ].divide(SizedBox(width: 2.0)),
                                      );
                                    }
                                  },
                                ):SizedBox(),
                                SizedBox(
                                  height: 10,
                                ),
                                _model.radioButtonValue != 'Driver'?
                                Builder(
                                  builder: (context) {
                                    if (_model.daysAndHour ?? false) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                         FFLocalizations.of(context).getText('total_amount'),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff553FA5),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),

                                          _promocodeApplyModel==null? Text(
                                            formatNumber(
                                              functions.addTwoNumber(
                                                  functions.multiplayData(
                                                      functions.newstringToDouble(
                                                          getJsonField(
                                                            widget.carDetailBooking,
                                                            r'''$.car_cost''',
                                                          ).toString()),
                                                      _model.totalDays
                                                          ?.toDouble()),
                                                  functions.multiplayData(
                                                      _model.radioButtonValue ==
                                                          'Driver'
                                                          ? functions
                                                          .newstringToDouble(
                                                          BaseUrlGroup
                                                              .driverPriceCall
                                                              .price(
                                                            (_model.apiResultaPrice
                                                                ?.jsonBody ??
                                                                ''),
                                                          )
                                                              .toString())
                                                          : 0.0,
                                                      _model.totalDays
                                                          ?.toDouble())),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                              DecimalType.periodDecimal,
                                              currency: '\$',
                                            ),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff553FA5),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ):
                                          Text(
                                            _promocodeApplyModel!.fare!.toString(),
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
                                      );
                                    } else {
                                      return Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'kvtmofp3' /* Total fees */,
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
                                          _promocodeApplyModel==null?
                                          Text(
                                            formatNumber(
                                              functions.addTwoNumber(
                                                  functions.multiplayData(
                                                      functions.newstringToDouble(
                                                          getJsonField(
                                                            widget.carDetailBooking,
                                                            r'''$.car_cost''',
                                                          ).toString()),
                                                      _model.hoursAndMins),
                                                  functions.multiplayData(
                                                      _model.radioButtonValue ==
                                                          'Driver'
                                                          ? functions
                                                          .newstringToDouble(
                                                          BaseUrlGroup
                                                              .driverPriceCall
                                                              .price(
                                                            (_model.apiResultaPrice
                                                                ?.jsonBody ??
                                                                ''),
                                                          )
                                                              .toString())
                                                          : 0.0,
                                                      _model.hoursAndMins)),
                                              formatType: FormatType.decimal,
                                              decimalType:
                                              DecimalType.periodDecimal,
                                              currency: '\$',
                                            ),
                                            style: FlutterTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Urbanist',
                                              color: Color(0xff25212E),
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ):  Text(
                                    _promocodeApplyModel!.fare!.toString(),
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
                                      );
                                    }
                                  },
                                ):SizedBox(),
                              ],
                            ),
                          ].divide(SizedBox(height: 8.0)),
                        ),
                      ),

                      // Card(
                      //   clipBehavior: Clip.antiAliasWithSaveLayer,
                      //   color: FlutterTheme.of(context).secondaryBackground,
                      //   elevation: 4.0,
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(8.0),
                      //   ),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.max,
                      //     children: [
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisSize: MainAxisSize.max,
                      //           children: [
                      //             Theme(
                      //               data: ThemeData(
                      //                 checkboxTheme: CheckboxThemeData(
                      //                   visualDensity: VisualDensity.compact,
                      //                   materialTapTargetSize:
                      //                       MaterialTapTargetSize.shrinkWrap,
                      //                   shape: RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4.0),
                      //                   ),
                      //                 ),
                      //                 unselectedWidgetColor:
                      //                     FlutterTheme.of(context)
                      //                         .plumpPurple,
                      //               ),
                      //               child: Checkbox(
                      //                 value: _model.checkboxValue ??= true,
                      //                 onChanged: (newValue) async {
                      //                   setState(() =>
                      //                       _model.checkboxValue = newValue!);
                      //                 },
                      //                 activeColor: FlutterTheme.of(context)
                      //                     .plumpPurple,
                      //                 checkColor: FlutterTheme.of(context)
                      //                     .primaryBtnText,
                      //               ),
                      //             ),
                      //             Expanded(
                      //               child: Text(
                      //                 FFLocalizations.of(context).getText(
                      //                   'p8jtyhqy' /* Please accpet terms amd condit... */,
                      //                 ),
                      //                 style: FlutterTheme.of(context)
                      //                     .bodyMedium
                      //                     .override(
                      //                       fontFamily: 'Urbanist',
                      //                       fontSize: 18.0,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //               ),
                      //             ),
                      //           ].divide(SizedBox(width: 8.0)),
                      //         ),
                      //       ),
                      //     ].divide(SizedBox(width: 16.0)),
                      //   ),
                      // ),


                      // FFButtonWidget(
                      //   onPressed: () async {
                      //     // Validate form fields before proceeding
                      //     // if(images.length.toString()=="0"){
                      //     //   ScaffoldMessenger.of(context).showSnackBar(
                      //     //     SnackBar(
                      //     //       content: Text('Upload atleast one image'),
                      //     //     ),
                      //     //   );
                      //     // }
                      //
                      //      if(_model.userNameController.text==""||_model.userNameController.text==null){
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text('Enter Name'),
                      //         ),
                      //       );
                      //     }
                      //
                      //     else if(_model.customerPhoneNumberController.text==""||_model.customerPhoneNumberController.text==null){
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text('Enter Phone Number'),
                      //         ),
                      //       );
                      //     }
                      //     else if( _model.startDate==null|| _model.startDate==""){
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text('Enter Start date'),
                      //         ),
                      //       );
                      //     }
                      //     else if( _model.endDate==null||_model.endDate==""){
                      //       ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(
                      //           content: Text('Enter End date'),
                      //         ),
                      //       );
                      //     }
                      //      else if(_model.forntImage==""||_model.forntImage==null){
                      //        ScaffoldMessenger.of(context).showSnackBar(
                      //          SnackBar(
                      //            content: Text('Upload front image of License'),
                      //          ),
                      //        );
                      //      }
                      //      else if( _model.backImage==""||_model.backImage==null){
                      //        ScaffoldMessenger.of(context).showSnackBar(
                      //          SnackBar(
                      //            content: Text('Upload front image of License'),
                      //          ),
                      //        );
                      //      }
                      //
                      //    // else{
                      //    //     setState(() {
                      //    //       setProgress(true);
                      //    //     });
                      //    //  // Proceed with navigation if form validation passes
                      //    //  context.pushNamed(
                      //    //    'confirmation_page',
                      //    //    queryParameters: {
                      //    //      'bookingDetails': serializeParam(
                      //    //        widget.carDetailBooking,
                      //    //        ParamType.JSON,
                      //    //      ),
                      //    //      'driverType': serializeParam(
                      //    //        _model.radioButtonValue,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'daysAndHourlyType': serializeParam(
                      //    //        _model.daysAndHour,
                      //    //        ParamType.bool,
                      //    //      ),
                      //    //      'pickupLocation': serializeParam(
                      //    //        _model.pickupLocationValue,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'dropoffLocation': serializeParam(
                      //    //        _model.dropOffLocationValue,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'userName': serializeParam(
                      //    //        _model.userNameController.text,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'contactnumber': serializeParam(
                      //    //        _model.customerPhoneNumberController.text,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'pickupDate': serializeParam(
                      //    //        _model.startDate,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'dropoffDate': serializeParam(
                      //    //        _model.endDate,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'licenceForntImage': serializeParam(
                      //    //        _model.forntImage,
                      //    //        ParamType.FFUploadedFile,
                      //    //      ),
                      //    //      'licenceBackImage': serializeParam(
                      //    //        _model.backImage,
                      //    //        ParamType.FFUploadedFile,
                      //    //      ),
                      //    //      'supplierid': serializeParam(
                      //    //        widget.supplierid,
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'totalAmount': serializeParam(
                      //    //        _model.daysAndHour == true
                      //    //            ? formatNumber(
                      //    //          functions.addTwoNumber(
                      //    //              functions.multiplayData(
                      //    //                  functions.newstringToDouble(getJsonField(
                      //    //                    widget.carDetailBooking,
                      //    //                    r'''$.car_cost''',
                      //    //                  ).toString()),
                      //    //                  _model.totalDays?.toDouble()),
                      //    //              functions.multiplayData(
                      //    //                  _model.radioButtonValue == 'Driver'
                      //    //                      ? functions.newstringToDouble(
                      //    //                      BaseUrlGroup.driverPriceCall
                      //    //                          .price(
                      //    //                        (_model.apiResultaPrice?.jsonBody ?? ''),
                      //    //                      )
                      //    //                          .toString())
                      //    //                      : 0.0,
                      //    //                  _model.totalDays?.toDouble())),
                      //    //          formatType: FormatType.decimal,
                      //    //          decimalType: DecimalType.periodDecimal,
                      //    //        )
                      //    //            : formatNumber(
                      //    //          functions.addTwoNumber(
                      //    //              functions.multiplayData(
                      //    //                  functions.newstringToDouble(getJsonField(
                      //    //                    widget.carDetailBooking,
                      //    //                    r'''$.car_cost''',
                      //    //                  ).toString()),
                      //    //                  _model.hoursAndMins),
                      //    //              functions.multiplayData(
                      //    //                  _model.radioButtonValue == 'Driver'
                      //    //                      ? functions.newstringToDouble(
                      //    //                      BaseUrlGroup.driverPriceCall
                      //    //                          .price(
                      //    //                        (_model.apiResultaPrice?.jsonBody ?? ''),
                      //    //                      )
                      //    //                          .toString())
                      //    //                      : 0.0,
                      //    //                  _model.hoursAndMins)),
                      //    //          formatType: FormatType.decimal,
                      //    //          decimalType: DecimalType.periodDecimal,
                      //    //        ),
                      //    //        ParamType.String,
                      //    //      ),
                      //    //      'hoursAndMin': serializeParam(
                      //    //        _model.hoursAndMins,
                      //    //        ParamType.double,
                      //    //      ),
                      //    //      'totalDays': serializeParam(
                      //    //        _model.totalDays,
                      //    //        ParamType.int,
                      //    //      ),
                      //    //    }.withoutNulls,
                      //    //
                      //    //  );
                      //    //
                      //    //     setState(() {
                      //    //       setProgress(true);
                      //    //       // _isConfirmBookingLoading = false;
                      //    //     });
                      //    //     // setProgress(false);
                      //    // }
                      //     else {
                      //     setState(() {
                      //     setProgress(true);
                      //     });
                      //
                      //     // Proceed with navigation if form validation passes
                      //     context.pushNamed(
                      //     'confirmation_page',
                      //     queryParameters: {
                      //     'bookingDetails': serializeParam(
                      //     widget.carDetailBooking,
                      //     ParamType.JSON,
                      //     ),
                      //     'driverType': serializeParam(
                      //     _model.radioButtonValue,
                      //     ParamType.String,
                      //     ),
                      //     'daysAndHourlyType': serializeParam(
                      //     _model.daysAndHour,
                      //     ParamType.bool,
                      //     ),
                      //     'pickupLocation': serializeParam(
                      //     _model.pickupLocationValue,
                      //     ParamType.String,
                      //     ),
                      //     'dropoffLocation': serializeParam(
                      //     _model.dropOffLocationValue,
                      //     ParamType.String,
                      //     ),
                      //     'userName': serializeParam(
                      //     _model.userNameController.text,
                      //     ParamType.String,
                      //     ),
                      //     'contactnumber': serializeParam(
                      //     _model.customerPhoneNumberController.text,
                      //     ParamType.String,
                      //     ),
                      //       'coupon_code':_promocodeApplyModel==null?"0":serializeParam(
                      //        _promocodeApplyModel!.discount.toString(),
                      //         ParamType.String,
                      //       ),
                      //     'pickupDate': serializeParam(
                      //     _model.startDate,
                      //     ParamType.String,
                      //     ),
                      //     'dropoffDate': serializeParam(
                      //     _model.endDate,
                      //     ParamType.String,
                      //     ),
                      //     'licenceForntImage': serializeParam(
                      //     _model.forntImage,
                      //     ParamType.FFUploadedFile,
                      //     ),
                      //     'licenceBackImage': serializeParam(
                      //     _model.backImage,
                      //     ParamType.FFUploadedFile,
                      //     ),
                      //     'supplierid': serializeParam(
                      //     widget.supplierid,
                      //     ParamType.String,
                      //     ),
                      //       'totalAmount': _promocodeApplyModel == null
                      //           ? serializeParam(
                      //         _model.daysAndHour == true
                      //             ? formatNumber(
                      //           functions.addTwoNumber(
                      //             functions.multiplayData(
                      //               functions.newstringToDouble(
                      //                 getJsonField(widget.carDetailBooking, r'''$.car_cost''').toString(),
                      //               ),
                      //               _model.totalDays?.toDouble(),
                      //             ),
                      //             functions.multiplayData(
                      //               _model.radioButtonValue == 'Driver'
                      //                   ? functions.newstringToDouble(
                      //                 BaseUrlGroup.driverPriceCall
                      //                     .price((_model.apiResultaPrice?.jsonBody ?? ''),)
                      //                     .toString(),
                      //               )
                      //                   : 0.0,
                      //               _model.totalDays?.toDouble(),
                      //             ),
                      //           ),
                      //           formatType: FormatType.decimal,
                      //           decimalType: DecimalType.periodDecimal,
                      //         )
                      //             : formatNumber(
                      //           functions.addTwoNumber(
                      //             functions.multiplayData(
                      //               functions.newstringToDouble(
                      //                 getJsonField(widget.carDetailBooking, r'''$.car_cost''').toString(),
                      //               ),
                      //               _model.hoursAndMins,
                      //             ),
                      //             functions.multiplayData(
                      //               _model.radioButtonValue == 'Driver'
                      //                   ? functions.newstringToDouble(
                      //                 BaseUrlGroup.driverPriceCall
                      //                     .price((_model.apiResultaPrice?.jsonBody ?? ''),)
                      //                     .toString(),
                      //               )
                      //                   : 0.0,
                      //               _model.hoursAndMins,
                      //             ),
                      //           ),
                      //           formatType: FormatType.decimal,
                      //           decimalType: DecimalType.periodDecimal,
                      //         ),
                      //         ParamType.String,
                      //       )
                      //           : _promocodeApplyModel!.fare!.toString(),
                      //
                      //       'hoursAndMin': serializeParam(
                      //     _model.hoursAndMins,
                      //     ParamType.double,
                      //     ),
                      //     'totalDays': serializeParam(
                      //     _model.totalDays,
                      //     ParamType.int,
                      //     ),
                      //     }.withoutNulls,
                      //
                      //     ).then((value) {
                      //     // This block executes after the navigation completes.
                      //     setState(() {
                      //     setProgress(false);
                      //     });
                      //     });
                      //     }
                      //   },
                      //   text: "Confirm Booking",
                      //   options: FFButtonOptions(
                      //     height: 50.0,
                      //     padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      //     iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      //     color: FlutterTheme.of(context).btnclr,
                      //     textStyle: FlutterTheme.of(context).titleSmall.override(
                      //       fontFamily: 'Urbanist',
                      //       color: Colors.white,
                      //     ),
                      //     elevation: 4.0,
                      //     borderSide: BorderSide(
                      //       color: Colors.transparent,
                      //       width: 1.0,
                      //     ),
                      //     borderRadius: BorderRadius.circular(8.0),
                      //   ),
                      // ),


                      FFButtonWidget(
                        onPressed: () async {
                          // Validate form fields before proceeding
                          // if(images.length.toString()=="0"){
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text('Upload atleast one image'),
                          //     ),
                          //   );
                          // }

                          if(_model.userNameController.text==""||_model.userNameController.text==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter Name'),
                              ),
                            );
                          }

                          else if(_model.customerPhoneNumberController.text==""||_model.customerPhoneNumberController.text==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter Phone Number'),
                              ),
                            );
                          }
                          else if( _model.startDate==null|| _model.startDate==""){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter Start date'),
                              ),
                            );
                          }
                          else if( _model.endDate==null||_model.endDate==""){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enter End date'),
                              ),
                            );
                          }
                          else if(_model.forntImage==""||_model.forntImage==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Upload front image of License'),
                              ),
                            );
                          }
                          else if( _model.backImage==""||_model.backImage==null){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Upload front image of License'),
                              ),
                            );
                          }

                          // else{
                          //     setState(() {
                          //       setProgress(true);
                          //     });
                          //  // Proceed with navigation if form validation passes
                          //  context.pushNamed(
                          //    'confirmation_page',
                          //    queryParameters: {
                          //      'bookingDetails': serializeParam(
                          //        widget.carDetailBooking,
                          //        ParamType.JSON,
                          //      ),
                          //      'driverType': serializeParam(
                          //        _model.radioButtonValue,
                          //        ParamType.String,
                          //      ),
                          //      'daysAndHourlyType': serializeParam(
                          //        _model.daysAndHour,
                          //        ParamType.bool,
                          //      ),
                          //      'pickupLocation': serializeParam(
                          //        _model.pickupLocationValue,
                          //        ParamType.String,
                          //      ),
                          //      'dropoffLocation': serializeParam(
                          //        _model.dropOffLocationValue,
                          //        ParamType.String,
                          //      ),
                          //      'userName': serializeParam(
                          //        _model.userNameController.text,
                          //        ParamType.String,
                          //      ),
                          //      'contactnumber': serializeParam(
                          //        _model.customerPhoneNumberController.text,
                          //        ParamType.String,
                          //      ),
                          //      'pickupDate': serializeParam(
                          //        _model.startDate,
                          //        ParamType.String,
                          //      ),
                          //      'dropoffDate': serializeParam(
                          //        _model.endDate,
                          //        ParamType.String,
                          //      ),
                          //      'licenceForntImage': serializeParam(
                          //        _model.forntImage,
                          //        ParamType.FFUploadedFile,
                          //      ),
                          //      'licenceBackImage': serializeParam(
                          //        _model.backImage,
                          //        ParamType.FFUploadedFile,
                          //      ),
                          //      'supplierid': serializeParam(
                          //        widget.supplierid,
                          //        ParamType.String,
                          //      ),
                          //      'totalAmount': serializeParam(
                          //        _model.daysAndHour == true
                          //            ? formatNumber(
                          //          functions.addTwoNumber(
                          //              functions.multiplayData(
                          //                  functions.newstringToDouble(getJsonField(
                          //                    widget.carDetailBooking,
                          //                    r'''$.car_cost''',
                          //                  ).toString()),
                          //                  _model.totalDays?.toDouble()),
                          //              functions.multiplayData(
                          //                  _model.radioButtonValue == 'Driver'
                          //                      ? functions.newstringToDouble(
                          //                      BaseUrlGroup.driverPriceCall
                          //                          .price(
                          //                        (_model.apiResultaPrice?.jsonBody ?? ''),
                          //                      )
                          //                          .toString())
                          //                      : 0.0,
                          //                  _model.totalDays?.toDouble())),
                          //          formatType: FormatType.decimal,
                          //          decimalType: DecimalType.periodDecimal,
                          //        )
                          //            : formatNumber(
                          //          functions.addTwoNumber(
                          //              functions.multiplayData(
                          //                  functions.newstringToDouble(getJsonField(
                          //                    widget.carDetailBooking,
                          //                    r'''$.car_cost''',
                          //                  ).toString()),
                          //                  _model.hoursAndMins),
                          //              functions.multiplayData(
                          //                  _model.radioButtonValue == 'Driver'
                          //                      ? functions.newstringToDouble(
                          //                      BaseUrlGroup.driverPriceCall
                          //                          .price(
                          //                        (_model.apiResultaPrice?.jsonBody ?? ''),
                          //                      )
                          //                          .toString())
                          //                      : 0.0,
                          //                  _model.hoursAndMins)),
                          //          formatType: FormatType.decimal,
                          //          decimalType: DecimalType.periodDecimal,
                          //        ),
                          //        ParamType.String,
                          //      ),
                          //      'hoursAndMin': serializeParam(
                          //        _model.hoursAndMins,
                          //        ParamType.double,
                          //      ),
                          //      'totalDays': serializeParam(
                          //        _model.totalDays,
                          //        ParamType.int,
                          //      ),
                          //    }.withoutNulls,
                          //
                          //  );
                          //
                          //     setState(() {
                          //       setProgress(true);
                          //       // _isConfirmBookingLoading = false;
                          //     });
                          //     // setProgress(false);
                          // }
                          else {
                            print("====== widget.ownername,=====${ widget.ownername}");
                            print("====== widget.cartype,=====${ widget.car_type}");
                            setState(() {
                              setProgress(true);
                            });

                            // Proceed with navigation if form validation passes
                            context.pushNamed(
                              'confirmation_page',
                              queryParameters: {
                                'bookingDetails': serializeParam(
                                  widget.carDetailBooking,
                                  ParamType.JSON,
                                ),
                                'driverType': serializeParam(
                                  _model.radioButtonValue,
                                  ParamType.String,
                                ),
                                'ownername': serializeParam(
                                  widget.ownername,
                                  ParamType.String,
                                ),
                                'car_type': serializeParam(
                                  widget.car_type,
                                  ParamType.String,
                                ),

                                'daysAndHourlyType': serializeParam(
                                  _model.daysAndHour,
                                  ParamType.bool,
                                ),
                                'pickupLocation': serializeParam(
                                  _model.pickupLocationValue,
                                  ParamType.String,
                                ),
                                'dropoffLocation': serializeParam(
                                  _model.dropOffLocationValue,
                                  ParamType.String,
                                ),
                                'userName': serializeParam(
                                  _model.userNameController.text,
                                  ParamType.String,
                                ),
                                'contactnumber': serializeParam(
                                  _model.customerPhoneNumberController.text,
                                  ParamType.String,
                                ),
                                'coupon_code':_promocodeApplyModel==null?"0":serializeParam(
                                  _promocodeApplyModel!.discount.toString(),
                                  ParamType.String,
                                ),
                                'pickupDate': serializeParam(
                                  _model.startDate,
                                  ParamType.String,
                                ),
                                'dropoffDate': serializeParam(
                                  _model.endDate,
                                  ParamType.String,
                                ),
                                'licenceForntImage': serializeParam(
                                  _model.forntImage,
                                  ParamType.FFUploadedFile,
                                ),
                                'licenceBackImage': serializeParam(
                                  _model.backImage,
                                  ParamType.FFUploadedFile,
                                ),
                                'supplierid': serializeParam(
                                  widget.supplierid,
                                  ParamType.String,
                                ),
                                'totalAmount': _promocodeApplyModel == null
                                    ? serializeParam(
                                  _model.daysAndHour == true
                                      ? formatNumber(
                                    functions.addTwoNumber(
                                      functions.multiplayData(
                                        functions.newstringToDouble(
                                          getJsonField(widget.carDetailBooking, r'''$.car_cost''').toString(),
                                        ),
                                        _model.totalDays?.toDouble(),
                                      ),
                                      functions.multiplayData(
                                        _model.radioButtonValue == 'Driver'
                                            ? functions.newstringToDouble(
                                          BaseUrlGroup.driverPriceCall
                                              .price((_model.apiResultaPrice?.jsonBody ?? ''),)
                                              .toString(),
                                        )
                                            : 0.0,
                                        _model.totalDays?.toDouble(),
                                      ),
                                    ),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.periodDecimal,
                                  ).replaceAll(',', '')
                                      : formatNumber(
                                    functions.addTwoNumber(
                                      functions.multiplayData(
                                        functions.newstringToDouble(
                                          getJsonField(widget.carDetailBooking, r'''$.car_cost''').toString(),
                                        ),
                                        _model.hoursAndMins,
                                      ),
                                      functions.multiplayData(
                                        _model.radioButtonValue == 'Driver'
                                            ? functions.newstringToDouble(
                                          BaseUrlGroup.driverPriceCall
                                              .price((_model.apiResultaPrice?.jsonBody ?? ''),)
                                              .toString(),
                                        )
                                            : 0.0,
                                        _model.hoursAndMins,
                                      ),
                                    ),
                                    formatType: FormatType.decimal,
                                    decimalType: DecimalType.periodDecimal,
                                  ).replaceAll(',', ''),
                                  ParamType.String,
                                )
                                    : _promocodeApplyModel!.fare!.toString(),

                                'hoursAndMin': serializeParam(
                                  _model.hoursAndMins,
                                  ParamType.double,
                                ),
                                'totalDays': serializeParam(
                                  _model.totalDays,
                                  ParamType.int,
                                ),
                              }.withoutNulls,

                            ).then((value) {
                              // This block executes after the navigation completes.
                              setState(() {
                                setProgress(false);
                              });
                            });
                          }
                        },
                        text: FFLocalizations.of(context).getText('confirm_booking'),
                        options: FFButtonOptions(
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                          color: FlutterTheme.of(context).btnclr,
                          textStyle: FlutterTheme.of(context).titleSmall.override(
                            fontFamily: 'Readex Pro',
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 0.0,
                          ),
                          elevation: 4.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),


                    ]
                        .addToStart(SizedBox(height: 8.0))
                        .addToEnd(SizedBox(height: 8.0)),
                  ),
                ),
              ),
              Helper.getProgressBarWhite(context, _isVisible)
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

  _imgFromCamera() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);
      });
    }
  }

  _imgFromGallery() async {
    XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );


    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,

      );

      setState(() {

        _image = File(croppedFile!.path);
        String path = _image.toString();
        print("path" + _image!.path);


      });
    }
  }

  Future<void> promocodeApi() async {
    print("<=============promocodeApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'code': "bring7771",
      'app_token':"booking12345",
      'user_id': FFAppState().UserId,
      'coupon':promocodecontroller.text.trim().toString(),
      'basefare':_model.daysAndHour == false?

    functions.multiplayData(
    functions.newstringToDouble(
    getJsonField(
    widget.carDetailBooking,
    r'''$.car_cost''',
    ).toString()),
    _model.hoursAndMins).toString():




      functions.multiplayData(
          functions.newstringToDouble(
              getJsonField(
                widget.carDetailBooking,
                r'''$.car_cost''',
              ).toString()),
          _model.totalDays?.toDouble()).toString()


    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.promocode_apply), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          PromocodeApplied model =
          PromocodeApplied.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");
            setState(() {
              _promocodeApplyModel = model;
              // _promocodeApplyModel=null;
            });
            // SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            // sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            // sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.firstname.toString());
            // sessionHelper.put(SessionHelper.COMPANY_NAME, model.data!.companyName.toString());
            // sessionHelper.put(SessionHelper.LASTNAME, model.data!.lastname.toString());
            // sessionHelper.put(SessionHelper.PHONE, model.data!.phone.toString());
            setProgress(false);

            print("successs==============");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );

            // context.pushNamed(
            // 'ConfirmationPage',
            // queryParameters: {
            // 'userType': serializeParam(
            // UserRole.user,
            // ParamType.Enum,
            // ),
            // }.withoutNulls,
            // ).then((_) {
            // Navigator.popUntil(context, (route) => route.isFirst);
            // });

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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
