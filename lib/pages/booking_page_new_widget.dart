// import 'dart:io';
// import 'package:car_rental/backend/api_requests/api_constants.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import '/backend/api_requests/api_calls.dart';
// import '/flutter_flow/flutter_flow_drop_down.dart';
// import '/flutter_flow/flutter_flow_icon_button.dart';
// import '/flutter_flow/flutter_flow_radio_button.dart';
// import '/flutter_flow/flutter_flow_theme.dart';
// import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/flutter_flow_widgets.dart';
// import '/flutter_flow/form_field_controller.dart';
// import '/flutter_flow/upload_data.dart';
// import '/flutter_flow/custom_functions.dart' as functions;
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:provider/provider.dart';
// import 'booking_page_model.dart';
// export 'booking_page_model.dart';
//
// class BookingPageWidget extends StatefulWidget {
//   const BookingPageWidget({
//     Key? key,
//     this.carDetailBooking,
//     required this.priceType,
//     double? carCost,
//      required this.supplierid, required this.carid,
//   })  : this.carCost = carCost ?? .0,
//         super(key: key);
//
//   final dynamic carDetailBooking;
//   final String? priceType;
//   final double carCost;
//   final String supplierid;
//   final String carid;
//
//
//   @override
//   _BookingPageWidgetState createState() => _BookingPageWidgetState();
// }
//
// class _BookingPageWidgetState extends State<BookingPageWidget> {
//   late BookingPageModel _model;
//
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   File? _image;
//   String imagesource = "";
//   final _picker = ImagePicker();
//
//   @override
//   void initState() {
//     super.initState();
//     _model = createModel(context, () => BookingPageModel());
//
//     print("========carid====${widget.carid.toString()}");
//     // On page load action.
//     SchedulerBinding.instance.addPostFrameCallback((_) async {
//       setState(() {
//         _model.daysAndHour = widget.priceType == 'Days' ? true : false;
//       });
//       setState(() {
//         _model.driverAmount = _model.radioButtonValue == 'Self' ? 0 : 50;
//       });
//       _model.apiResultaPrice = await BaseUrlGroup.driverPriceCall.call();
//       if ((_model.apiResultaPrice?.succeeded ?? true)) {
//         return;
//       }
//
//       return;
//     });
//
//     _model.userNameController ??= TextEditingController();
//     _model.userNameFocusNode ??= FocusNode();
//
//     _model.customerPhoneNumberController ??= TextEditingController();
//     _model.customerPhoneNumberFocusNode ??= FocusNode();
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isiOS) {
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//           statusBarBrightness: Theme.of(context).brightness,
//           systemStatusBarContrastEnforced: true,
//         ),
//       );
//     }
//
//     context.watch<FFAppState>();
//
//     return GestureDetector(
//       onTap: () => _model.unfocusNode.canRequestFocus
//           ? FocusScope.of(context).requestFocus(_model.unfocusNode)
//           : FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         key: scaffoldKey,
//         backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//         appBar: AppBar(
//           backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
//           automaticallyImplyLeading: false,
//           leading: FlutterFlowIconButton(
//             borderColor: Colors.transparent,
//             borderRadius: 30.0,
//             borderWidth: 1.0,
//             buttonSize: 60.0,
//             icon: Icon(
//               Icons.arrow_back_sharp,
//               color: FlutterFlowTheme.of(context).primaryText,
//               size: 30.0,
//             ),
//             onPressed: () async {
//               context.pop();
//             },
//           ),
//           title: Text(
//             FFLocalizations.of(context).getText(
//               'rfbijtbs' /* Booking */,
//             ),
//             style: FlutterFlowTheme.of(context).headlineMedium.override(
//                   fontFamily: 'Urbanist',
//                   color: FlutterFlowTheme.of(context).primaryText,
//                   fontSize: 22.0,
//                 ),
//           ),
//           actions: [],
//           centerTitle: true,
//           elevation: 2.0,
//         ),
//         body: SafeArea(
//           top: true,
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                      clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                      // elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           FlutterFlowRadioButton(
//                             options: [
//                               // "Self Drive",
//                               FFLocalizations.of(context).getText(
//                                 'v8no0oyb' /* Self */,
//                               ),
//                               FFLocalizations.of(context).getText(
//                                 'jz6j8hga' /* Driver */,
//                               )
//                             ].toList(),
//                             onChanged: (val) async {
//                               setState(() {});
//                               setState(() {
//                                 _model.driverType = valueOrDefault<bool>(
//                                   _model.radioButtonValue == 'Self'
//                                       ? false
//                                       : true,
//                                   false,
//                                 );
//                               });
//                             },
//                             controller: _model.radioButtonValueController ??=
//                                 FormFieldController<String>(
//                                     FFLocalizations.of(context).getText(
//                               '6pl2lxl3' /* Self */,
//                             )),
//                             optionHeight: 32.0,
//                             textStyle: FlutterFlowTheme.of(context).labelMedium,
//                             selectedTextStyle:
//                                 FlutterFlowTheme.of(context).bodyMedium,
//                             buttonPosition: RadioButtonPosition.left,
//                             direction: Axis.horizontal,
//                             radioButtonColor:
//                                 FlutterFlowTheme.of(context).secondary,
//                             inactiveRadioButtonColor:
//                                 FlutterFlowTheme.of(context).secondaryText,
//                             toggleable: false,
//                             horizontalAlignment: WrapAlignment.start,
//                             verticalAlignment: WrapCrossAlignment.start,
//                           ),
//                           if (_model.radioButtonValue == 'Driver')
//                             Builder(
//                               builder: (context) {
//                                 if (_model.radioButtonValue == 'Driver') {
//                                   return Row(
//                                     mainAxisSize: MainAxisSize.max,
//                                     children: [
//                                       // Text(
//                                       //   FFLocalizations.of(context).getText(
//                                       //     'gcruivme' /* $ */,
//                                       //   ),
//                                       //   style: FlutterFlowTheme.of(context)
//                                       //       .bodyMedium
//                                       //       .override(
//                                       //         fontFamily: 'Urbanist',
//                                       //         fontSize: 18.0,
//                                       //         fontWeight: FontWeight.bold,
//                                       //       ),
//                                       // ),
//                                       // Text(
//                                       //   BaseUrlGroup.driverPriceCall
//                                       //       .price(
//                                       //         (_model.apiResultaPrice
//                                       //                 ?.jsonBody ??
//                                       //             ''),
//                                       //       )
//                                       //       .toString(),
//                                       //   style: FlutterFlowTheme.of(context)
//                                       //       .bodyMedium
//                                       //       .override(
//                                       //         fontFamily: 'Urbanist',
//                                       //         fontSize: 18.0,
//                                       //         fontWeight: FontWeight.bold,
//                                       //       ),
//                                       // ),
//                                       // Text(
//                                       //   FFLocalizations.of(context).getText(
//                                       //     'o8e8rhpu' /*  Per Days */,
//                                       //   ),
//                                       //   style: FlutterFlowTheme.of(context)
//                                       //       .bodyMedium
//                                       //       .override(
//                                       //         fontFamily: 'Urbanist',
//                                       //         fontSize: 18.0,
//                                       //         fontWeight: FontWeight.bold,
//                                       //       ),
//                                       // ),
//                                     ],
//                                   );
//                                 } else {
//                                   return Text(
//                                     FFLocalizations.of(context).getText(
//                                       'sobzzdfw' /*   */,
//                                     ),
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyMedium
//                                         .override(
//                                           fontFamily: 'Urbanist',
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   );
//                                 }
//                               },
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                 //   child: Card(
//                 //     clipBehavior: Clip.antiAliasWithSaveLayer,
//                 //     color: FlutterFlowTheme.of(context).secondaryBackground,
//                 //     elevation: 4.0,
//                 //     shape: RoundedRectangleBorder(
//                 //       borderRadius: BorderRadius.circular(8.0),
//                 //     ),
//                 //     child: Padding(
//                 //       padding:
//                 //           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                 //       child: Row(
//                 //         mainAxisSize: MainAxisSize.max,
//                 //         children: [
//                 //           Text(
//                 //             FFLocalizations.of(context).getText(
//                 //               'x1lc4q5d' /* $ */,
//                 //             ),
//                 //             style: FlutterFlowTheme.of(context)
//                 //                 .bodyMedium
//                 //                 .override(
//                 //                   fontFamily: 'Urbanist',
//                 //                   fontSize: 18.0,
//                 //                   fontWeight: FontWeight.bold,
//                 //                 ),
//                 //           ),
//                 //           Text(
//                 //             getJsonField(
//                 //               widget.carDetailBooking,
//                 //               r'''$.car_cost''',
//                 //             ).toString(),
//                 //             style: FlutterFlowTheme.of(context)
//                 //                 .bodyMedium
//                 //                 .override(
//                 //                   fontFamily: 'Urbanist',
//                 //                   fontSize: 18.0,
//                 //                   fontWeight: FontWeight.bold,
//                 //                 ),
//                 //           ),
//                 //           Text(
//                 //             FFLocalizations.of(context).getText(
//                 //               's3b6u5bv' /*  Per */,
//                 //             ),
//                 //             style: FlutterFlowTheme.of(context)
//                 //                 .bodyMedium
//                 //                 .override(
//                 //                   fontFamily: 'Urbanist',
//                 //                   fontSize: 18.0,
//                 //                   fontWeight: FontWeight.bold,
//                 //                 ),
//                 //           ),
//                 //           Text(
//                 //             getJsonField(
//                 //               widget.carDetailBooking,
//                 //               r'''$.price_type''',
//                 //             ).toString(),
//                 //             style: FlutterFlowTheme.of(context)
//                 //                 .bodyMedium
//                 //                 .override(
//                 //                   fontFamily: 'Urbanist',
//                 //                   fontSize: 18.0,
//                 //                   fontWeight: FontWeight.bold,
//                 //                 ),
//                 //           ),
//                 //         ].divide(SizedBox(width: 2.0)),
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     // elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           FutureBuilder<ApiCallResponse>(
//                             future: BaseUrlGroup.locationCall.call(
//                                 carId: widget.carid
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
//                                         FlutterFlowTheme.of(context).primary,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               final conditionalBuilderLocationResponse =
//                                   snapshot.data!;
//                               return Builder(
//                                 builder: (context) {
//                                   if (BaseUrlGroup.locationCall.response(
//                                     conditionalBuilderLocationResponse.jsonBody,
//                                   )) {
//                                     return FlutterFlowDropDown<String>(
//                                       controller: _model
//                                               .pickupLocationValueController ??=
//                                           FormFieldController<String>(null),
//                                       options: (BaseUrlGroup.locationCall
//                                               .locationsList(
//                                         conditionalBuilderLocationResponse
//                                             .jsonBody,
//                                       ) as List)
//                                           .map<String>((s) => s.toString())
//                                           .toList()!
//                                           .map((e) => e.toString())
//                                           .toList(),
//                                       onChanged: (val) => setState(() =>
//                                           _model.pickupLocationValue = val),
//                                       width: double.infinity,
//                                       height: 50.0,
//                                       textStyle: FlutterFlowTheme.of(context)
//                                           .bodyMedium,
//                                       hintText:
//                                           FFLocalizations.of(context).getText(
//                                         '7adfhanl' /* Please select pickup location */,
//                                       ),
//                                       icon: Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: FlutterFlowTheme.of(context)
//                                             .secondaryText,
//                                         size: 24.0,
//                                       ),
//                                       fillColor:Color(0xffEFEFF0),
//                                       elevation: 0.0,
//                                       borderColor: FlutterFlowTheme.of(context)
//                                           .alternate,
//                                       borderWidth: 2.0,
//                                       borderRadius: 8.0,
//                                       margin: EdgeInsetsDirectional.fromSTEB(
//                                           16.0, 4.0, 16.0, 4.0),
//                                       hidesUnderline: true,
//                                       isSearchable: false,
//                                       isMultiSelect: false,
//                                     );
//                                   } else {
//                                     return Text(
//                                       BaseUrlGroup.locationCall
//                                           .message(
//                                             conditionalBuilderLocationResponse
//                                                 .jsonBody,
//                                           )
//                                           .toString(),
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium,
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                           FutureBuilder<ApiCallResponse>(
//                             future: BaseUrlGroup.locationCall.call(
//                               carId: widget.carid,
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
//                                         FlutterFlowTheme.of(context).primary,
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }
//                               final conditionalBuilderLocationResponse =
//                                   snapshot.data!;
//                               return Builder(
//                                 builder: (context) {
//                                   if (BaseUrlGroup.locationCall.response(
//                                     conditionalBuilderLocationResponse.jsonBody,
//                                   )) {
//                                     return FlutterFlowDropDown<String>(
//                                       controller: _model
//                                               .dropOffLocationValueController ??=
//                                           FormFieldController<String>(null),
//                                       options: (BaseUrlGroup.locationCall
//                                               .locationsList(
//                                         conditionalBuilderLocationResponse
//                                             .jsonBody,
//                                       ) as List)
//                                           .map<String>((s) => s.toString())
//                                           .toList()!
//                                           .map((e) => e.toString())
//                                           .toList(),
//                                       onChanged: (val) => setState(() =>
//                                           _model.dropOffLocationValue = val),
//                                       width: double.infinity,
//                                       height: 50.0,
//                                       textStyle: FlutterFlowTheme.of(context)
//                                           .bodyMedium,
//                                       hintText:
//                                           FFLocalizations.of(context).getText(
//                                         '6bgu8ex7' /* Please select dropoff location */,
//                                       ),
//                                       icon: Icon(
//                                         Icons.keyboard_arrow_down_rounded,
//                                         color: FlutterFlowTheme.of(context)
//                                             .secondaryText,
//                                         size: 24.0,
//                                       ),
//                                       // fillColor: FlutterFlowTheme.of(context)
//                                       //     .secondaryBackground,
//                                       // elevation: 2.0,
//                                       fillColor:Color(0xffEFEFF0),
//                                       elevation: 0.0,
//                                       borderColor: FlutterFlowTheme.of(context)
//                                           .alternate,
//                                       borderWidth: 2.0,
//                                       borderRadius: 8.0,
//                                       margin: EdgeInsetsDirectional.fromSTEB(
//                                           16.0, 4.0, 16.0, 4.0),
//                                       hidesUnderline: true,
//                                       isSearchable: false,
//                                       isMultiSelect: false,
//                                     );
//                                   } else {
//                                     return Text(
//                                       BaseUrlGroup.locationCall
//                                           .message(
//                                             conditionalBuilderLocationResponse
//                                                 .jsonBody,
//                                           )
//                                           .toString(),
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium,
//                                     );
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                         ].divide(SizedBox(height: 8.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     // color: FlutterFlowTheme.of(context).secondaryBackground,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     // elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 0.0, 8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Text(
//                             "Enter Tenant Details",
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                               fontFamily: 'Urbanist',
//                               fontSize: 18.0,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 8.0, 0.0, 8.0, 0.0),
//                             child: TextFormField(
//
//                               controller: _model.userNameController,
//                               focusNode: _model.userNameFocusNode,
//                               autofocus: true,
//                               obscureText: false,
//                               decoration: InputDecoration(
//                                 labelText: FFLocalizations.of(context).getText(
//                                   'nve5nwq1' /* Name of Rented */,
//                                 ),
//                                 labelStyle:
//                                     FlutterFlowTheme.of(context).labelMedium,
//                                 hintText: FFLocalizations.of(context).getText(
//                                   'pli178ke' /* Please enter name */,
//                                 ),
//                                 fillColor: Color(0xffEFEFF0),
//                                 filled: true,
//                                 hintStyle:
//                                     FlutterFlowTheme.of(context).labelMedium,
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color:
//                                         FlutterFlowTheme.of(context).alternate,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).primary,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               style: FlutterFlowTheme.of(context).bodyMedium,
//                               validator: _model.userNameControllerValidator
//                                   .asValidator(context),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 8.0, 0.0, 8.0, 0.0),
//                             child: TextFormField(
//                               controller: _model.customerPhoneNumberController,
//                               focusNode: _model.customerPhoneNumberFocusNode,
//                               autofocus: true,
//                               obscureText: false,
//                               decoration: InputDecoration(
//                                 labelText: FFLocalizations.of(context).getText(
//                                   '7kixyhdg' /* Phone Number */,
//                                 ),
//                                 fillColor: Color(0xffEFEFF0),
//                                 filled: true,
//                                 labelStyle:
//                                     FlutterFlowTheme.of(context).labelMedium,
//                                 hintText: FFLocalizations.of(context).getText(
//                                   '9fwpvtje' /* Please enter contact Number */,
//                                 ),
//                                 hintStyle:
//                                     FlutterFlowTheme.of(context).labelMedium,
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color:
//                                         FlutterFlowTheme.of(context).alternate,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).primary,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: FlutterFlowTheme.of(context).error,
//                                     width: 2.0,
//                                   ),
//                                   borderRadius: BorderRadius.circular(8.0),
//                                 ),
//                               ),
//                               style: FlutterFlowTheme.of(context).bodyMedium,
//                               keyboardType: TextInputType.phone,
//                               validator: _model
//                                   .customerPhoneNumberControllerValidator
//                                   .asValidator(context),
//                               inputFormatters: [_model.customerPhoneNumberMask],
//                             ),
//                           ),
//                         ].divide(SizedBox(height: 8.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     elevation: 0.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Padding(
//                             padding: EdgeInsetsDirectional.fromSTEB(
//                                 8.0, 8.0, 8.0, 8.0),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Builder(
//                                   builder: (context) {
//                                     if (_model.daysAndHour ?? false) {
//                                       return FFButtonWidget(
//                                         icon: Icon(Icons.calendar_month),
//                                         onPressed: () async {
//                                           // startDaysTime
//                                           final _datePicked1Date =
//                                               await showDatePicker(
//                                             context: context,
//                                             initialDate: getCurrentTimestamp,
//                                             firstDate: getCurrentTimestamp,
//                                             lastDate: DateTime(2050),
//                                           );
//
//                                           if (_datePicked1Date != null) {
//                                             safeSetState(() {
//                                               _model.datePicked1 = DateTime(
//                                                 _datePicked1Date.year,
//                                                 _datePicked1Date.month,
//                                                 _datePicked1Date.day,
//                                               );
//                                             });
//                                           }
//                                           setState(() {
//                                             _model.startDate = dateTimeFormat(
//                                               'yMMMd',
//                                               _model.datePicked1,
//                                               locale:
//                                                   FFLocalizations.of(context)
//                                                       .languageCode,
//                                             );
//                                           });
//                                         },
//                                         text:
//                                             FFLocalizations.of(context).getText(
//                                           '6b8vp6f5' /* Start date */,
//                                         ),
//                                         options: FFButtonOptions(
//                                           height: 40.0,
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   24.0, 0.0, 24.0, 0.0),
//                                           iconPadding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0.0, 0.0, 0.0, 0.0),
//                                           color: FlutterFlowTheme.of(context)
//                                               .secondary,
//                                           textStyle:
//                                               FlutterFlowTheme.of(context)
//                                                   .titleSmall
//                                                   .override(
//                                                     fontFamily: 'Urbanist',
//                                                     color: Colors.white,
//                                                   ),
//                                           elevation: 3.0,
//                                           borderSide: BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1.0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                         ),
//                                         showLoadingIndicator: false,
//                                       );
//                                     } else {
//                                       return FFButtonWidget(
//
//                                         onPressed: () async {
//                                           // startDaysTime
//
//                                           final _datePicked2Time =
//                                               await showTimePicker(
//                                             context: context,
//                                             initialTime: TimeOfDay.fromDateTime(
//                                                 getCurrentTimestamp),
//                                           );
//                                           if (_datePicked2Time != null) {
//                                             safeSetState(() {
//                                               _model.datePicked2 = DateTime(
//                                                 getCurrentTimestamp.year,
//                                                 getCurrentTimestamp.month,
//                                                 getCurrentTimestamp.day,
//                                                 _datePicked2Time.hour,
//                                                 _datePicked2Time.minute,
//                                               );
//                                             });
//                                           }
//                                           setState(() {
//                                             _model.startDate = dateTimeFormat(
//                                               'jm',
//                                               _model.datePicked2,
//                                               locale:
//                                                   FFLocalizations.of(context)
//                                                       .languageCode,
//                                             );
//                                           });
//                                         },
//                                         text:
//                                             FFLocalizations.of(context).getText(
//                                           'p878gseq' /* Start time */,
//                                         ),
//                                         options: FFButtonOptions(
//                                           height: 40.0,
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   24.0, 0.0, 24.0, 0.0),
//                                           iconPadding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0.0, 0.0, 0.0, 0.0),
//                                           color: FlutterFlowTheme.of(context)
//                                               .secondary,
//                                           textStyle:
//                                               FlutterFlowTheme.of(context)
//                                                   .titleSmall
//                                                   .override(
//                                                     fontFamily: 'Urbanist',
//                                                     color: Colors.white,
//                                                   ),
//                                           elevation: 3.0,
//                                           borderSide: BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1.0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                         ),
//                                         icon: Icon(Icons.calendar_month),
//                                         showLoadingIndicator: false,
//                                       );
//                                     }
//                                   },
//                                 ),
//                                 // FaIcon(
//                                 //   FontAwesomeIcons.exchangeAlt,
//                                 //   color: FlutterFlowTheme.of(context)
//                                 //       .secondaryText,
//                                 //   size: 30.0,
//                                 // ),
//                                 Builder(
//                                   builder: (context) {
//                                     if (_model.daysAndHour ?? false) {
//                                       return FFButtonWidget(
//                                         icon: Icon(Icons.calendar_month),
//                                         onPressed: () async {
//                                           final _datePicked3Date =
//                                               await showDatePicker(
//                                             context: context,
//                                             initialDate: (_model.datePicked1 ??
//                                                 DateTime.now()),
//                                             firstDate: (_model.datePicked1 ??
//                                                 DateTime.now()),
//                                             lastDate: DateTime(2050),
//                                           );
//
//                                           if (_datePicked3Date != null) {
//                                             safeSetState(() {
//                                               _model.datePicked3 = DateTime(
//                                                 _datePicked3Date.year,
//                                                 _datePicked3Date.month,
//                                                 _datePicked3Date.day,
//                                               );
//                                             });
//                                           }
//                                           _model.endDate = dateTimeFormat(
//                                             'yMMMd',
//                                             _model.datePicked3,
//                                             locale: FFLocalizations.of(context)
//                                                 .languageCode,
//                                           );
//                                           setState(() {
//                                             _model.totalDays =
//                                                 functions.getDaysNumbers(
//                                                     _model.datePicked1,
//                                                     _model.datePicked3);
//                                           });
//                                         },
//
//                                         text:
//                                             FFLocalizations.of(context).getText(
//                                           '1ui0h2nb' /* End date */,
//                                         ),
//                                         options: FFButtonOptions(
//                                           height: 40.0,
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   24.0, 0.0, 24.0, 0.0),
//                                           iconPadding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0.0, 0.0, 0.0, 0.0),
//                                           color: FlutterFlowTheme.of(context)
//                                               .secondary,
//                                           textStyle:
//                                               FlutterFlowTheme.of(context)
//                                                   .titleSmall
//                                                   .override(
//                                                     fontFamily: 'Urbanist',
//                                                     color: Colors.white,
//                                                   ),
//                                           elevation: 3.0,
//                                           borderSide: BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1.0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                         ),
//                                         showLoadingIndicator: false,
//                                       );
//                                     } else {
//                                       return FFButtonWidget(
//                                         icon: Icon(Icons.calendar_month),
//                                         onPressed: () async {
//                                           final _datePicked4Time =
//                                               await showTimePicker(
//                                             context: context,
//                                             initialTime: TimeOfDay.fromDateTime(
//                                                 (_model.datePicked2 ??
//                                                     DateTime.now())),
//                                           );
//                                           if (_datePicked4Time != null) {
//                                             safeSetState(() {
//                                               _model.datePicked4 = DateTime(
//                                                 (_model.datePicked2 ??
//                                                         DateTime.now())
//                                                     .year,
//                                                 (_model.datePicked2 ??
//                                                         DateTime.now())
//                                                     .month,
//                                                 (_model.datePicked2 ??
//                                                         DateTime.now())
//                                                     .day,
//                                                 _datePicked4Time.hour,
//                                                 _datePicked4Time.minute,
//                                               );
//                                             });
//                                           }
//                                           _model.endDate = dateTimeFormat(
//                                             'd/M h:mm a',
//                                             _model.datePicked4,
//                                             locale: FFLocalizations.of(context)
//                                                 .languageCode,
//                                           );
//                                           setState(() {
//                                             _model.hoursAndMins =
//                                                 functions.getHoursAndMinutes(
//                                                     _model.datePicked2,
//                                                     _model.datePicked4);
//                                           });
//                                         },
//                                         text:
//                                             FFLocalizations.of(context).getText(
//                                           '062bdg35' /* End time */,
//                                         ),
//                                         options: FFButtonOptions(
//                                           height: 40.0,
//                                           padding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   24.0, 0.0, 24.0, 0.0),
//                                           iconPadding:
//                                               EdgeInsetsDirectional.fromSTEB(
//                                                   0.0, 0.0, 0.0, 0.0),
//                                           color: FlutterFlowTheme.of(context)
//                                               .secondary,
//                                           textStyle:
//                                               FlutterFlowTheme.of(context)
//                                                   .titleSmall
//                                                   .override(
//                                                     fontFamily: 'Urbanist',
//                                                     color: Colors.white,
//                                                   ),
//                                           elevation: 3.0,
//                                           borderSide: BorderSide(
//                                             color: Colors.transparent,
//                                             width: 1.0,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(8.0),
//                                         ),
//                                         showLoadingIndicator: false,
//                                       );
//                                     }
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.max,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   _model.daysAndHour == true
//                                       ? dateTimeFormat(
//                                           'yMMMd',
//                                           _model.datePicked1,
//                                           locale: FFLocalizations.of(context)
//                                               .languageCode,
//                                         )
//                                       : dateTimeFormat(
//                                           'd/M h:mm a',
//                                           _model.datePicked2,
//                                           locale: FFLocalizations.of(context)
//                                               .languageCode,
//                                         ),
//                                   textAlign: TextAlign.center,
//                                   style:
//                                       FlutterFlowTheme.of(context).bodyMedium,
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   _model.daysAndHour == true
//                                       ? dateTimeFormat(
//                                           'yMMMd',
//                                           _model.datePicked3,
//                                           locale: FFLocalizations.of(context)
//                                               .languageCode,
//                                         )
//                                       : dateTimeFormat(
//                                           'd/M h:mm a',
//                                           _model.datePicked4,
//                                           locale: FFLocalizations.of(context)
//                                               .languageCode,
//                                         ),
//                                   textAlign: TextAlign.center,
//                                   style:
//                                       FlutterFlowTheme.of(context).bodyMedium,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Padding(
//                     padding:
//                         EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.max,
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           FFLocalizations.of(context).getText(
//                             'uwxzfxa2' /* License photo back and fornt */,
//                           ),
//                           style: FlutterFlowTheme.of(context)
//                               .bodyMedium
//                               .override(
//                                 fontFamily: 'Urbanist',
//                                 fontSize: 18.0,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//
//                             // InkWell(
//                             //   onTap: () {
//                             //     _showPicker(context);
//                             //   },
//                             //   child:_image != null? Stack(
//                             //     children: [
//                             //       Container(
//                             //           width: 85.0,
//                             //           height: 85.0,
//                             //           clipBehavior: Clip.antiAlias,
//                             //           decoration: BoxDecoration(
//                             //             shape: BoxShape.circle,
//                             //           ),
//                             //           child: Image.file(
//                             //             _image!,
//                             //             fit: BoxFit.cover,
//                             //           )
//                             //       ),
//                             //       Positioned(
//                             //           right: 0,
//                             //           bottom:5 ,
//                             //           child: Icon(Icons.camera_alt))
//                             //     ],
//                             //   ): Stack(
//                             //     children: [
//                             //       Container(
//                             //         width: 85.0,
//                             //         height: 85.0,
//                             //         clipBehavior: Clip.antiAlias,
//                             //         decoration: BoxDecoration(
//                             //             shape: BoxShape.circle,
//                             //             // border: Border.all(color: FlutterFlowTheme.of(context).btnNaviBlue,width: 1)
//                             //         ),
//                             //
//                             //         child: ClipRRect(
//                             //           borderRadius: BorderRadius.circular(40),
//                             //           child: Center(
//                             //             child: Image.asset(
//                             //               'assets/images/playstore_logo.png',
//                             //               fit: BoxFit.cover,
//                             //             ),
//                             //           ),
//                             //         ),
//                             //       ),
//                             //       Positioned(
//                             //           right: 0,
//                             //           bottom:5 ,
//                             //           child: Icon(Icons.camera_alt))
//                             //     ],
//                             //   ),
//                             // ),
//
//
//                             Builder(
//
//
//
//                               builder: (context) {
//                                 if (_model.intforntimage ?? false) {
//                                   return InkWell(
//                                     splashColor: Colors.transparent,
//                                     focusColor: Colors.transparent,
//                                     hoverColor: Colors.transparent,
//                                     highlightColor: Colors.transparent,
//                                     onTap: () async {
//                                       final selectedMedia =
//                                           await selectMediaWithSourceBottomSheet(
//                                         context: context,
//                                         imageQuality: 100,
//                                         allowPhoto: true,
//                                         includeDimensions: true,
//                                       );
//                                       if (selectedMedia != null &&
//                                           selectedMedia.every((m) =>
//                                               validateFileFormat(
//                                                   m.storagePath, context))) {
//                                         setState(() =>
//                                             _model.isDataUploading1 = true);
//                                         var selectedUploadedFiles =
//                                             <FFUploadedFile>[];
//
//                                         try {
//                                           // showUploadMessage(
//                                           //   context,
//                                           //   'Uploading file...',
//                                           //   showLoading: true,
//                                           // );
//                                           selectedUploadedFiles =
//                                               selectedMedia
//                                                   .map((m) => FFUploadedFile(
//                                                         name: m.filePath,
//                                                         bytes: m.bytes,
//                                                         height: m.dimensions
//                                                             ?.height,
//                                                         width: m.dimensions
//                                                             ?.width,
//                                                         blurHash: m.blurHash,
//                                                       ))
//                                                   .toList();
//                                         } finally {
//                                           ScaffoldMessenger.of(context)
//                                               .hideCurrentSnackBar();
//                                           _model.isDataUploading1 = false;
//                                         }
//                                         if (selectedUploadedFiles.length ==
//                                             selectedMedia.length) {
//                                           setState(() {
//                                             _model.uploadedLocalFile1 =
//                                                 selectedUploadedFiles.first;
//                                           });
//                                           showUploadMessage(
//                                               context, 'Success!');
//                                           print("Uploaded Image Path 1: ${_model.uploadedLocalFile1}");
//                                         } else {
//                                           setState(() {});
//                                           showUploadMessage(context,
//                                               'Failed to upload data');
//                                           return;
//                                         }
//                                       }
//
//                                       setState(() {
//                                         _model.forntImage =
//                                             _model.uploadedLocalFile1;
//                                       });
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(8.0),
//                                       child:
//
//                                       Image.memory(
//                                         _model.forntImage?.bytes ??
//                                             Uint8List.fromList([]),
//                                         width: 170.0,
//                                         height: 130.0,
//                                         fit: BoxFit.contain,
//                                          cacheWidth: 170,
//                                          cacheHeight: 130,
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   return InkWell(
//                                     splashColor: Colors.transparent,
//                                     focusColor: Colors.transparent,
//                                     hoverColor: Colors.transparent,
//                                     highlightColor: Colors.transparent,
//                                     onTap: () async {
//                                       final selectedMedia =
//                                           await selectMediaWithSourceBottomSheet(
//                                         context: context,
//                                         imageQuality: 100,
//                                         allowPhoto: true,
//                                         includeDimensions: true,
//                                       );
//                                       if (selectedMedia != null &&
//                                           selectedMedia.every((m) =>
//                                               validateFileFormat(
//                                                   m.storagePath, context))) {
//                                         setState(() =>
//                                             _model.isDataUploading2 = true);
//                                         var selectedUploadedFiles =
//                                             <FFUploadedFile>[];
//
//                                         try {
//                                           // showUploadMessage(
//                                           //   context,
//                                           //   'Uploading file...',
//                                           //   showLoading: true,
//                                           // );
//                                           selectedUploadedFiles =
//                                               selectedMedia
//                                                   .map((m) => FFUploadedFile(
//                                                         name: m.filePath,
//                                                         bytes: m.bytes,
//                                                         height: m.dimensions
//                                                             ?.height,
//                                                         width: m.dimensions
//                                                             ?.width,
//                                                         blurHash: m.blurHash,
//                                                       ))
//                                                   .toList();
//                                         } finally {
//                                           ScaffoldMessenger.of(context)
//                                               .hideCurrentSnackBar();
//                                           _model.isDataUploading2 = false;
//                                         }
//                                         if (selectedUploadedFiles.length ==
//                                             selectedMedia.length) {
//                                           setState(() {
//                                             _model.uploadedLocalFile2 =
//                                                 selectedUploadedFiles.first;
//                                           });
//                                           showUploadMessage(
//                                               context, 'Success!');
//                                           print("Uploaded Image Path 2: ${_model.uploadedLocalFile2}");
//                                         } else {
//                                           setState(() {});
//                                           showUploadMessage(context,
//                                               'Failed to upload data');
//                                           return;
//                                         }
//                                       }
//
//                                       setState(() {
//                                         _model.forntImage =
//                                             _model.uploadedLocalFile2;
//                                       });
//                                       setState(() {
//                                         _model.intforntimage = true;
//                                       });
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(8.0),
//                                       child: Image.asset(
//                                         'assets/images/license.png',
//                                         width: 170.0,
//                                         height: 130.0,
//                                         fit: BoxFit.contain,
//                                          cacheWidth: 170,
//                                          cacheHeight: 130,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                             Builder(
//                               builder: (context) {
//                                 if (_model.intbackimage ?? false) {
//                                   return InkWell(
//                                     splashColor: Colors.transparent,
//                                     focusColor: Colors.transparent,
//                                     hoverColor: Colors.transparent,
//                                     highlightColor: Colors.transparent,
//                                     onTap: () async {
//                                       final selectedMedia =
//                                           await selectMediaWithSourceBottomSheet(
//                                         context: context,
//                                         imageQuality: 100,
//                                         allowPhoto: true,
//                                         includeDimensions: true,
//                                       );
//                                       if (selectedMedia != null &&
//                                           selectedMedia.every((m) =>
//                                               validateFileFormat(
//                                                   m.storagePath, context))) {
//                                         setState(() =>
//                                             _model.isDataUploading3 = true);
//                                         var selectedUploadedFiles =
//                                             <FFUploadedFile>[];
//
//                                         try {
//                                           // showUploadMessage(
//                                           //   context,
//                                           //   'Uploading file...',
//                                           //   showLoading: true,
//                                           // );
//                                           selectedUploadedFiles =
//                                               selectedMedia
//                                                   .map((m) => FFUploadedFile(
//                                                         name: m.filePath,
//                                                         bytes: m.bytes,
//                                                         height: m.dimensions
//                                                             ?.height,
//                                                         width: m.dimensions
//                                                             ?.width,
//                                                         blurHash: m.blurHash,
//                                                       ))
//                                                   .toList();
//                                         } finally {
//                                           ScaffoldMessenger.of(context)
//                                               .hideCurrentSnackBar();
//                                           _model.isDataUploading3 = false;
//                                         }
//                                         if (selectedUploadedFiles.length ==
//                                             selectedMedia.length) {
//                                           setState(() {
//                                             _model.uploadedLocalFile3 =
//                                                 selectedUploadedFiles.first;
//                                           });
//                                           showUploadMessage(
//                                               context, 'Success!yeahhhh');
//                                           print("Uploaded Image Path: ${_model.uploadedLocalFile3.name}");
//                                         } else {
//                                           setState(() {});
//                                           showUploadMessage(context,
//                                               'Failed to upload data');
//                                           return;
//                                         }
//                                       }
//
//                                       setState(() {
//                                         _model.backImage =
//                                             _model.uploadedLocalFile3;
//                                       });
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(8.0),
//                                       child: Image.memory(
//                                         _model.backImage?.bytes ??
//                                             Uint8List.fromList([]),
//                                         width: 170.0,
//                                         height: 130.0,
//                                         fit: BoxFit.contain,
//                                         cacheWidth: 170,
//                                         cacheHeight: 130,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Image.asset(
//                                           'assets/images/error_image.png',
//                                                   width: 170.0,
//                                                   height: 130.0,
//                                                   fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 } else {
//                                   return InkWell(
//                                     splashColor: Colors.transparent,
//                                     focusColor: Colors.transparent,
//                                     hoverColor: Colors.transparent,
//                                     highlightColor: Colors.transparent,
//                                     onTap: () async {
//                                       final selectedMedia =
//                                           await selectMediaWithSourceBottomSheet(
//                                         context: context,
//                                         imageQuality: 100,
//                                         allowPhoto: true,
//                                         includeDimensions: true,
//                                       );
//                                       if (selectedMedia != null &&
//                                           selectedMedia.every((m) =>
//                                               validateFileFormat(
//                                                   m.storagePath, context))) {
//                                         setState(() =>
//                                             _model.isDataUploading4 = true);
//                                         var selectedUploadedFiles =
//                                             <FFUploadedFile>[];
//
//                                         try {
//                                           // showUploadMessage(
//                                           //   context,
//                                           //   'Uploading file...',
//                                           //   showLoading: true,
//                                           // );
//                                           selectedUploadedFiles =
//                                               selectedMedia
//                                                   .map((m) => FFUploadedFile(
//                                                         name: m.filePath,
//                                                         bytes: m.bytes,
//                                                         height: m.dimensions
//                                                             ?.height,
//                                                         width: m.dimensions
//                                                             ?.width,
//                                                         blurHash: m.blurHash,
//                                                       ))
//                                                   .toList();
//                                         } finally {
//                                           ScaffoldMessenger.of(context)
//                                               .hideCurrentSnackBar();
//                                           _model.isDataUploading4 = false;
//                                         }
//                                         if (selectedUploadedFiles.length ==
//                                             selectedMedia.length) {
//                                           setState(() {
//                                             _model.uploadedLocalFile4 =
//                                                 selectedUploadedFiles.first;
//                                           });
//                                           showUploadMessage(
//                                               context, 'Success!');
//                                           print("Uploaded Image Path 4: ${_model.uploadedLocalFile4}");
//                                         } else {
//                                           setState(() {});
//                                           showUploadMessage(context,
//                                               'Failed to upload data');
//                                           return;
//                                         }
//                                       }
//
//                                       setState(() {
//                                         _model.backImage =
//                                             _model.uploadedLocalFile4;
//                                       });
//                                       setState(() {
//                                         _model.intbackimage = true;
//                                       });
//                                     },
//                                     child: ClipRRect(
//                                       borderRadius:
//                                           BorderRadius.circular(8.0),
//                                       child: Image.asset(
//                                         'assets/images/license.png',
//                                         width: 170.0,
//                                         height: 130.0,
//                                         fit: BoxFit.contain,
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ].divide(SizedBox(height: 8.0)),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     elevation: 0.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: Column(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Text(
//                             FFLocalizations.of(context).getText(
//                               'b9dlagdz' /* Rental  Rees */,
//                             ),
//                             style: FlutterFlowTheme.of(context)
//                                 .bodyMedium
//                                 .override(
//                                   fontFamily: 'Urbanist',
//                                   fontSize: 18.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                           ),
//                           Column(
//                             mainAxisSize: MainAxisSize.max,
//                             children: [
//                               Builder(
//                                 builder: (context) {
//                                   if (_model.radioButtonValue == 'Driver') {
//                                     return Container(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           8.0, 0.0, 8.0, 0.0),
//                                       height: 60,
//                                           decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(12),
//                                               color: Color(0xffEFEFF0)
//                                           ),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Text(
//                                                "Total",
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 _model.daysAndHour!
//                                                     ? formatNumber(
//                                                         _model.totalDays,
//                                                         formatType:
//                                                             FormatType.decimal,
//                                                         decimalType: DecimalType
//                                                             .periodDecimal,
//                                                       )
//                                                     : formatNumber(
//                                                         _model.hoursAndMins,
//                                                         formatType:
//                                                             FormatType.decimal,
//                                                         decimalType: DecimalType
//                                                             .periodDecimal,
//                                                       ),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 getJsonField(
//                                                   widget.carDetailBooking,
//                                                   r'''$.price_type''',
//                                                 ).toString(),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 FFLocalizations.of(context)
//                                                     .getText(
//                                                   'qj2u90vy' /* driver */,
//                                                 ),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                             ].divide(SizedBox(width: 2.0)),
//                                           ),
//                                           Text(
//                                             valueOrDefault<String>(
//                                               formatNumber(
//                                                 functions.multiplayData(
//                                                     _model.radioButtonValue ==
//                                                             'Driver'
//                                                         ? functions
//                                                             .newstringToDouble(
//                                                                 BaseUrlGroup
//                                                                     .driverPriceCall
//                                                                     .price(
//                                                                       (_model.apiResultaPrice
//                                                                               ?.jsonBody ??
//                                                                           ''),
//                                                                     )
//                                                                     .toString())
//                                                         : 0.0,
//                                                     _model.daysAndHour!
//                                                         ? _model.totalDays
//                                                             ?.toDouble()
//                                                         : _model.hoursAndMins),
//                                                 formatType: FormatType.decimal,
//                                                 decimalType:
//                                                     DecimalType.periodDecimal,
//                                                 currency: '\$',
//                                               ),
//                                               '0.0',
//                                             ),
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Urbanist',
//                                                   color:
//                                                       FlutterFlowTheme.of(context)
//                                                           .accent2,
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                           ),
//                                         ].divide(SizedBox(width: 2.0)),
//                                       ),
//                                     );
//                                   } else {
//                                     return Text(
//                                       FFLocalizations.of(context).getText(
//                                         'le6zzjtl' /*   */,
//                                       ),
//                                       style: FlutterFlowTheme.of(context)
//                                           .bodyMedium
//                                           .override(
//                                             fontFamily: 'Urbanist',
//                                             color: FlutterFlowTheme.of(context)
//                                                 .accent2,
//                                             fontSize: 18.0,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                     );
//                                   }
//                                 },
//                               ),
//                               Builder(
//                                 builder: (context) {
//                                   if (_model.daysAndHour ?? false) {
//                                     return Container(
//                                       padding: EdgeInsetsDirectional.fromSTEB(
//                                           8.0, 0.0, 8.0, 0.0),
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(12),
//                                           color: Color(0xffEFEFF0)
//                                       ),
//                                       child: Row(
//                                         mainAxisSize: MainAxisSize.max,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             children: [
//                                               Text(
//                                                 FFLocalizations.of(context)
//                                                     .getText(
//                                                   '89j9atll' /* Total of  */,
//                                                 ),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 valueOrDefault<String>(
//                                                   formatNumber(
//                                                     _model.totalDays,
//                                                     formatType:
//                                                         FormatType.decimal,
//                                                     decimalType:
//                                                         DecimalType.periodDecimal,
//                                                   ),
//                                                   '0.0',
//                                                 ),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                               Text(
//                                                 FFLocalizations.of(context)
//                                                     .getText(
//                                                   'p5ik7die' /* days */,
//                                                 ),
//                                                 style: FlutterFlowTheme.of(
//                                                         context)
//                                                     .bodyMedium
//                                                     .override(
//                                                       fontFamily: 'Urbanist',
//                                                       color: FlutterFlowTheme.of(
//                                                               context)
//                                                           .accent2,
//                                                       fontSize: 18.0,
//                                                       fontWeight: FontWeight.bold,
//                                                     ),
//                                               ),
//                                             ].divide(SizedBox(width: 2.0)),
//                                           ),
//                                           Text(
//                                             valueOrDefault<String>(
//                                               formatNumber(
//                                                 functions.multiplayData(
//                                                     functions.newstringToDouble(
//                                                         getJsonField(
//                                                       widget.carDetailBooking,
//                                                       r'''$.car_cost''',
//                                                     ).toString()),
//                                                     _model.totalDays?.toDouble()),
//                                                 formatType: FormatType.decimal,
//                                                 decimalType:
//                                                     DecimalType.periodDecimal,
//                                                 currency: '\$',
//                                               ),
//                                               '0.0',
//                                             ),
//                                             style: FlutterFlowTheme.of(context)
//                                                 .bodyMedium
//                                                 .override(
//                                                   fontFamily: 'Urbanist',
//                                                   color:
//                                                       FlutterFlowTheme.of(context)
//                                                           .accent2,
//                                                   fontSize: 18.0,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                           ),
//                                         ].divide(SizedBox(width: 2.0)),
//                                       ),
//                                     );
//                                   } else {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(bottom: 8.0,top: 8),
//                                       child: Container(
//                                         padding: EdgeInsetsDirectional.fromSTEB(
//                                             8.0, 0.0, 8.0, 0.0),
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(12),
//                                             color: Color(0xffEFEFF0)
//                                         ),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.max,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               mainAxisSize: MainAxisSize.max,
//                                               children: [
//                                                 Text(
//                                                   FFLocalizations.of(context)
//                                                       .getText(
//                                                     'b44laoxv' /* Total of  */,
//                                                   ),
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily: 'Urbanist',
//                                                         color: FlutterFlowTheme.of(
//                                                                 context)
//                                                             .accent2,
//                                                         fontSize: 18.0,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                 ),
//                                                 Text(
//                                                   formatNumber(
//                                                     _model.hoursAndMins,
//                                                     formatType: FormatType.decimal,
//                                                     decimalType:
//                                                         DecimalType.periodDecimal,
//                                                   ),
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily: 'Urbanist',
//                                                         color: FlutterFlowTheme.of(
//                                                                 context)
//                                                             .accent2,
//                                                         fontSize: 18.0,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                 ),
//                                                 Text(
//                                                   FFLocalizations.of(context)
//                                                       .getText(
//                                                     '4iixpq4v' /*  houly */,
//                                                   ),
//                                                   style: FlutterFlowTheme.of(
//                                                           context)
//                                                       .bodyMedium
//                                                       .override(
//                                                         fontFamily: 'Urbanist',
//                                                         color: FlutterFlowTheme.of(
//                                                                 context)
//                                                             .accent2,
//                                                         fontSize: 18.0,
//                                                         fontWeight: FontWeight.bold,
//                                                       ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Text(
//                                               formatNumber(
//                                                 functions.multiplayData(
//                                                     _model.hoursAndMins,
//                                                     functions.newstringToDouble(
//                                                         getJsonField(
//                                                       widget.carDetailBooking,
//                                                       r'''$.car_cost''',
//                                                     ).toString())),
//                                                 formatType: FormatType.decimal,
//                                                 decimalType:
//                                                     DecimalType.periodDecimal,
//                                                 currency: '\$',
//                                               ),
//                                               style: FlutterFlowTheme.of(context)
//                                                   .bodyMedium
//                                                   .override(
//                                                     fontFamily: 'Urbanist',
//                                                     color:
//                                                         FlutterFlowTheme.of(context)
//                                                             .accent2,
//                                                     fontSize: 18.0,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                             ),
//                                           ].divide(SizedBox(width: 2.0)),
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                               Divider(
//                                 thickness: 1.0,
//                                 color: FlutterFlowTheme.of(context).accent4,
//                               ),
//                               Builder(
//                                 builder: (context) {
//                                   if (_model.daysAndHour ?? false) {
//                                     return Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           FFLocalizations.of(context).getText(
//                                             'nx5oz5zu' /* Total fees */,
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Urbanist',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                         ),
//                                         Text(
//                                           formatNumber(
//                                             functions.addTwoNumber(
//                                                 functions.multiplayData(
//                                                     functions.newstringToDouble(
//                                                         getJsonField(
//                                                       widget.carDetailBooking,
//                                                       r'''$.car_cost''',
//                                                     ).toString()),
//                                                     _model.totalDays
//                                                         ?.toDouble()),
//                                                 functions.multiplayData(
//                                                     _model.radioButtonValue ==
//                                                             'Driver'
//                                                         ? functions
//                                                             .newstringToDouble(
//                                                                 BaseUrlGroup
//                                                                     .driverPriceCall
//                                                                     .price(
//                                                                       (_model.apiResultaPrice
//                                                                               ?.jsonBody ??
//                                                                           ''),
//                                                                     )
//                                                                     .toString())
//                                                         : 0.0,
//                                                     _model.totalDays
//                                                         ?.toDouble())),
//                                             formatType: FormatType.decimal,
//                                             decimalType:
//                                                 DecimalType.periodDecimal,
//                                             currency: '\$',
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Urbanist',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                         ),
//                                       ].divide(SizedBox(width: 2.0)),
//                                     );
//                                   } else {
//                                     return Row(
//                                       mainAxisSize: MainAxisSize.max,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           FFLocalizations.of(context).getText(
//                                             'kvtmofp3' /* Total fees */,
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Urbanist',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                         ),
//                                         Text(
//                                           formatNumber(
//                                             functions.addTwoNumber(
//                                                 functions.multiplayData(
//                                                     functions.newstringToDouble(
//                                                         getJsonField(
//                                                       widget.carDetailBooking,
//                                                       r'''$.car_cost''',
//                                                     ).toString()),
//                                                     _model.hoursAndMins),
//                                                 functions.multiplayData(
//                                                     _model.radioButtonValue ==
//                                                             'Driver'
//                                                         ? functions
//                                                             .newstringToDouble(
//                                                                 BaseUrlGroup
//                                                                     .driverPriceCall
//                                                                     .price(
//                                                                       (_model.apiResultaPrice
//                                                                               ?.jsonBody ??
//                                                                           ''),
//                                                                     )
//                                                                     .toString())
//                                                         : 0.0,
//                                                     _model.hoursAndMins)),
//                                             formatType: FormatType.decimal,
//                                             decimalType:
//                                                 DecimalType.periodDecimal,
//                                             currency: '\$',
//                                           ),
//                                           style: FlutterFlowTheme.of(context)
//                                               .bodyMedium
//                                               .override(
//                                                 fontFamily: 'Urbanist',
//                                                 color:
//                                                     FlutterFlowTheme.of(context)
//                                                         .secondary,
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                         ),
//                                       ].divide(SizedBox(width: 2.0)),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ].divide(SizedBox(height: 8.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: Card(
//                     clipBehavior: Clip.antiAliasWithSaveLayer,
//                     color: FlutterFlowTheme.of(context).secondaryBackground,
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                     child: Padding(
//                       padding:
//                           EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Expanded(
//                             child: Row(
//                               mainAxisSize: MainAxisSize.max,
//                               children: [
//                                 Theme(
//                                   data: ThemeData(
//                                     checkboxTheme: CheckboxThemeData(
//                                       visualDensity: VisualDensity.compact,
//                                       materialTapTargetSize:
//                                           MaterialTapTargetSize.shrinkWrap,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(4.0),
//                                       ),
//                                     ),
//                                     unselectedWidgetColor:
//                                         FlutterFlowTheme.of(context)
//                                             .plumpPurple,
//                                   ),
//                                   child: Checkbox(
//                                     value: _model.checkboxValue ??= true,
//                                     onChanged: (newValue) async {
//                                       setState(() =>
//                                           _model.checkboxValue = newValue!);
//                                     },
//                                     activeColor: FlutterFlowTheme.of(context)
//                                         .plumpPurple,
//                                     checkColor: FlutterFlowTheme.of(context)
//                                         .primaryBtnText,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     FFLocalizations.of(context).getText(
//                                       'p8jtyhqy' /* Please accpet terms amd condit... */,
//                                     ),
//                                     style: FlutterFlowTheme.of(context)
//                                         .bodyMedium
//                                         .override(
//                                           fontFamily: 'Urbanist',
//                                           fontSize: 18.0,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                   ),
//                                 ),
//                               ].divide(SizedBox(width: 8.0)),
//                             ),
//                           ),
//                         ].divide(SizedBox(width: 16.0)),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
//                   child: FFButtonWidget(
//                     onPressed: () async {
//                       // Validate form fields before proceeding
//                       // if(images.length.toString()=="0"){
//                       //   ScaffoldMessenger.of(context).showSnackBar(
//                       //     SnackBar(
//                       //       content: Text('Upload atleast one image'),
//                       //     ),
//                       //   );
//                       // }
//                        if(_model.userNameController.text==""||_model.userNameController.text==null){
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Enter Name'),
//                           ),
//                         );
//                       }
//
//                       else if(_model.customerPhoneNumberController.text==""||_model.customerPhoneNumberController.text==null){
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Enter Phone Number'),
//                           ),
//                         );
//                       }
//                       else if( _model.startDate==null|| _model.startDate==""){
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Enter Start date'),
//                           ),
//                         );
//                       }
//                       else if( _model.endDate==null||_model.endDate==""){
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text('Enter End date'),
//                           ),
//                         );
//                       }
//                        else if(_model.forntImage==""||_model.forntImage==null){
//                          ScaffoldMessenger.of(context).showSnackBar(
//                            SnackBar(
//                              content: Text('Upload front image of License'),
//                            ),
//                          );
//                        }
//                        else if( _model.backImage==""||_model.backImage==null){
//                          ScaffoldMessenger.of(context).showSnackBar(
//                            SnackBar(
//                              content: Text('Upload front image of License'),
//                            ),
//                          );
//                        }
//
// else{
//                       // Proceed with navigation if form validation passes
//                       context.pushNamed(
//                         'confirmation_page',
//                         queryParameters: {
//                           'bookingDetails': serializeParam(
//                             widget.carDetailBooking,
//                             ParamType.JSON,
//                           ),
//                           'driverType': serializeParam(
//                             _model.radioButtonValue,
//                             ParamType.String,
//                           ),
//                           'daysAndHourlyType': serializeParam(
//                             _model.daysAndHour,
//                             ParamType.bool,
//                           ),
//                           'pickupLocation': serializeParam(
//                             _model.pickupLocationValue,
//                             ParamType.String,
//                           ),
//                           'dropoffLocation': serializeParam(
//                             _model.dropOffLocationValue,
//                             ParamType.String,
//                           ),
//                           'userName': serializeParam(
//                             _model.userNameController.text,
//                             ParamType.String,
//                           ),
//                           'contactnumber': serializeParam(
//                             _model.customerPhoneNumberController.text,
//                             ParamType.String,
//                           ),
//                           'pickupDate': serializeParam(
//                             _model.startDate,
//                             ParamType.String,
//                           ),
//                           'dropoffDate': serializeParam(
//                             _model.endDate,
//                             ParamType.String,
//                           ),
//                           'licenceForntImage': serializeParam(
//                             _model.forntImage,
//                             ParamType.FFUploadedFile,
//                           ),
//                           'licenceBackImage': serializeParam(
//                             _model.backImage,
//                             ParamType.FFUploadedFile,
//                           ),
//                           'supplierid': serializeParam(
//                             widget.supplierid,
//                             ParamType.String,
//                           ),
//                           'totalAmount': serializeParam(
//                             _model.daysAndHour == true
//                                 ? formatNumber(
//                               functions.addTwoNumber(
//                                   functions.multiplayData(
//                                       functions.newstringToDouble(getJsonField(
//                                         widget.carDetailBooking,
//                                         r'''$.car_cost''',
//                                       ).toString()),
//                                       _model.totalDays?.toDouble()),
//                                   functions.multiplayData(
//                                       _model.radioButtonValue == 'Driver'
//                                           ? functions.newstringToDouble(
//                                           BaseUrlGroup.driverPriceCall
//                                               .price(
//                                             (_model.apiResultaPrice?.jsonBody ?? ''),
//                                           )
//                                               .toString())
//                                           : 0.0,
//                                       _model.totalDays?.toDouble())),
//                               formatType: FormatType.decimal,
//                               decimalType: DecimalType.periodDecimal,
//                             )
//                                 : formatNumber(
//                               functions.addTwoNumber(
//                                   functions.multiplayData(
//                                       functions.newstringToDouble(getJsonField(
//                                         widget.carDetailBooking,
//                                         r'''$.car_cost''',
//                                       ).toString()),
//                                       _model.hoursAndMins),
//                                   functions.multiplayData(
//                                       _model.radioButtonValue == 'Driver'
//                                           ? functions.newstringToDouble(
//                                           BaseUrlGroup.driverPriceCall
//                                               .price(
//                                             (_model.apiResultaPrice?.jsonBody ?? ''),
//                                           )
//                                               .toString())
//                                           : 0.0,
//                                       _model.hoursAndMins)),
//                               formatType: FormatType.decimal,
//                               decimalType: DecimalType.periodDecimal,
//                             ),
//                             ParamType.String,
//                           ),
//                           'hoursAndMin': serializeParam(
//                             _model.hoursAndMins,
//                             ParamType.double,
//                           ),
//                           'totalDays': serializeParam(
//                             _model.totalDays,
//                             ParamType.int,
//                           ),
//                         }.withoutNulls,
//                       );}
//                     },
//                     text: "Confirm Booking",
//                     options: FFButtonOptions(
//                       height: 50.0,
//                       padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
//                       iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
//                       color: FlutterFlowTheme.of(context).secondary,
//                       textStyle: FlutterFlowTheme.of(context).titleSmall.override(
//                         fontFamily: 'Urbanist',
//                         color: Colors.white,
//                       ),
//                       elevation: 4.0,
//                       borderSide: BorderSide(
//                         color: Colors.transparent,
//                         width: 1.0,
//                       ),
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//
//                 ),
//               ]
//                   .addToStart(SizedBox(height: 8.0))
//                   .addToEnd(SizedBox(height: 8.0)),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   _imgFromCamera() async {
//     PickedFile? image = await _picker.getImage(
//       source: ImageSource.camera,
//       imageQuality: 50,
//     );
//     // _cropImage(image);
//     // setState(() {
//     //   _image = File(image!.path);
//     //   String path = _image.toString();
//     //   print("path" + _image!.path);
//     // });
//
//     if (image != null) {
//       CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: image.path,
//         aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//         compressQuality: 100,
//         maxHeight: 1000,
//         maxWidth: 1000,
//         compressFormat: ImageCompressFormat.jpg,
//
//       );
//
//       setState(() {
//
//         _image = File(croppedFile!.path);
//         String path = _image.toString();
//         print("path" + _image!.path);
//
//
//       });
//     }
//   }
//
//   _imgFromGallery() async {
//     PickedFile? image = await _picker.getImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     );
//
//
//     if (image != null) {
//       CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: image.path,
//         aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
//         compressQuality: 100,
//         maxHeight: 1000,
//         maxWidth: 1000,
//         compressFormat: ImageCompressFormat.jpg,
//
//       );
//
//       setState(() {
//
//         _image = File(croppedFile!.path);
//         String path = _image.toString();
//         print("path" + _image!.path);
//
//
//       });
//     }
//   }
//
//   void _showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Photo Library'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Navigator.of(context).pop();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.photo_camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
