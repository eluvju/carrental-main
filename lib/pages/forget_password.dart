import 'dart:convert';

import 'package:car_rental/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import '../flutter/flutter_theme.dart';
import '../flutter/flutter_widgets.dart';
import '../flutter/internationalization.dart';
import '../model/common_model.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isVisible = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController email_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Helper.popScreen(context);
                },
                child: Container(
                    height: 25,
                    width: 25,
                    child: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
               "Forget Password",
                style: GoogleFonts.raleway(
                    fontSize: 22,
                    color: Color(0xff0A1310),
                    fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                ),
              ),
              Form(
                key:_formKey,
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
                        controller: email_controller,
                        // focusNode: _model.emailFocusNode,
                        autofillHints: [AutofillHints.email],
                        obscureText: false,
                        decoration: InputDecoration(

                          // labelText: 'Email',
                          hintText: 'Enter your email i’d',
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
                        // validator: _model.emailControllerValidator
                        //     .asValidator(context),
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(
                    //       0.0, 0.0, 0.0, 16.0),
                    //   child: TextFormField(
                    //     autovalidateMode: AutovalidateMode.onUserInteraction,
                    //     controller: _model.passwordController,
                    //     focusNode: _model.passwordFocusNode,
                    //     autofillHints: [AutofillHints.password],
                    //     obscureText: !_model.passwordVisibility,
                    //     decoration: InputDecoration(
                    //       // labelText: 'Email',
                    //       hintText: 'Enter your password',
                    //       // hintText: 'Phone number',
                    //       hintStyle:
                    //       GoogleFonts.raleway(
                    //           fontSize: 14,
                    //           color: Color(0xff7C8BA0),
                    //           fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                    //       ),
                    //
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(
                    //           color: Color(0xFFF7C8BA0),
                    //           width: 1.0,
                    //         ),
                    //         borderRadius:
                    //         BorderRadius.circular(8.0),
                    //       ),
                    //       focusedBorder:  OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: Color(0xFFF7C8BA0),
                    //             width: 1.0,
                    //           )),
                    //       errorBorder: OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: Color(0xFFF7C8BA0),
                    //             width: 1.0,
                    //           )),
                    //       focusedErrorBorder:
                    //       OutlineInputBorder(
                    //           borderSide: BorderSide(
                    //             color: Color(0xFFF7C8BA0),
                    //             width: 1.0,
                    //           )),
                    //       contentPadding: EdgeInsets.all(8.0),
                    //       suffixIcon: InkWell(
                    //         onTap: () => setState(
                    //               () => _model.passwordVisibility =
                    //           !_model.passwordVisibility,
                    //         ),
                    //         focusNode:
                    //         FocusNode(skipTraversal: true),
                    //         child: Icon(
                    //           _model.passwordVisibility
                    //               ? Icons.visibility_outlined
                    //               : Icons.visibility_off_outlined,
                    //           color: Color(0xFF57636C),
                    //           size: 22.0,
                    //         ),
                    //       ),
                    //     ),
                    //     style: GoogleFonts.raleway(
                    //         fontSize: 14,
                    //         color: Color(0xff1D1415),
                    //         fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                    //     ),
                    //     validator: _model
                    //         .passwordControllerValidator
                    //         .asValidator(context),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       "Password",
                    //       style: GoogleFonts.raleway(
                    //           fontSize: 14,
                    //           color: Colors.transparent,
                    //           fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                    //       ),
                    //
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Helper.checkInternet(forgetpassword());
                    //       },
                    //       child: Text(
                    //         "Forget Password",
                    //         style: GoogleFonts.raleway(
                    //             fontSize: 14,
                    //             color: Color(0xff1D1415),
                    //             fontWeight: FontWeight.w400 // Ensure the text is visible over the gradient
                    //         ),
                    //
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),

                    FFButtonWidget(
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
              onPressed: () {

          if (email_controller.text == "") {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Enter email '),
              ),
            );
          }
          else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
              .hasMatch(email_controller.text)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Enter valid email '),
              ),
            );
          } else {
            HelperClass.checkInternet(forgetpassword());
          }

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
              }),
                  ],
                ),
              ),
            ],
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
  Future<void> forgetpassword() async {
    print("<=============forgetpassword=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {

      'app_token': "booking12345",
      'email': email_controller.text.trim().toString(),
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
}
