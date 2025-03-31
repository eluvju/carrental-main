import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../../backend/api_requests/api_constants.dart';
import '../../constant.dart';
import '../../model/common_model.dart';
import '../../model/google_login_model.dart';
import '../../model/google_signup_model.dart';
import '../forget_password.dart';
import '../user_update_login.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_language_selector.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';
import 'package:http/http.dart' as http;

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String deviceToken="";
  bool _isVisible = false;
  double? globalLatitude;
  double? globalLongitude;
  LatLng startLocation = LatLng(0, 0);
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());

    _model.emailController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();
    FirebaseMessaging.instance.requestPermission().then((_) =>

        getDeviceTokenToSendNotification());
    getCurrentLocation();
  }

  @override
  void dispose() {
    _model.dispose();
    // _model.passwordController.text = "123456";
    // _model.emailController.text = "pramod@gmail.com";
    super.dispose();
  }

  Future userLogin(String email, String password) async {
    String url = BaseURl.url + ApiAction.login;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields[ApiConstantsKey.kcode] = ApiCode.kcode;
    request.fields[ApiConstantsKey.kdeviceToken] = deviceToken;
    request.fields[ApiConstantsKey.kdeviceType] = DeviceType.kdeviceType;
    request.fields[ApiConstantsKey.kemail] = email;
    request.fields[ApiConstantsKey.kuserType] = "2";
    request.fields[ApiConstantsKey.kpassword] = password;

    var response = await request.send();
    final result = await http.Response.fromStream(response);
    if (result.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // print(result.body);
      final jsonData = jsonDecode(result.body);

      final String isStatus = jsonData["result"];
      final String message = jsonData["message"];
      await Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
        //Navigator.pop(context); //pop dialog
      });
      if (isStatus == APIResponse.success) {
        var data = jsonData["data"];
        //  SharedPrefs.instance.setBool(LoginCheck.kLoggedIn, true);
        //var registrationData = RegistrationModels.fromMap(data);
        var userId = data["user_id"];
        var username = data["username"];
        var profileImage = data["profile_image"];
        // await SharedPrefs.instance.setString(LoginCheck.kuserId, "$userId");
        //  await SharedPrefs.instance.setString(LoginCheck.kusername, "$username");
        //  await SharedPrefs.instance
        //   .setString(LoginCheck.kprofile, "$profileImage");

        // Navigator.pushAndRemoveUntil(
        //   context, _homeRoute, (Route<dynamic> r) => false);
      } else {
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return ShowDialogcustomAlert(
        //       msg: message,
        //     );
        //   },
        // );
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
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

    return    WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: FlutterTheme.of(context).plumpPurple,
        // backgroundColor: FlutterTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
                            child: FlutterLanguageSelector(
                              width: 140.0,
                              backgroundColor: FlutterTheme.of(context).secondary,
                              borderColor: Colors.transparent,
                              dropdownIconColor: Colors.white,
                              borderRadius: 8.0,
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                              hideFlags: false,
                              flagSize: 20.0,
                              flagTextGap: 4.0,
                              currentLanguage: FFLocalizations.of(context).languageCode,
                              languages: FFLocalizations.languages(),
                              onChanged: (lang) => setAppLanguage(context, lang),
                            ),
                          ),
                        ],
                      ),


                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 32.0),
                      //   child: Container(
                      //     width: double.infinity,
                      //     height: 70.0,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(16.0),
                      //     ),
                      //     alignment: AlignmentDirectional(0.00, 0.00),
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(8.0),
                      //       child: Image.asset(
                      //         'assets/images/logo@3x.png',
                      //         width: 211.0,
                      //         height: 187.0,
                      //         fit: BoxFit.contain,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'ygpkfzvy' /* Welcome Back */,
                            ),
                            style: GoogleFonts.raleway(
                                fontSize: 22,
                                color: Color(0xff0A1310),
                                fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                            ),
                          ),
                          Text(
                            FFLocalizations.of(context).getText(
                              'if9a4fyq' /* Let's get started by filling o... */,
                            ),
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Color(0xff0A1310),
                                fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                            ),

                          ),
                          Form(
                            key: _model.formKey,
                            // autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Email",
                                  style: GoogleFonts.raleway(
                                      fontSize: 12,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: _model.emailController,
                                    focusNode: _model.emailFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.emailController',
                                      Duration(milliseconds: 5000),
                                          () => setState(() {}),
                                    ),
                                    autofillHints: [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(

                                      // labelText: 'Email',
                                      hintText: FFLocalizations.of(context).getText(
                                        'email_mobile_hint' /* Enter your email id/Mobile no. */,
                                      ),
                                      // hintText: 'Phone number',
                                      hintStyle:
                                      GoogleFonts.raleway(
                                          fontSize: 12,
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
                                    validator: _model.emailControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'bl0od0hs' /* Password */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 16.0),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: _model.passwordController,
                                    focusNode: _model.passwordFocusNode,
                                    autofillHints: [AutofillHints.password],
                                    obscureText: !_model.passwordVisibility,
                                    decoration: InputDecoration(
                                      // labelText: 'Email',
                                      hintText: FFLocalizations.of(context).getText(
                                        'password_hint' /* Enter your password */,
                                      ),
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
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                              () => _model.passwordVisibility =
                                          !_model.passwordVisibility,
                                        ),
                                        focusNode:
                                        FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.passwordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: Color(0xFF57636C),
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff1D1415),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                    ),
                                    validator: _model
                                        .passwordControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Password",
                                      style: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Colors.transparent,
                                          fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                      ),

                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     Helper.moveToScreenwithPush(context, ForgetPassword());
                                    //   },
                                    //   child: Text(
                                    //     "Forget Password",
                                    //     style: GoogleFonts.raleway(
                                    //         fontSize: 14,
                                    //         color: Color(0xff1D1415),
                                    //         fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                    //     ),
                                    //
                                    //   ),
                                    // ),
                                  ],
                                ),
                                FFButtonWidget(
                                  onPressed: (_model.emailController.text ==
                                      null ||
                                      _model.emailController.text ==
                                          '') &&
                                      valueOrDefault<bool>(
                                        _model.passwordController.text ==
                                            '',
                                        false,
                                      )
                                      ? null
                                      : () async {
                                    await LoginCall();

                                    _model.loginResponse =
                                    await BaseUrlGroup.loginCall
                                        .call(
                                      email:
                                      _model.emailController.text,
                                      password: _model
                                          .passwordController.text,
                                      deviceType: 'ios',
                                      deviceToken: deviceToken,
                                        login_type:( _model.emailController.text.contains('@'))?"1":"2",
                                    );
                                    if (BaseUrlGroup.loginCall.response(
                                      (_model.loginResponse?.jsonBody ??
                                          ''),
                                    )) {
                                      setState(() {
                                        FFAppState().UserId =
                                            BaseUrlGroup.loginCall
                                                .userid(
                                              (_model.loginResponse
                                                  ?.jsonBody ??
                                                  ''),
                                            )
                                                .toString();
                                        FFAppState().country_code =
                                            BaseUrlGroup.loginCall
                                                .country_code(
                                              (_model.loginResponse
                                                  ?.jsonBody ??
                                                  ''),
                                            )
                                                .toString();
                                      });
                                      if (Navigator.of(context)
                                          .canPop()) {
                                        context.pop();
                                      }
                                      context.pushNamed(
                                        'HomePage',
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey:
                                          TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                            PageTransitionType.fade,
                                            duration: Duration(
                                                milliseconds: 0),
                                          ),
                                        },
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Invalid credentials"),
                                        ),
                                      );
                                      // await showDialog(
                                      //   context: context,
                                      //   builder: (alertDialogContext) {
                                      //     return AlertDialog(
                                      //       title: Text('Notice'),
                                      //       content: Text(
                                      //           BaseUrlGroup.loginCall
                                      //               .message(
                                      //             (_model.loginResponse
                                      //                 ?.jsonBody ??
                                      //                 ''),
                                      //           )
                                      //               .toString()),
                                      //       actions: [
                                      //         TextButton(
                                      //           onPressed: () =>
                                      //               Navigator.pop(
                                      //                   alertDialogContext),
                                      //           child: Text('Ok'),
                                      //         ),
                                      //       ],
                                      //     );
                                      //   },
                                      // );
                                    }

                                    setState(() {});
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
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.4,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'or_text' /* OR */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        color:Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.4,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FFButtonWidget(
                              onPressed: () {
                                print('Button Pressed');
                                handelGoogleSignInNew();
                              },
                              text: FFLocalizations.of(context).getText(
                                'login_with_google' /* Login with Google */,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 46.0,
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterTheme.of(context).btnclr,
                                textStyle: GoogleFonts.raleway(
                                  fontSize: 16,
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                                elevation: 3.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.4,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'or_text' /* OR */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .bodyMedium
                                          .override(
                                        fontFamily: 'Poppins',
                                        color:Colors.grey,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.4,
                                      child: Divider(
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                FFButtonWidget(
                              onPressed: () {
                                print('Button Pressed');
                               Helper.moveToScreenwithPush(context, UserLoginUpdateWidget());
                              },
                              text: FFLocalizations.of(context).getText(
                                'login_with_otp' /* Login with OTP */,
                              ),
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 46.0,
                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                color: FlutterTheme.of(context).btnclr,
                                textStyle: GoogleFonts.raleway(
                                  fontSize: 16,
                                  color: Color(0xffFFFFFF),
                                  fontWeight: FontWeight.w400,
                                ),
                                elevation: 3.0,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),


                                SizedBox(
                                  height: MediaQuery.of(context).size.height*0.15,
                                ),


                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: AlignmentDirectional(0.00, 0.00),
                          //   child: Padding(
                          //     padding: EdgeInsetsDirectional.fromSTEB(
                          //         16.0, 0.0, 16.0, 24.0),
                          //     child: Text(
                          //       FFLocalizations.of(context).getText(
                          //         '7ida6i7p' /* Or sign up with */,
                          //       ),
                          //       textAlign: TextAlign.center,
                          //       style: FlutterTheme.of(context)
                          //           .labelMedium
                          //           .override(
                          //             fontFamily: 'Manrope',
                          //             color: FlutterTheme.of(context)
                          //                 .primaryText,
                          //             fontSize: 12.0,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //     ),
                          //   ),
                          // ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 20.0, 0.0, 4.0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'dont_have_account' /* Don't have an account? */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff0A1310),
                                      fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4.0, 20.0, 0.0, 4.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'signupPage',
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                          PageTransitionType.fade,
                                          duration: Duration(milliseconds: 2),
                                        ),
                                      },
                                    );
                                  },
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'ytqlordy' /* Sign up */,
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: FlutterTheme.of(context)
                                            .secondary,
                                        fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient

                                      // style: FlutterTheme.of(context)
                                      //     .bodyMedium
                                      //     .override(
                                      //   fontFamily: 'Manrope',
                                      //   color: FlutterTheme.of(context)
                                      //       .secondary,
                                      //   fontSize: 14.0,
                                      //   fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ].addToStart(SizedBox(height: 20.0)),
                  ),
                  // Positioned(
                  //   bottom: 40,
                  //   left: 20,
                  //   right: 20,
                  //   child:   Container(
                  //     width: double.infinity,
                  //     child: FFButtonWidget(
                  //     onPressed: (_model.emailController.text ==
                  //         null ||
                  //         _model.emailController.text ==
                  //             '') &&
                  //         valueOrDefault<bool>(
                  //           _model.passwordController.text ==
                  //               '',
                  //           false,
                  //         )
                  //         ? null
                  //         : () async {
                  //       await LoginCall();
                  //
                  //       _model.loginResponse =
                  //       await BaseUrlGroup.loginCall
                  //           .call(
                  //         email:
                  //         _model.emailController.text,
                  //         password: _model
                  //             .passwordController.text,
                  //         deviceType: 'ios',
                  //         deviceToken: deviceToken,
                  //       );
                  //       if (BaseUrlGroup.loginCall.response(
                  //         (_model.loginResponse?.jsonBody ??
                  //             ''),
                  //       )) {
                  //         setState(() {
                  //           FFAppState().UserId =
                  //               BaseUrlGroup.loginCall
                  //                   .userid(
                  //                 (_model.loginResponse
                  //                     ?.jsonBody ??
                  //                     ''),
                  //               )
                  //                   .toString();
                  //         });
                  //         if (Navigator.of(context)
                  //             .canPop()) {
                  //           context.pop();
                  //         }
                  //         context.pushNamed(
                  //           'HomePage',
                  //           extra: <String, dynamic>{
                  //             kTransitionInfoKey:
                  //             TransitionInfo(
                  //               hasTransition: true,
                  //               transitionType:
                  //               PageTransitionType.fade,
                  //               duration: Duration(
                  //                   milliseconds: 0),
                  //             ),
                  //           },
                  //         );
                  //       } else {
                  //         await showDialog(
                  //           context: context,
                  //           builder: (alertDialogContext) {
                  //             return AlertDialog(
                  //               title: Text('Notice'),
                  //               content: Text(
                  //                   BaseUrlGroup.loginCall
                  //                       .message(
                  //                     (_model.loginResponse
                  //                         ?.jsonBody ??
                  //                         ''),
                  //                   )
                  //                       .toString()),
                  //               actions: [
                  //                 TextButton(
                  //                   onPressed: () =>
                  //                       Navigator.pop(
                  //                           alertDialogContext),
                  //                   child: Text('Ok'),
                  //                 ),
                  //               ],
                  //             );
                  //           },
                  //         );
                  //       }
                  //
                  //       setState(() {});
                  //     },
                  //     text: FFLocalizations.of(context).getText(
                  //       'jvavrjuj' /* Login */,
                  //     ),
                  //     options: FFButtonOptions(
                  //       width: double.infinity,
                  //       height: 46.0,
                  //       padding:
                  //       EdgeInsetsDirectional.fromSTEB(
                  //           0.0, 0.0, 0.0, 0.0),
                  //       iconPadding:
                  //       EdgeInsetsDirectional.fromSTEB(
                  //           0.0, 0.0, 0.0, 0.0),
                  //       color: FlutterTheme.of(context).btnclr,
                  //       textStyle:
                  //       GoogleFonts.raleway(
                  //           fontSize: 16,
                  //           color: Color(0xffFFFFFF),
                  //           fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                  //       ),
                  //       elevation: 3.0,
                  //       borderRadius:
                  //       BorderRadius.circular(10.0),
                  //     ),
                  //
                  //
                  //
                  //     // FFButtonOptions(
                  //     //   width: 226.0,
                  //     //   height: 50.0,
                  //     //   padding: EdgeInsetsDirectional.fromSTEB(
                  //     //       24.0, 0.0, 24.0, 0.0),
                  //     //   iconPadding:
                  //     //       EdgeInsetsDirectional.fromSTEB(
                  //     //           0.0, 0.0, 0.0, 0.0),
                  //     //   color: Color(0xFF5C47A8),
                  //     //   textStyle: FlutterTheme.of(context)
                  //     //       .titleSmall
                  //     //       .override(
                  //     //         fontFamily: 'Urbanist',
                  //     //         color: Colors.white,
                  //     //       ),
                  //     //   elevation: 3.0,
                  //     //   borderSide: BorderSide(
                  //     //     color: Colors.transparent,
                  //     //     width: 1.0,
                  //     //   ),
                  //     //   borderRadius: BorderRadius.circular(8.0),
                  //     //   disabledColor:
                  //     //       FlutterTheme.of(context).accent3,
                  //     //   disabledTextColor:
                  //     //       FlutterTheme.of(context).black600,
                  //     // ),
                  //                         ),
                  //   ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setProgress(bool show)    {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
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

  Future<void> forgetpassword() async {
    print("<=============forgetpassword=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {

      'app_token': "booking12345",
      'email': _model.emailController.text.trim().toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.forgetuserpassword), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CommonModel model = CommonModel.fromJson(jsonResponse);

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

  Future<void> googleSigninApi(String google_id, String image, String email,
      String name) async {
    print("<============= googleSigninApi Api =============>");

    // setProgress(true);
    Map data = {
      'social_id': google_id.toString(),
      'social_type': "google",
      'device_token': deviceToken,
      'profile_image': image,
      'device_type': 'Android',
      'email': email,
      'user_type': "1",
      'user_name':name.toString(),
      "lastname":"",
      "code" : 'COURIERAPP-30062016',
      'app_token': "booking12345",
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.social_login), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          GoogleSignInModel model = GoogleSignInModel.fromJson(jsonResponse);

          if (model.result == "success") {
            // setProgress(false);

            print("=====helloo=======");

            ToastMessage.msg(model.message.toString());

            SessionHelper sessionHelper = await SessionHelper.getInstance(
                context);
            sessionHelper.put(
                SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(
                SessionHelper.IMAGE, model.data!.userProfilePic.toString());
            sessionHelper.put(
                SessionHelper.EMAIL, model.data!.email.toString());
            sessionHelper.put(
                SessionHelper.FIRSTNAME, model.data!.userName.toString());
            // sessionHelper.put(
            //     SessionHelper.LASTNAME, model.data!.lastname.toString());
            context.pushNamed(
              'HomePage',
              extra: <String, dynamic>{
                kTransitionInfoKey:
                TransitionInfo(
                  hasTransition: true,
                  transitionType:
                  PageTransitionType.fade,
                  duration: Duration(
                      milliseconds: 0),
                ),
              },
            );
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
            //     route) => true);
          }
          else {
            // setProgress(false);
            print("false ============>");
            Helper.checkInternet(googleSignupApi(google_id,image,email,name));
            // ToastMessage.msg(model.message.toString());
          }
        }
        catch (e) {
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
    // setProgress(false);
  }

  Future<Null> handelGoogleSignInNew() async   {
    // setProgress(true);

    print(
        "==========================googleLogin method Called==================================");

    GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    print("============Urvashi==========");

    if (googleUser != null) {
      final userData = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken,
          idToken: userData.idToken);

      User? firebaseUser = (await FirebaseAuth.instance.signInWithCredential(
          credential)).user;
      SharedPreferences sharedPreferences = await SharedPreferences
          .getInstance();
      print("google data==>${firebaseUser.toString()}");
      if (firebaseUser != null) {

        // final QuerySnapshot result =
        // await FirebaseFirestore.instance.collection('users').where(
        //     'id', isEqualTo: firebaseUser.uid).get();

        // final List<DocumentSnapshot> documents = result.docs;
        Helper.checkInternet(
            googleSigninApi(
              firebaseUser.uid,
              firebaseUser.photoURL.toString(),
              firebaseUser.email.toString(),
              firebaseUser.displayName.toString(),
            )
        );
        // if (documents.length == 0) {
        //
        //   print("if ==>first time");
        //
        //   Helper.checkInternet(
        //       googleSigninApi(
        //         firebaseUser.uid,
        //         firebaseUser.photoURL.toString(),
        //         firebaseUser.email.toString(),
        //         firebaseUser.displayName.toString(),
        //       )
        //   );
        //   // Update data to server if new user
        //   // FirebaseFirestore.instance.collection('users')
        //   //     .doc(firebaseUser.uid)
        //   //     .set({
        //   //   'nickname': firebaseUser.displayName,
        //   //   'email': firebaseUser.email,
        //   //   'photoUrl': firebaseUser.photoURL,
        //   //   'id': firebaseUser.uid,
        //   //   'createdAt': DateTime.now().toString(),
        //   //
        //   // });
        // }
        // else {
        //   print("else ==>not first time");
        //
        //
        //   Helper.checkInternet(
        //       googleSigninApi(
        //         firebaseUser.uid,
        //         firebaseUser.photoURL.toString(),
        //         firebaseUser.email.toString(),
        //         firebaseUser.displayName.toString(),
        //       )
        //   );
        //
        //
        // }

      }
      else {
        ToastMessage.msg("Sign in failed");
        // setProgress(false);
      }
    }
    else {
      ToastMessage.msg("Can not init google sign in");
      // setProgress(false);
    }
  }

  Future<void> phoneCheckWithFirebase() async{

    print("======================phoneCheckWithFirebase=====================");

    setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    // String phone =mobileNumber.text.trim().toString();
    String phone = "+"+"91" + "8718911737";
    // String phone = "+"+country_code + email.text.trim();
    print("phone in phoneCheckWithFirebase===>${phone.toString()}");
    //new code start
    // final _fireStore = FirebaseFirestore.instance;
    // QuerySnapshot querySnapshot = await _fireStore.collection('student_details').where("student_phone", isEqualTo: phone).get();
    // // final allData =
    // // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();


    await FirebaseAuth.instance.verifyPhoneNumber(
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
          // Helper.moveToScreenwithPush(context, OtploginScreenparcela(
          //   Mobilenumber: email.text.toString(),
          //   forceResendingToken: forceResendingToken,
          //
          //   verificationId: verificationId,
          //   // afterSignUp: true,countryCode: countryCode.toString(),
          //   afterSignUp: true,countryCode: "+91", firstname: '', lastname: '', password: '', phonenumber: '', userTypes: '', company_name: '',
          //   email: '', image: '', address: '', postal_code: '', devicetoken: '', whichscreen: '', data: '',
          // ));
          // Helper.checkInternet(loginApi(verificationId, forceResendingToken));
          // if (_image == null) {
          //   print("=====================================3================================");
          //   print("Api called without Image");
          //   Helper.checkInternet(SignupApi(verificationId, forceResendingToken));
          // } else {
          //   print("Api called with Image");
          //   Helper.checkInternet(Signupapiwithimage(_image!.path,verificationId, forceResendingToken));
          // }

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
    //
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

  Future<void> googleSignupApi(String google_id, String image, String email, String name) async {
    print("<============= googleSignupApi Api =============>");
    // $user_name  = $_POST['user_name'];
    // $email      = $_POST['email'];
    //
    // $device_token = $_POST['device_token'];
    // $social_type=  $_POST['social_type'];
    // $social_id   = $_POST['social_id'];
    //
    //
    // profile_image
    // app_token
    setProgress(true);
    Map data = {
      'social_id': google_id.toString(),
      'social_type': "google",
      'device_token': deviceToken,
      'profile_image': image,
      'device_type': 'Android',
      'email': email,
       'user_type': "1",
      'user_name':name.toString(),
      "lastname":"",
      "code" : 'COURIERAPP-30062016',
      'app_token': "booking12345",
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.social_registration), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          SignupGoogle model = SignupGoogle.fromJson(jsonResponse);

          if (model.result == "success") {
            ToastMessage.msg(model.message.toString());

            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.IMAGE, model.data!.profileImage.toString());
            sessionHelper.put(SessionHelper.EMAIL, model.data!.email.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.firstname.toString());
            sessionHelper.put(SessionHelper.LASTNAME, model.data!.lastname.toString());
            setProgress(false);
            context.pushNamed(
              'HomePage',
              extra: <String, dynamic>{
                kTransitionInfoKey:
                TransitionInfo(
                  hasTransition: true,
                  transitionType:
                  PageTransitionType.fade,
                  duration: Duration(
                      milliseconds: 0),
                ),
              },
            );
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
            //     route) => true);

          } else {
            setProgress(false);
            print("false ============>");
            ToastMessage.msg(model.message.toString());
          }
        } catch (e) {
          setProgress(false);
          print("false ============>");
          ToastMessage.msg(StaticMessages.API_ERROR);
          print('exception ==> ' + e.toString());
        }
      } else {
        setProgress(false);
        print("status code ==> " + res.statusCode.toString());
        ToastMessage.msg(StaticMessages.API_ERROR);
      }
    } catch (e) {
      setProgress(false);
      ToastMessage.msg(StaticMessages.API_ERROR);
      print('Exception ======> ' + e.toString());
    }
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

      SessionHelper sessionHelper = await SessionHelper.getInstance(context);
      sessionHelper.put(SessionHelper.LATITUDE,position.latitude.toString());
      sessionHelper.put(SessionHelper.LONGITUDE,  position.longitude.toString());

      print('Current Position: ${globalLatitude}, ${globalLongitude}');

      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        startLocation = LatLng(position.latitude, position.longitude);
        print("====startLocation=====${startLocation}");

        // location = placemarks.first.street.toString() +
        //     ", " +
        //     placemarks.first.subLocality.toString() +
        //     ", " +
        //     placemarks.first.administrativeArea.toString();
        // _isVisiblenew = true;
        // setProgress(false);
        // print("=====location======${location}");
      });
    } catch (e) {
      print("Error getting current location: $e");
      // Handle error or provide user feedback.
    }
  }
}
