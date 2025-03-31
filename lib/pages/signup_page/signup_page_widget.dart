// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:country_picker/country_picker.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/flutter_language_selector.dart';
import '../../constant.dart';
import '../../model/register_model.dart';
import 'signup_page_model.dart';

export 'signup_page_model.dart';

class SignupPageWidget extends StatefulWidget {
  const SignupPageWidget({Key? key}) : super(key: key);

  @override
  _SignupPageWidgetState createState() => _SignupPageWidgetState();
}

class _SignupPageWidgetState extends State<SignupPageWidget> {
  late SignupPageModel _model;
  bool _isVisible = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  String deviceToken = "";
  String _countryCode = "";

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupPageModel());

    _model.emailController ??= TextEditingController();
    _model.emailFocusNode ??= FocusNode();

    _model.fullNameController ??= TextEditingController();
    _model.fullNameFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.confirmPasswordController ??= TextEditingController();
    _model.confirmPasswordFocusNode ??= FocusNode();

    _model.phoneNumberController ??= TextEditingController();
    _model.phoneNumberFocusNode ??= FocusNode();

    // FirebaseMessaging.instance.requestPermission().then((_) =>
    //
    //     getDeviceTokenToSendNotification());
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
        // backgroundColor: FlutterTheme.of(context).plumpPurple,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Helper.popScreen(context);
                        },
                        child: Container(
                            height: 25,
                            width: 25,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.black,
                            )),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        FFLocalizations.of(context).getText(
                          '0p0b9pfj' /* create */,
                        ),
                        style: GoogleFonts.raleway(
                            fontSize: 22,
                            color: Color(0xff0A1310),
                            fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                            ),
                      ),
                      // Container(
                      //   width: double.infinity,
                      //   height: 83.0,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(16.0),
                      //   ),
                      //   alignment: AlignmentDirectional(0.00, 0.00),
                      //   child: Text(
                      //     FFLocalizations.of(context).getText(
                      //       '0p0b9pfj' /* Create a
                      //           new account
                      //            */
                      //       ,
                      //     ),
                      //     style:
                      //         FlutterTheme.of(context).displaySmall.override(
                      //               fontFamily: 'Urbanist',
                      //               fontSize: 32.0,
                      //             ),
                      //   ),
                      // ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            FFLocalizations.of(context).getText(
                              '89k4l8jl' /* Create a new account and start
                              car rental with ease */
                              ,
                            ),
                            style: GoogleFonts.raleway(
                                fontSize: 16,
                                color: Color(0xff0A1310),
                                fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                ),
                          ),
                          // Text(
                          //   FFLocalizations.of(context).getText(
                          //     '89k4l8jl' /* Enter your complete details to... */,
                          //   ),
                          //   textAlign: TextAlign.start,
                          //   style: FlutterTheme.of(context)
                          //       .labelMedium
                          //       .override(
                          //         fontFamily: 'Manrope',
                          //         color: Color(0xFF57636C),
                          //         fontSize: 12.0,
                          //         fontWeight: FontWeight.w500,
                          //       ),
                          // ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _model.formKey,
                            // autovalidateMode: AutovalidateMode.always,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'email_label' /* Email */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
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
                                      hintText: FFLocalizations.of(context).getText(
                                        'enter_email_hint' /* Enter your email id */,
                                      ),
                                      hintStyle: GoogleFonts.raleway(
                                          fontSize: 12,
                                          color: Color(0xff7C8BA0),
                                          fontWeight: FontWeight.w400
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF7C8BA0),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff7C8BA0),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),
                                    validator: _model.emailControllerValidator.asValidator(context),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'full_name_label' /* Full Name */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: _model.fullNameController,
                                    focusNode: _model.fullNameFocusNode,
                                    onChanged: (_) => EasyDebounce.debounce(
                                      '_model.emailController',
                                      Duration(milliseconds: 5000),
                                      () => setState(() {}),
                                    ),
                                    autofillHints: [AutofillHints.email],
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: FFLocalizations.of(context).getText(
                                        'enter_full_name_hint' /* Enter your full name */,
                                      ),
                                      hintStyle: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Color(0xff7C8BA0),
                                          fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF7C8BA0),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff7C8BA0),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),
                                    keyboardType: TextInputType.name,
                                    validator: _model.fullNameControllerValidator.asValidator(context),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'phone_number_label' /* Phone Number */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          showCountryPicker(
                                            context: context,
                                            exclude: <String>['KN', 'MF'],
                                            favorite: <String>['SE'],
                                            showPhoneCode: true,
                                            onSelect: (Country country) {
                                              print('Select country: ${country}');
                                              print('Select country ${country.countryCode}');
                                              setState(() {
                                                _countryCode = '+' + country.phoneCode;
                                              });
                                            },
                                            countryListTheme: CountryListThemeData(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(40.0),
                                                topRight: Radius.circular(40.0),
                                              ),
                                              inputDecoration: InputDecoration(
                                                labelText: 'Search',
                                                hintText: 'Start typing to search',
                                                prefixIcon: const Icon(Icons.search),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 48,
                                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xFFF7C8BA0),
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(8.0),
                                          ),
                                          child: Text(
                                            _countryCode.isNotEmpty ? _countryCode : '+1', // Default country code
                                            style: GoogleFonts.outfit(
                                              fontSize: 14,
                                              color: Color(0xff7C8BA0),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Flexible(
                                        child: TextFormField(
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          controller: _model.phoneNumberController,
                                          focusNode: _model.phoneNumberFocusNode,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText: FFLocalizations.of(context).getText(
                                              'enter_phone_number_hint' /* Enter your phone number */,
                                            ),
                                            hintStyle: GoogleFonts.raleway(
                                              fontSize: 14,
                                              color: Color(0xff7C8BA0),
                                              fontWeight: FontWeight.w400,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF7C8BA0),
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF7C8BA0),
                                                width: 1.0,
                                              ),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF7C8BA0),
                                                width: 1.0,
                                              ),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFF7C8BA0),
                                                width: 1.0,
                                              ),
                                            ),
                                            contentPadding: EdgeInsets.all(8.0),
                                          ),
                                          style: GoogleFonts.outfit(
                                            fontSize: 14,
                                            color: Color(0xff7C8BA0),
                                            fontWeight: FontWeight.w400,
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: _model.phoneNumberControllerValidator.asValidator(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'password_label' /* Password */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: _model.passwordController,
                                    focusNode: _model.passwordFocusNode,
                                    obscureText: !_model.passwordVisibility,
                                    autofillHints: [AutofillHints.password],
                                    decoration: InputDecoration(
                                      hintText: FFLocalizations.of(context).getText(
                                        'enter_password_hint' /* Enter your password */,
                                      ),
                                      hintStyle: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Color(0xff7C8BA0),
                                          fontWeight: FontWeight.w400
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF7C8BA0),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      suffixIcon: InkWell(
                                          onTap: () => setState(
                                                () => _model.passwordVisibility = !_model.passwordVisibility,
                                              ),
                                          focusNode: FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterTheme.of(context).black600,
                                            size: 22.0,
                                          )),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff7C8BA0),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),
                                    validator: _model.confirmPasswordControllerValidator.asValidator(context),
                                  ),
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    'confirm_password_label' /* Confirm Password */,
                                  ),
                                  style: GoogleFonts.raleway(
                                      fontSize: 14,
                                      color: Color(0xff1D1415),
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    controller: _model.confirmPasswordController,
                                    focusNode: _model.confirmPasswordFocusNode,
                                    obscureText: !_model.confirmPasswordVisibility,
                                    autofillHints: [AutofillHints.password],
                                    decoration: InputDecoration(
                                      hintText: FFLocalizations.of(context).getText(
                                        'enter_confirm_password_hint' /* Enter your confirm password */,
                                      ),
                                      hintStyle: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Color(0xff7C8BA0),
                                          fontWeight: FontWeight.w400
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFF7C8BA0),
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                        color: Color(0xFFF7C8BA0),
                                        width: 1.0,
                                      )),
                                      suffixIcon: InkWell(
                                        onTap: () => setState(
                                          () => _model.confirmPasswordVisibility = !_model.confirmPasswordVisibility,
                                        ),
                                        focusNode: FocusNode(skipTraversal: true),
                                        child: Icon(
                                          _model.confirmPasswordVisibility
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: FlutterTheme.of(context).black600,
                                          size: 22.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(8.0),
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff7C8BA0),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),
                                    validator: _model.confirmPasswordControllerValidator.asValidator(context),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.1,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                  child: FFButtonWidget(
                                    onPressed: () {
                                      if (_model.emailController.text == '') {
                                        return false;
                                      } else if (_model.fullNameController.text == '') {
                                        return true;
                                      } else if (_model.phoneNumberController.text == '') {
                                        return true;
                                      } else if (_model.passwordController.text == '') {
                                        return true;
                                      } else if (_model.confirmPasswordController.text == '') {
                                        return true;
                                      } else if ((/* NOT RECOMMENDED */ _model.fullNameController.text == 'true') ||
                                          (/* NOT RECOMMENDED */ _model.confirmPasswordController.text == 'true')) {
                                        return true;
                                      } else {
                                        return (_model.emailController.text == '');
                                      }
                                    }()
                                        ? null
                                        : () async {
                                            _model.signupResponse = await BaseUrlGroup.registerCall.call(
                                              email: _model.emailController.text,
                                              password: _model.confirmPasswordController.text,
                                              userName: _model.fullNameController.text,
                                              contact: _model.phoneNumberController.text,
                                              deviceType: 'gfsdgdsg',
                                              deviceToken: deviceToken,
                                              country_code: _countryCode,
                                            );
                                            if (BaseUrlGroup.registerCall.response(
                                              (_model.signupResponse?.jsonBody ?? ''),
                                            )) {
                                              context.goNamed(
                                                'HomePage',
                                                extra: <String, dynamic>{
                                                  kTransitionInfoKey: TransitionInfo(
                                                    hasTransition: true,
                                                    transitionType: PageTransitionType.fade,
                                                    duration: Duration(milliseconds: 0),
                                                  ),
                                                },
                                              );

                                              setState(() {
                                                FFAppState().UserId = BaseUrlGroup.registerCall
                                                    .userid(
                                                      (_model.signupResponse?.jsonBody ?? ''),
                                                    )
                                                    .toString();
                                                FFAppState().country_code = BaseUrlGroup.registerCall
                                                    .country_code(
                                                      (_model.signupResponse?.jsonBody ?? ''),
                                                    )
                                                    .toString();
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    BaseUrlGroup.registerCall
                                                        .message(
                                                          (_model.signupResponse?.jsonBody ?? ''),
                                                        )
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: FlutterTheme.of(context).primaryBtnText,
                                                    ),
                                                  ),
                                                  duration: Duration(milliseconds: 4000),
                                                  backgroundColor: FlutterTheme.of(context).secondary,
                                                  action: SnackBarAction(
                                                    label: 'Okay',
                                                    onPressed: () async {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: Text('Notice'),
                                                            content: Text(BaseUrlGroup.registerCall
                                                                .message(
                                                                  (_model.signupResponse?.jsonBody ?? ''),
                                                                )
                                                                .toString()),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                child: Text('Ok'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }

                                            setState(() {});
                                          },
                                    text: FFLocalizations.of(context).getText(
                                      'get_started_button' /* Get Started */,
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
                                          fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                          ),
                                      elevation: 3.0,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              context.safePop();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'k5tkrarf' /* Already have an account?  */,
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: Color(0xff0A1310),
                                        fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 4.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'e2zk3fd9' /* Sign In */,
                                    ),
                                    style: GoogleFonts.raleway(
                                        fontSize: 14,
                                        color: FlutterTheme.of(context).secondary,
                                        fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future<void> getDeviceTokenToSendNotification() async {
  //   print("getDeviceTokenToSendNotification");
  //   try{
  //     final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  //     final token = await _fcm.getToken();
  //
  //     deviceToken = token.toString();
  //     setState(() {
  //       deviceToken = token.toString();
  //     });
  //     print("Token Value $deviceToken");
  //   } catch (e) {
  //
  //     print('exception in getting token ==> '+ e.toString());
  //   }
  //
  //
  // }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> SignupApi() async {
    print("<=============SignupApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'email': _model.emailController.text.trim().toString(),
      'password': _model.passwordController.text.trim().toString(),
      'device_type': "android",
      'device_token': "cgdhjgvj",
      'user_name': _model.fullNameController.text.trim().toString(),
      'app_token': "booking12345",
      'user_type': "1",
      'contact': _model.phoneNumberController.text.trim().toString(),
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.newregister), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          RegisterModel model = RegisterModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.userName.toString());
            sessionHelper.put(SessionHelper.USERTYPE, model.data!.userType.toString());
            sessionHelper.put(SessionHelper.EMAIL, model.data!.email.toString());
            setProgress(false);

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            context.goNamed(
              'HomePage',
              extra: <String, dynamic>{
                kTransitionInfoKey: TransitionInfo(
                  hasTransition: true,
                  transitionType: PageTransitionType.fade,
                  duration: Duration(milliseconds: 0),
                ),
              },
            );
            // context.pushNamed(
            //   'ConfirmationPage',
            //   queryParameters: {
            //     'userType': serializeParam(
            //       UserRole.user,
            //       ParamType.Enum,
            //     ),
            //   }.withoutNulls,
            // ).then((_) {
            //   Navigator.popUntil(context, (route) => route.isFirst);
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
}
