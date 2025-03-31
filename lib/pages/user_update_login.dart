import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../constant.dart';
import '../flutter/flutter_theme.dart';
import '../flutter/flutter_util.dart';
import '../flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/status_model.dart';
import 'otp_login.dart';


class UserLoginUpdateWidget extends StatefulWidget {
  const UserLoginUpdateWidget({super.key});

  @override
  State<UserLoginUpdateWidget> createState() => _UserLoginUpdateWidgetState();
}

class _UserLoginUpdateWidgetState extends State<UserLoginUpdateWidget> {
  // late UserLoginModel _model;


  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  String deviceToken="";
  bool _isVisible = false;
  String country_code = "";
  StatusModel?_statusModel;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
    FirebaseMessaging.instance.requestPermission().then((_) =>
        getDeviceTokenToSendNotification()
    );
    // _model = createModel(context, () => UserLoginModel());

    // _model.textController1 ??= TextEditingController();
    // _model.textFieldFocusNode1 ??= FocusNode();
    //
    // _model.textController2 ??= TextEditingController();
    // _model.textFieldFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {


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

    return GestureDetector(
      // onTap: () => _model.unfocusNode.canRequestFocus
      //     ? FocusScope.of(context).requestFocus(_model.unfocusNode)
      //     : FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          // backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          body: SafeArea(
            top: true,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16, top:100),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     // ClipRRect(
                          //     //   borderRadius: BorderRadius.circular(8.0),
                          //     //   child: Image.asset(
                          //     //     'assets/images/Frame_113.png',
                          //     //     width: 194.98,
                          //     //     height: 51.0,
                          //     //     fit: BoxFit.cover,
                          //     //   ),
                          //     // ),
                          //   ].divide(SizedBox(width: 4.0)),
                          // ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                               "Login With OTP",     style: GoogleFonts.raleway(
                                  fontSize: 22,
                                  color: Color(0xff0A1310),
                                  fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                              ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                              "Enter Login Credentials",     style: GoogleFonts.raleway(
                                  fontSize: 16,
                                  color: Color(0xff0A1310),
                                  fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                              ),

                              ),
                            ].divide(SizedBox(height: 4.0)),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // TextFormField(
                                  //   controller: email,
                                  //   keyboardType: TextInputType.emailAddress,
                                  //   cursorColor : Color(0xFF2451DC),
                                  //   // focusNode: _model.textFieldFocusNode1,
                                  //   autofocus: true,
                                  //   obscureText: false,
                                  //   decoration: InputDecoration(
                                  //     // labelStyle: FlutterFlowTheme.of(context)
                                  //     //     .labelMedium
                                  //     //     .override(
                                  //     //   fontFamily: 'Readex Pro',
                                  //     //   lineHeight: 2.0,
                                  //     // ),
                                  //     // hintText: FFLocalizations.of(context).getText(
                                  //     //   'tcc7mmgq' /* Email */,
                                  //     // ),
                                  //     hintText: "Email/Phone Number",
                                  //     // hintStyle: FlutterFlowTheme.of(context)
                                  //     //     .labelMedium
                                  //     //     .override(
                                  //     //   fontFamily: 'Poppins',
                                  //     //   fontSize: 16.0,
                                  //     // ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: Colors.white,
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: Color(0xFF2451DC),
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     // errorBorder: OutlineInputBorder(
                                  //     //   borderSide: BorderSide(
                                  //     //     color: FlutterFlowTheme.of(context).error,
                                  //     //     width: 2.0,
                                  //     //   ),
                                  //     //   borderRadius: BorderRadius.circular(8.0),
                                  //     // ),
                                  //     // focusedErrorBorder: OutlineInputBorder(
                                  //     //   borderSide: BorderSide(
                                  //     //     color: FlutterFlowTheme.of(context).error,
                                  //     //     width: 2.0,
                                  //     //   ),
                                  //     //   borderRadius: BorderRadius.circular(8.0),
                                  //     // ),
                                  //     filled: true,
                                  //     fillColor: Colors.white,
                                  //   ),
                                  //   // style: FlutterFlowTheme.of(context)
                                  //   //     .bodyMedium
                                  //   //     .override(
                                  //   //   fontFamily: 'Poppins',
                                  //   //   color: Colors.black,
                                  //   //   fontSize: 15.0,
                                  //   //   fontWeight: FontWeight.w300,
                                  //   // ),
                                  //   maxLines: null,
                                  //   validator: (String? value) {
                                  //     if (value != null) {
                                  //       if (value.isEmpty) {
                                  //         return FFLocalizations.of(context).getText(
                                  //           'mmkkli' /* Enter email Id */,
                                  //         );
                                  //       }
                                  //       // else if (isEmail(value)) {
                                  //       //   return null;
                                  //       // }
                                  //       // else {
                                  //       //   return FFLocalizations.of(context).getText(
                                  //       //     'aaaaa' /* Email should contain letter & Special Character */,
                                  //       //   );
                                  //       // }
                                  //     }
                                  //     // else {
                                  //     //   return FFLocalizations.of(context).getText(
                                  //     //     'bbbbb' /* fill the email */,
                                  //     //   );
                                  //     // }
                                  //   },
                                  // ),

                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 16.0),
                                    child: TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor : Color(0xFF2451DC),
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(

                                        // labelText: 'Email',
                                        hintText: 'Enter your email i’d/Mobile no.',
                                        // hintText: 'Phone number',
                                        hintStyle:
                                        GoogleFonts.raleway(
                                            fontSize: 14,
                                            color: Color(0xff7C8BA0),
                                            fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),

                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFF7C8BA0),
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                        focusedBorder:  OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF7C8BA0),
                                              width: 1.0,
                                            )),
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF7C8BA0),
                                              width: 1.0,
                                            )),
                                        focusedErrorBorder:
                                        OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFF7C8BA0),
                                              width: 1.0,
                                            )),
                                        contentPadding: EdgeInsets.all(8.0),
                                      ),
                                      style:  GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Color(0xff7C8BA0),
                                          fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                      ),
                                      validator: (String? value) {
                                        if (value != null) {
                                          if (value.isEmpty) {
                                            return FFLocalizations.of(context).getText(
                                              'mmkkli' /* Enter email Id */,
                                            );
                                          }
                                          // else if (isEmail(value)) {
                                          //   return null;
                                          // }
                                          // else {
                                          //   return FFLocalizations.of(context).getText(
                                          //     'aaaaa' /* Email should contain letter & Special Character */,
                                          //   );
                                          // }
                                        }
                                        // else {
                                        //   return FFLocalizations.of(context).getText(
                                        //     'bbbbb' /* fill the email */,
                                        //   );
                                        // }
                                      },
                                    ),
                                  ),




                                  // TextFormField(
                                  //   controller: password,
                                  //   cursorColor : Color(0xFF2451DC),
                                  //   focusNode: _model.textFieldFocusNode2,
                                  //   autofocus: true,
                                  //   obscureText: !_model.passwordVisibility1,
                                  //   decoration: InputDecoration(
                                  //     labelStyle: FlutterFlowTheme.of(context)
                                  //         .labelMedium
                                  //         .override(
                                  //       fontFamily: 'Poppins',
                                  //       fontSize: 16.0,
                                  //     ),
                                  //     hintText: FFLocalizations.of(context).getText(
                                  //       '4tk6u9ab' /* Password */,
                                  //     ),
                                  //     hintStyle: FlutterFlowTheme.of(context)
                                  //         .labelMedium
                                  //         .override(
                                  //       fontFamily: 'Poppins',
                                  //       fontSize: 16.0,
                                  //     ),
                                  //     enabledBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: Colors.white,
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: Color(0xFF2451DC),
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     errorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: FlutterFlowTheme.of(context).error,
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     focusedErrorBorder: OutlineInputBorder(
                                  //       borderSide: BorderSide(
                                  //         color: FlutterFlowTheme.of(context).error,
                                  //         width: 2.0,
                                  //       ),
                                  //       borderRadius: BorderRadius.circular(8.0),
                                  //     ),
                                  //     filled: true,
                                  //     fillColor: Colors.white,
                                  //     suffixIcon: InkWell(
                                  //       onTap: () => setState(
                                  //             () => _model.passwordVisibility1 =
                                  //         !_model.passwordVisibility1,
                                  //       ),
                                  //       focusNode: FocusNode(skipTraversal: true),
                                  //       child: Icon(
                                  //         _model.passwordVisibility1
                                  //             ? Icons.visibility_outlined
                                  //             : Icons.visibility_off_outlined,
                                  //         color: Color(0xFF757575),
                                  //         size: 20.0,
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   style: FlutterFlowTheme.of(context)
                                  //       .bodyMedium
                                  //       .override(
                                  //     fontFamily: 'Poppins',
                                  //     color: Colors.black,
                                  //     fontSize: 15.0,
                                  //     fontWeight: FontWeight.w300,
                                  //   ),
                                  //   validator: (String? value) {
                                  //     if (value != null) {
                                  //       if (value.isEmpty) {
                                  //         return FFLocalizations.of(context).getText(
                                  //           'cccc' /*Enter password  */,
                                  //         );
                                  //       }
                                  //       else if (value.length <= 2) {
                                  //         return FFLocalizations.of(context).getText(
                                  //           'dddd' /* Password should be greater than 4 digit  */,
                                  //         );
                                  //       }
                                  //       else {
                                  //         return null;
                                  //       }
                                  //     } else {
                                  //       return FFLocalizations.of(context).getText(
                                  //         'eeee' /* Please enter password  */,
                                  //       );
                                  //     }
                                  //   },
                                  // ),
                                ].divide(SizedBox(height: 16.0)),
                              ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Align(
                              //       alignment: AlignmentDirectional(1.0, -1.0),
                              //       child: InkWell(
                              //         splashColor: Colors.transparent,
                              //         focusColor: Colors.transparent,
                              //         hoverColor: Colors.transparent,
                              //         highlightColor: Colors.transparent,
                              //         onTap: () async {
                              //           context.pushNamed('Forgot_password');
                              //         },
                              //         child: Text(
                              //           FFLocalizations.of(context).getText(
                              //             'fu9tsgip' /* Forgot Password? */,
                              //           ),
                              //           textAlign: TextAlign.end,
                              //           style: FlutterFlowTheme.of(context)
                              //               .bodyMedium
                              //               .override(
                              //             fontFamily: 'Poppins',
                              //             color: Color(0xFF1344D7),
                              //             fontSize: 14.0,
                              //             fontWeight: FontWeight.w600,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),


                              FFButtonWidget(
                                onPressed: () async {

                                  if (formKey.currentState!.validate()){
                                    // phoneCheckWithFirebase();
                                    if (email.text.contains('@')) {
                                      // Perform phone number check with Firebase
                                      Helper.checkInternet(send_otp());
                                      // Helper.checkInternet(loginApi());

                                    } else {
                                      phoneCheckWithFirebase();
                                      // Move to another screen with certain parameters
                                    }

                                    // Helper.checkInternet(loginApi());
                                  }
                                  // Helper.checkInternet(loginApi('',0));
                                  // phoneCheckWithFirebase();


                                },
                                text: FFLocalizations.of(context).getText(
                                  'jvavrjuj' /* Login */,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 46.0,
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterTheme.of(context).btnclr,
                                  textStyle:
                                  GoogleFonts.raleway(
                                      fontSize: 16,
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),
                                  elevation: 3.0,
                                  borderRadius:
                                  BorderRadius.circular(10.0),
                                ),
                                // FFButtonOptions(
                                //   width: 226.0,
                                //   height: 50.0,
                                //   padding: EdgeInsetsDirectional.fromSTEB(
                                //       24.0, 0.0, 24.0, 0.0),
                                //   iconPadding:
                                //       EdgeInsetsDirectional.fromSTEB(
                                //           0.0, 0.0, 0.0, 0.0),
                                //   color: Color(0xFF5C47A8),
                                //   textStyle: FlutterTheme.of(context)
                                //       .titleSmall
                                //       .override(
                                //         fontFamily: 'Urbanist',
                                //         color: Colors.white,
                                //       ),
                                //   elevation: 3.0,
                                //   borderSide: BorderSide(
                                //     color: Colors.transparent,
                                //     width: 1.0,
                                //   ),
                                //   borderRadius: BorderRadius.circular(8.0),
                                //   disabledColor:
                                //       FlutterTheme.of(context).accent3,
                                //   disabledTextColor:
                                //       FlutterTheme.of(context).black600,
                                // ),
                              ),

                              // FFButtonWidget(
                              //   onPressed: () async {
                              //
                              //     if (formKey.currentState!.validate()){
                              //       // phoneCheckWithFirebase();
                              //       if (email.text.contains('@')) {
                              //         // Perform phone number check with Firebase
                              //         Helper.checkInternet(send_otp());
                              //         // Helper.checkInternet(loginApi());
                              //
                              //       } else {
                              //         phoneCheckWithFirebase();
                              //         // Move to another screen with certain parameters
                              //       }
                              //
                              //       // Helper.checkInternet(loginApi());
                              //     }
                              //     // Helper.checkInternet(loginApi('',0));
                              //     // phoneCheckWithFirebase();
                              //
                              //
                              //   },
                              //   text: "Login",
                              //   options: FFButtonOptions(
                              //     width: double.infinity,
                              //     height: 46.0,
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         24.0, 0.0, 24.0, 0.0),
                              //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //         0.0, 0.0, 0.0, 0.0),
                              //     color: Color(0xFF1344D7),
                              //      textStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.w600,),
                              //     // FlutterFlowTheme.of(context).titleSmall.override(
                              //     //   fontFamily: 'Poppins',
                              //     //   color: Colors.white,
                              //     //   fontWeight: FontWeight.w600,
                              //     // ),
                              //     elevation: 3.0,
                              //     borderSide: BorderSide(
                              //       color: Colors.transparent,
                              //       width: 1.0,
                              //     ),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //   ),
                              // ),
                              // FFButtonWidget(
                              //   onPressed: () async {
                              //     handelGoogleSignInNew();
                              //   },
                              //   text: "Login with google",
                              //   options: FFButtonOptions(
                              //     width: double.infinity,
                              //     height: 46.0,
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         24.0, 0.0, 24.0, 0.0),
                              //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //         0.0, 0.0, 0.0, 0.0),
                              //     color: Color(0xFF1344D7),
                              //     textStyle: FlutterFlowTheme.of(context)
                              //         .titleSmall
                              //         .override(
                              //       fontFamily: 'Poppins',
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //     elevation: 3.0,
                              //     borderSide: BorderSide(
                              //       color: Colors.transparent,
                              //       width: 1.0,
                              //     ),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //   ),
                              // ),
                              // InkWell(
                              //   onTap: () async {
                              //     handelGoogleSignInNew();
                              //   },
                              //   child: SvgPicture.asset(
                              //     'assets/images/google_login_button.svg',
                              //   ),
                              // ),
                              // FFButtonWidget(
                              //   onPressed: () async {
                              //     Helper.moveToScreenwithPush(context, UserLoginOtpWidget());
                              //   },
                              //   text: "Login with OTP",
                              //   options: FFButtonOptions(
                              //     width: double.infinity,
                              //     height: 46.0,
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         24.0, 0.0, 24.0, 0.0),
                              //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //         0.0, 0.0, 0.0, 0.0),
                              //     color: Color(0xFF1344D7),
                              //     textStyle: FlutterFlowTheme.of(context)
                              //         .titleSmall
                              //         .override(
                              //       fontFamily: 'Poppins',
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //     elevation: 3.0,
                              //     borderSide: BorderSide(
                              //       color: Colors.transparent,
                              //       width: 1.0,
                              //     ),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //   ),
                              // ),

                              // Platform.isIOS? FFButtonWidget(
                              //   onPressed: () async {
                              //     handleAppleSignIn();
                              //     // final credential = await SignInWithApple.getAppleIDCredential(
                              //     //   scopes: [
                              //     //     AppleIDAuthorizationScopes.email,
                              //     //     AppleIDAuthorizationScopes.fullName,
                              //     //   ],
                              //     // );
                              //
                              //     // print(credential);
                              //
                              //     // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                              //     // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                              //   },
                              //   text: "Login with Apple",
                              //   options: FFButtonOptions(
                              //     width: double.infinity,
                              //     height: 46.0,
                              //     padding: EdgeInsetsDirectional.fromSTEB(
                              //         24.0, 0.0, 24.0, 0.0),
                              //     iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //         0.0, 0.0, 0.0, 0.0),
                              //     color: Color(0xFF1344D7),
                              //     textStyle: FlutterFlowTheme.of(context)
                              //         .titleSmall
                              //         .override(
                              //       fontFamily: 'Poppins',
                              //       color: Colors.white,
                              //       fontWeight: FontWeight.w600,
                              //     ),
                              //     elevation: 3.0,
                              //     borderSide: BorderSide(
                              //       color: Colors.transparent,
                              //       width: 1.0,
                              //     ),
                              //     borderRadius: BorderRadius.circular(8.0),
                              //   ),
                              // ):SizedBox(),
                            ].divide(SizedBox(height: 20.0)),
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       FFLocalizations.of(context).getText(
                          //         'gfx63nfd' /* Don't have an account? */,
                          //       ),
                          //       style: FlutterFlowTheme.of(context).bodyMedium.override(
                          //         fontFamily: 'Readex Pro',
                          //         fontSize: 16.0,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          //     ),
                          //     InkWell(
                          //       splashColor: Colors.transparent,
                          //       focusColor: Colors.transparent,
                          //       hoverColor: Colors.transparent,
                          //       highlightColor: Colors.transparent,
                          //       onTap: () async {
                          //         context.pushNamed('Sign_up');
                          //       },
                          //       child: Text(
                          //         FFLocalizations.of(context).getText(
                          //           'bvat0a10' /*   Sign Up Here */,
                          //         ),
                          //         style:
                          //         FlutterFlowTheme.of(context).bodyMedium.override(
                          //           fontFamily: 'Poppins',
                          //           color: Color(0xFF2451DC),
                          //           fontSize: 16.0,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ].divide(SizedBox(height: 32.0)),
                      ),
                    ),
                  ),
                ),
                Helper.getProgressBarWhite(context, _isVisible)
              ],
            ),
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

      // Retrieve the country code from the first placemark
      String countryCode = placemarks.first.isoCountryCode ?? "";
      getCountryPhoneCode(countryCode);
      setState(() {
        country_code=getCountryPhoneCode(countryCode);
      });
      print("======countryCode=====${ country_code}");

      // You can use countryCode here as needed.

      // setState(() {
      //   startLocation = LatLng(position.latitude, position.longitude);
      //   print("====startLocation=====${startLocation}");
      //   location = placemarks.first.street.toString() +
      //       ", " +
      //       placemarks.first.subLocality.toString() +
      //       placemarks.first.administrativeArea.toString();
      //   _isVisiblenew=true;
      //   setProgress(false);
      //   print("=====location======${location}");
      // });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }

  String getCountryPhoneCode(String country) {
    Map<String, String> countryDictionary = {
      "AL":"355",
      "DZ":"213",
      "AS":"1",
      "AD":"376",
      "AO":"244",
      "AI":"1",
      "AG":"1",
      "AR":"54",
      "AM":"374",
      "AW":"297",
      "AU":"61",
      "AT":"43",
      "AZ":"994",
      "BS":"1",
      "BH":"973",
      "BD":"880",
      "BB":"1",
      "BY":"375",
      "BE":"32",
      "BZ":"501",
      "BJ":"229",
      "BM":"1",
      "BT":"975",
      "BA":"387",
      "BW":"267",
      "BR":"55",
      "IO":"246",
      "BG":"359",
      "BF":"226",
      "BI":"257",
      "KH":"855",
      "CM":"237",
      "CA":"1",
      "CV":"238",
      "KY":"345",
      "CF":"236",
      "TD":"235",
      "CL":"56",
      "CN":"86",
      "CX":"61",
      "CO":"57",
      "KM":"269",
      "CG":"242",
      "CK":"682",
      "CR":"506",
      "HR":"385",
      "CU":"53",
      "CY":"537",
      "CZ":"420",
      "DK":"45",
      "DJ":"253",
      "DM":"1",
      "DO":"1",
      "EC":"593",
      "EG":"20",
      "SV":"503",
      "GQ":"240",
      "ER":"291",
      "EE":"372",
      "ET":"251",
      "FO":"298",
      "FJ":"679",
      "FI":"358",
      "FR":"33",
      "GF":"594",
      "PF":"689",
      "GA":"241",
      "GM":"220",
      "GE":"995",
      "DE":"49",
      "GH":"233",
      "GI":"350",
      "GR":"30",
      "GL":"299",
      "GD":"1",
      "GP":"590",
      "GU":"1",
      "GT":"502",
      "GN":"224",
      "GW":"245",
      "GY":"595",
      "HT":"509",
      "HN":"504",
      "HU":"36",
      "IS":"354",
      "IN":"91",
      "ID":"62",
      "IQ":"964",
      "IE":"353",
      "IL":"972",
      "IT":"39",
      "JM":"1",
      "JP":"81",
      "JO":"962",
      "KZ":"77",
      "KE":"254",
      "KI":"686",
      "KW":"965",
      "KG":"996",
      "LV":"371",
      "LB":"961",
      "LS":"266",
      "LR":"231",
      "LI":"423",
      "LT":"370",
      "LU":"352",
      "MG":"261",
      "MW":"265",
      "MY":"60",
      "MV":"960",
      "ML":"223",
      "MT":"356",
      "MH":"692",
      "MQ":"596",
      "MR":"222",
      "MU":"230",
      "YT":"262",
      "MX":"52",
      "MC":"377",
      "MN":"976",
      "ME":"382",
      "MS":"1",
      "MA":"212",
      "MM":"95",
      "NA":"264",
      "NR":"674",
      "NP":"977",
      "NL":"31",
      "AN":"599",
      "NC":"687",
      "NZ":"64",
      "NI":"505",
      "NE":"227",
      "NG":"234",
      "NU":"683",
      "NF":"672",
      "MP":"1",
      "NO":"47",
      "OM":"968",
      "PK":"92",
      "PW":"680",
      "PA":"507",
      "PG":"675",
      "PY":"595",
      "PE":"51",
      "PH":"63",
      "PL":"48",
      "PT":"351",
      "PR":"1",
      "QA":"974",
      "RO":"40",
      "RW":"250",
      "WS":"685",
      "SM":"378",
      "SA":"966",
      "SN":"221",
      "RS":"381",
      "SC":"248",
      "SL":"232",
      "SG":"65",
      "SK":"421",
      "SI":"386",
      "SB":"677",
      "ZA":"27",
      "GS":"500",
      "ES":"34",
      "LK":"94",
      "SD":"249",
      "SR":"597",
      "SZ":"268",
      "SE":"46",
      "CH":"41",
      "TJ":"992",
      "TH":"66",
      "TG":"228",
      "TK":"690",
      "TO":"676",
      "TT":"1",
      "TN":"216",
      "TR":"90",
      "TM":"993",
      "TC":"1",
      "TV":"688",
      "UG":"256",
      "UA":"380",
      "AE":"971",
      "GB":"44",
      "US":"1",
      "UY":"598",
      "UZ":"998",
      "VU":"678",
      "WF":"681",
      "YE":"967",
      "ZM":"260",
      "ZW":"263",
      "BO":"591",
      "BN":"673",
      "CC":"61",
      "CD":"243",
      "CI":"225",
      "FK":"500",
      "GG":"44",
      "VA":"379",
      "HK":"852",
      "IR":"98",
      "IM":"44",
      "JE":"44",
      "KP":"850",
      "KR":"82",
      "LA":"856",
      "LY":"218",
      "MO":"853",
      "MK":"389",
      "FM":"691",
      "MD":"373",
      "MZ":"258",
      "PS":"970",
      "PN":"872",
      "RE":"262",
      "RU":"7",
      "BL":"590",
      "SH":"290",
      "KN":"1",
      "LC":"1",
      "MF":"590",
      "PM":"508",
      "VC":"1",
      "ST":"239",
      "SO":"252",
      "SJ":"47",
      "SY":"963",
      "TW":"886",
      "TZ":"255",
      "TL":"670",
      "VE":"58",
      "VN":"84",
      "VG":"284",
      "VI":"340"
      // Add the rest of the country codes here...
    };

    // Check if the country code exists in the dictionary
    if (countryDictionary.containsKey(country)) {
      return countryDictionary[country]!;
    } else {
      return ""; // Return empty string if country code is not found
    }
  }

  Future<void> phoneCheckWithFirebase() async{

    print("======================phoneCheckWithFirebase=====================");

    setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    // String phone =mobileNumber.text.trim().toString();
    String phone = "+"+"91" + email.text.trim();
    // String phone = "+"+country_code + email.text.trim();
    print("phone in phoneCheckWithFirebase===>${phone.toString()}");
    //new code start
    // final _fireStore = FirebaseFirestore.instance;
    // QuerySnapshot querySnapshot = await _fireStore.collection('student_details').where("student_phone", isEqualTo: phone).get();
    // // final allData =
    // // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) {
          setProgress(false);
        },
        verificationFailed: (ex) {


          ToastMessage.msg(ex.message.toString());
          // log("ex"+ ex.code.toString());
          print("Failed--->${ex.code.toString()}");
          print("Failed--->${ex.message.toString()}");

          setProgress(false);
        },
        codeSent: (verificationId, forceResendingToken) {
          setProgress(false);
          //API to call
          Helper.moveToScreenwithPush(context, OtploginScreenparcela(
            Mobilenumber: email.text.toString(),
            forceResendingToken: forceResendingToken,

            verificationId: verificationId,
            // afterSignUp: true,countryCode: countryCode.toString(),
            afterSignUp: true,countryCode: "+91", firstname: '', lastname: '', password: '', phonenumber: '', userTypes: '', company_name: '',
            email: '', image: '', address: '', postal_code: '', devicetoken: '', whichscreen: '', data: '',
          ));


        },
        codeAutoRetrievalTimeout: (verificationId) {
          setProgress(false);
        },
        timeout: Duration(seconds: 30)
    );
    // if (allData.length==0) {
    //   //new code end
    //   //firebase otp code
    //   // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    //   await FirebaseAuth.instance.verifyPhoneNumber(
    //       phoneNumber: phone,
    //       verificationCompleted: (credential) {
    //         setProgress(false);
    //       },
    //       verificationFailed: (ex) {
    //
    //
    //         ToastMessage.msg(ex.message.toString());
    //         // log("ex"+ ex.code.toString());
    //         print("Failed--->${ex.code.toString()}");
    //         print("Failed--->${ex.message.toString()}");
    //
    //         setProgress(false);
    //       },
    //       codeSent: (verificationId, forceResendingToken) {
    //         setProgress(false);
    //         //API to call
    //         Helper.moveToScreenwithPush(context, OtploginScreenparcela(
    //           Mobilenumber: email.text.toString(),
    //           forceResendingToken: forceResendingToken,
    //
    //           verificationId: verificationId,
    //           // afterSignUp: true,countryCode: countryCode.toString(),
    //           afterSignUp: true,countryCode: "+91", firstname: '', lastname: '', password: '', phonenumber: '', userTypes: '', company_name: '',
    //           email: '', image: '', address: '', postal_code: '', devicetoken: '', whichscreen: '', data: '',
    //         ));
    //
    //
    //       },
    //       codeAutoRetrievalTimeout: (verificationId) {
    //         setProgress(false);
    //       },
    //       timeout: Duration(seconds: 30)
    //   );
    //   //firebase otp code end
    //   //firebase otp code end
    // }
    // else{
    //   FirebaseAuth.instance.signOut();
    //   ToastMessage.msg("Phone number already registered, Please sign in");
    //   // Fluttertoast.showToast( msg:"");
    //   setProgress(false);
    // }
  }

  Future<void> getDeviceTokenToSendNotification() async {
    print("getDeviceTokenToSendNotification");
    try{
      final FirebaseMessaging _fcm = FirebaseMessaging.instance;
      final token = await _fcm.getToken();

      deviceToken = token.toString();
      setState(() {
        deviceToken = token.toString();
      });
      print("Token Value $deviceToken");
    } catch (e) {

      print('exception in getting token ==> '+ e.toString());
    }
  }
  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\\'
        r'"))@((\[\.\.\.'
        r'\])|(([a-zA-Z\-]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }















  Future<void> send_otp() async {


    print("<=============send_otp=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'code':"COURIERAPP-30062016",
      'type':"1",
      'user_type':"1",
      'email':email.text.trim().toString(),
      'password':'',
      'app_token':'booking12345'
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.send_otp_email), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          StatusModel model = StatusModel.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");

            setProgress(false);
            setState(() {
              _statusModel=model;
            });




            Helper.moveToScreenwithPush(context, OtploginScreenparcela(
              Mobilenumber: email.text.trim().toString(),
              forceResendingToken: 0,
              verificationId: "",
              // afterSignUp: true,countryCode: countryCode.toString(),
              afterSignUp: true,countryCode: '',
              firstname:'',
              lastname: '', password: password.text.toString(),
              phonenumber: '', userTypes: "1", company_name: '',
              email:email.text.trim().toString(), image:'', address: '', postal_code: '', devicetoken:deviceToken, whichscreen: '2', data: _statusModel!.data.toString(),
            ));
          }
          else {
            setProgress(false);
            print("false ### ============>");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );

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

  static Future<void> checkInternet(Future<dynamic> callback) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      callback.asStream();
      // callback.call();
    } else {
      Fluttertoast.showToast(msg: 'CHECK_INTERNET');
    }
  }
}
