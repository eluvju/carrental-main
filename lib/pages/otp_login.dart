import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:car_rental/flutter/flutter_util.dart';
import 'package:http/http.dart'as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../constant.dart';
import '../flutter/flutter_theme.dart';
import '../flutter/flutter_widgets.dart';
import '../model/mobile_verify_otp.dart';


class OtploginScreenparcela extends StatefulWidget {
  String Mobilenumber = '';
  String verificationId;
  bool afterSignUp;
  int? forceResendingToken;
  String countryCode = '';
  String firstname = "";
  String lastname;
  String password ="";
  String phonenumber ="";
  String userTypes ="";
  String company_name ="";
  String email ="";
  String image ="";
  String address ="";
  String postal_code ="";
  String whichscreen ="";
  String devicetoken ="";
  dynamic pick_lat ;
  dynamic pick_long ;
  String data ="";

  OtploginScreenparcela({
    required this.Mobilenumber,required this.forceResendingToken, required this.verificationId,
    required this.afterSignUp,required this.whichscreen,
    required this.countryCode,required this.firstname, required this.lastname, required this.password,
    required this.phonenumber,required this.userTypes,required this.company_name,required this.email,
    required this.image,required this.address,this.pick_long,this.pick_lat,required this.postal_code,required this.devicetoken,
    required this.data,
  });

  @override
  State<OtploginScreenparcela> createState() => _OtploginScreenparcelaState();
}

class _OtploginScreenparcelaState extends State<OtploginScreenparcela> {
  bool _isVisible = false;
  bool _hashData = false;
  String deviceToken="";
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  OtpTimerButtonController controller = OtpTimerButtonController();

  String _otp = '';
  Timer? _timer;
  int _start = 120;
  bool resend_visible=false;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            resend_visible=true;
            timer.cancel();

          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    verifyOTP();
    // autofillOTP("123456");
    print("Mobilenumber===>${widget.Mobilenumber.toString()}");
    print("countryCode===>${widget.countryCode.toString()}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 16,right: 16, top:120),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(8.0),
                        //   child: Image.asset(
                        //     'assets/images/Frame_113.png',
                        //     width: 194.98,
                        //     height: 51.0,
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      ]
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,),
                        child: Text('ENTER OTP',
                          style: GoogleFonts.raleway(
                              fontSize: 22,
                              color: Color(0xff0A1310),
                              fontWeight: FontWeight.w700 // Ensure the text is visible over the gradient
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Pinput(
                        controller: otpController,
                        length: 6,
                        forceErrorState: false,
                        errorText: '',
                        defaultPinTheme: PinTheme(
                            height: 45,
                            width: 45,
                            textStyle: TextStyle(color:  Color(0xFF1344D7),fontSize: 22),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.black,width: 2)
                            )
                        ),
                        validator: (pin) {
                          if (pin!.length > 6) return null;//4
                          /// Text will be displayed under the Pinput
                          return 'Pin is incorrect';
                        },
                      ),
                    ),
                    SizedBox(height: 50,),
                    Center(
                      child: FFButtonWidget(
                        onPressed: () async {

                          if (widget.Mobilenumber.contains('@')) {
                            // Perform phone number check with Firebase
                             Helper.checkInternet(otp_verify());

                             // Helper.checkInternet(loginApi("1"));

                          } else {
                            // Helper.checkInternet(loginApi("2"));
                             otpVerificationFirebase();

                            // Move to another screen with certain parameters
                          }

                        },
                        text: "Proceed",
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
                      ),
                    ),
                    widget.Mobilenumber.contains('@')?SizedBox():
                    Column(
                      children: [
                        Center(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('OTP expires in :',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),),
                                Text('${(_start/60).floor()}'.padLeft(2, '0')+':'+'${_start%60}'.padLeft(2, '0') + "${" mins"}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),)
                              ],
                            )
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                            onTap:_start==0
                                ? (){
                              print("");
                              _start=120;
                              resendVerificationCode("+"+widget.countryCode.toString()+widget.Mobilenumber.toString(), widget.forceResendingToken);
                            }:null,
                            child: Center(child:
                            Text('Resend OTP',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,
                                  color: _start==0?Colors.black:Colors.grey
                              ),


                            ))),
                      ],
                    ),
                    // SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    // Center(
                    //     child:
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text('OTP expires in :',style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),),
                    //         Text('${(_start/60).floor()}'.padLeft(2, '0')+':'+'${_start%60}'.padLeft(2, '0') + "${" mins"}",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 18),)
                    //       ],
                    //     )
                    // ),
                    // SizedBox(height: 20,),
                    // InkWell(
                    //     onTap:_start==0
                    //         ? (){
                    //       print("");
                    //       _start=120;
                    //       resendVerificationCode("+"+widget.countryCode.toString()+widget.Mobilenumber.toString(), widget.forceResendingToken);
                    //     }:null,
                    //     child: Center(child:
                    //     Text('Resend OTP',
                    //       style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 20,
                    //           color: _start==0?Colors.black:Colors.grey
                    //       ),
                    //
                    //
                    //     ))),
                  ],
                ),
              ),
            ),
          ),
          Helper.getProgressBarWhite(context, _isVisible)
        ],
      ),
    );
  }

  void autofillOTP(String otp) {
    otpController.text = otp;
  }
  void verifyOTP() {
    // Assume this method initiates OTP verification and returns the OTP value
    String otp =otpController.text; // Replace "123456" with the actual OTP received
    // String otp ="123456"; // Replace "123456" with the actual OTP received
    autofillOTP(otp); // Call autofillOTP with the received OTP value
  }
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> phoneCheckWithFirebase() async{

    print("======================phoneCheckWithFirebase=====================");

    setProgress(true);
    //firebase otp code
    // String phone = "+" + countryCodeCreated + phoneController.text.trim();
    // String phone =mobileNumber.text.trim().toString();
    String phone = "+"+"91" +  widget.Mobilenumber.trim();
    print("phone in phoneCheckWithFirebase===>${phone.toString()}");
    //new code start
    final _fireStore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await _fireStore.collection('student_details').where("student_phone", isEqualTo: phone).get();
    // final allData =
    // querySnapshot.docs.map((doc) => doc.get('phone')).toList();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (allData.length==0) {
      //new code end
      //firebase otp code
      // String phone = "+" + countryCodeCreated + phoneController.text.trim();
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
            //   Mobilenumber: widget.Mobilenumber.toString(),
            //   forceResendingToken: forceResendingToken,
            //
            //   verificationId: verificationId,
            //   // afterSignUp: true,countryCode: countryCode.toString(),
            //   afterSignUp: true,countryCode: "+91",
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
      //firebase otp code end
      //firebase otp code end
    }
    else{
      FirebaseAuth.instance.signOut();
      ToastMessage.msg("Phone number already registered, Please sign in");
      // Fluttertoast.showToast( msg:"");
      setProgress(false);
    }
  }
  Future<void> firebase_otp_verify() async {


    print("<=============firebase_otp_verify=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'code':"COURIERAPP-30062016",
      'phone':widget.Mobilenumber,
      'app_token':'booking12345'
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.mobile_verify), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          MobileveriftModelotp model = MobileveriftModelotp.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");

            setProgress(false);
            FFAppState().UserId=model.data!.userId.toString();
            print("successs==============");
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.username.toString());
            sessionHelper.put(SessionHelper.EMAIL, model.data!.email.toString());
            // sessionHelper.put(SessionHelper.IMAGE, model.data!.profileImage.toString());
            sessionHelper.put(SessionHelper.PHONE, model.data!.contact.toString());
            sessionHelper.put(SessionHelper.COUNTRY, model.data!.countryCode.toString());
            // sessionHelper.put(SessionHelper.COMPANY_NAME, model.data!.companyName.toString());

            // print("country_code==============${country_code}");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(builder: (context) => PriceCalculationLocation(
            //       callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)),
            //         (route) => true
            // );
            // Helper.checkInternet(loginApi('',0));

            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
            //     route) => true);


            // Helper.moveToScreenwithPush(context, RegisterUserAddressPageWidget(firstname: first_name_controller.text.toString(),
            //   lastname: last_name_controller.text.toString(), password: password_controller.text.toString(),
            //   phonenumber: phone_number_controller.text.toString(), userTypes: widget.user_type.toString(), company_name: company_name_controller.text.toString(),
            //   email:email_controller==""?"":email_controller.text.trim().toString(), image:_image==null?"":_image!.path, address: '', postal_code: '',));


            // context.pushNamed(
            //   'RegisterUserAddressPage',
            //   queryParameters: {
            //     'userTypes': serializeParam(
            //       widget.userType,
            //       ParamType.Enum,
            //     ),
            //   }.withoutNulls,
            // );
            //  ToastMessage.msg(model.message.toString());
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => BottomNavBar()), (
            //     route) => false);

            context.goNamed(
              'HomePage',
              extra: <String, dynamic>{
                kTransitionInfoKey:
                TransitionInfo(
                  hasTransition: true,
                  transitionType:
                  PageTransitionType
                      .fade,
                  duration: Duration(
                      milliseconds: 0),
                ),
              },
            );

          }
          else {
            setProgress(false);
            print("false ### ============>");
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

            // Helper.moveToScreenwithPush(context, SignUpWidget(Mobilenumber: widget.Mobilenumber, email:'', country_code: widget.countryCode.toString(),));
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
            // ToastMessage.msg(model.message.toString());
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


  Future<void> otp_verify() async {


    print("<=============checkApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'code':"COURIERAPP-30062016",
      'type':widget.data.toString(),
      'otp':otpController.text.toString(),
      'user_type':"1",
      'email':widget.email.toString(),
      'app_token':'booking12345'
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.otp_verify), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          MobileveriftModelotp model = MobileveriftModelotp.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");

            setProgress(false);
            FFAppState().UserId=model.data!.userId.toString();
            print("successs==============");
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, model.data!.userId.toString());
            sessionHelper.put(SessionHelper.FIRSTNAME, model.data!.username.toString());
            sessionHelper.put(SessionHelper.EMAIL, model.data!.email.toString());
            // sessionHelper.put(SessionHelper.IMAGE, model.data!.profileImage.toString());
            sessionHelper.put(SessionHelper.PHONE, model.data!.contact.toString());
            // sessionHelper.put(SessionHelper.COUNTRY, model.data!.co.toString());
            // sessionHelper.put(SessionHelper.COMPANY_NAME, model.data!.companyName.toString());


            widget.data=="0"?

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
            ):
            context.goNamed(
              'HomePage',
              extra: <String, dynamic>{
                kTransitionInfoKey:
                TransitionInfo(
                  hasTransition: true,
                  transitionType:
                  PageTransitionType
                      .fade,
                  duration: Duration(
                      milliseconds: 0),
                ),
              },
            );

            //
            // Navigator.pushAndRemoveUntil(
            //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
            //     route) => true):Helper.moveToScreenwithPush(context,
            //     SignUpWidget(Mobilenumber: '', email: widget.email.toString(), country_code: '',));






          }
          else {
            setProgress(false);
            print("false ### ============>");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(model.message.toString()),
              ),
            );
            // ToastMessage.msg(model.message.toString());
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




  Future<void> otpVerificationFirebase() async {
    print("otpVerification===firebase");
    setProgress(true);
    log("otpVerification firebase api calling");
    String otp = otpController.text.trim();
    log("otp=============>$otp");

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    );

    print("sms code 1==>${credential.smsCode.toString()}");
    log("widget.verificationId===============>${widget.verificationId}");
    log("widget.phone===============>${widget.Mobilenumber}");
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        //setProgress(false);
        if (widget.afterSignUp == true) {
          print("sms code 2==>${credential.smsCode.toString()}");
          var userDeatils = FirebaseAuth.instance.currentUser;
          userDeatils!.updatePhoneNumber(credential).toString();
          print("hello======1");
          Helper.checkInternet(firebase_otp_verify());

          // Helper.checkInternet(loginApi());
          //userDeatils.updateEmail(widget.email).toString();
          //userDeatils.updateDis3playName(widget.name).toString();
          // Navigator.pushAndRemoveUntil(
          //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
          //     route) => true);
          // Fluttertoast.showToast(msg: "Login successful");

           // Helper.checkInternet( OtpApi());
        } else {
          print("hello======2");
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (context) => PriceCalculationLocation(
          //       callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)),
          //         (route) => true
          // );
          // Helper.checkInternet(loginApi());
          // Navigator.pushAndRemoveUntil(
          //     context, MaterialPageRoute(builder: (context) => PriceCalculationLocation(callback: (String, Lat, long, lat2, long2, lat3, long3) {  },)), (
          //     route) => true);
          // Fluttertoast.showToast(msg: "login successfully");
          // Helper.moveToScreenwithPushreplaceemt(context, LoginScreen());
        }
      }
    } on FirebaseAuthException catch (ex) {
      setProgress(false);
      log("exception 1===>${ex.code.toString()}");
      ToastMessage.msg(ex.code.toString());
    }
  }
  void resendVerificationCode(String phoneNumber, int? token) async{
    print("resendVerificationCode");
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) {
          setProgress(false);
        },
        verificationFailed: (ex) {
          log(ex.code.toString());
          setProgress(false);
        },
        codeSent: (verificationId, forceResendingToken) {
          print("codeSent");
          setProgress(false);
          otpVerificationFirebase();
        },
        forceResendingToken:token,

        codeAutoRetrievalTimeout: (verificationId) {
          setProgress(false);
        },

        timeout: Duration(seconds: 120)
    );

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



}

class OtpTimerButtonController {
  late VoidCallback _startTimerListener;
  late VoidCallback _loadingListener;
  late VoidCallback _enableButtonListener;

  _addListeners(startTimerListener, loadingListener, enableButtonListener) {
    this._startTimerListener = startTimerListener;
    this._loadingListener = loadingListener;
    this._enableButtonListener = enableButtonListener;
  }

  /// Notify listener to start the timer
  startTimer() {
    _startTimerListener();
  }

  /// Notify listener to show loading
  loading() {
    _loadingListener();
  }

  /// Notify listener to enable button
  enableButton() {
    _enableButtonListener();
  }




}
