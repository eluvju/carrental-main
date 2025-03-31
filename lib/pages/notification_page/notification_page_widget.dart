import '../../constant.dart';
import '../../model/notification_model.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'notification_page_model.dart';
export 'notification_page_model.dart';
import 'package:http/http.dart'as http;

class NotificationPageWidget extends StatefulWidget {
  const NotificationPageWidget({Key? key}) : super(key: key);

  @override
  _NotificationPageWidgetState createState() => _NotificationPageWidgetState();
}

class _NotificationPageWidgetState extends State<NotificationPageWidget> {


  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isVisible = false;
  bool _hashData = false;
  NotificationModel?_notificationModel;

  @override
  void initState() {
    super.initState();
    Helper.checkInternet(notificationApi());
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

      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          // backgroundColor: FlutterTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: FlutterTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
            "Notification",
              style: FlutterTheme.of(context).headlineMedium.override(
                fontFamily: 'Urbanist',
                color: FlutterTheme.of(context).primaryText,
                fontSize: 22,
              ),
            ),
            actions: [
            ],
            centerTitle: true,
            elevation: 2,
          ),
          body: Stack(
            children: [
              _notificationModel == null
                  ? _hashData
                  ? Container()
                  : Container(
                child: Center(
                  child: Text("NO DATA"),
                ),
              ):
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color:Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Column(
                        children: [
                          ListView.builder(
                              itemCount: _notificationModel!.data!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext , index){
                                return InkWell(
                                  onTap: (){
                                  },
                                  child:  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [Colors.white, Colors.white], // Both colors are white
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5), // Shadow color
                                          spreadRadius: 3, // Spread radius
                                          blurRadius: 5, // Blur radius
                                          offset: Offset(0, 2), // Offset
                                        ),
                                      ],
                                    ),


                                    height: 120,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 5),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Container(
                                                      width: 48.0,
                                                      height: 48.0,
                                                      clipBehavior: Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: _notificationModel!.data![index]!.profileImage.toString()==""|| _notificationModel!.data![index]!.profileImage.toString()==null?Image.asset(
                                                        'assets/images/default_profile_image.png',
                                                        // BaseUrlGroup.getProfileCall
                                                        //     .userProfileUrl(
                                                        //       settingsPageGetProfileResponse
                                                        //           .jsonBody,
                                                        //     )
                                                        //     .toString(),
                                                        fit: BoxFit.cover,
                                                      ):Image.network(
                                                        _notificationModel!.data![index].profileImage.toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            _notificationModel!.data![index].message.toString(),
                                                            style: FlutterTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily: FlutterTheme.of(context)
                                                                  .bodyMediumFamily,
                                                              color:
                                                              Colors.black,
                                                              fontSize: 16.0,
                                                              fontWeight: FontWeight.w300,
                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                                  FlutterTheme.of(context)
                                                                      .bodyMediumFamily),
                                                            ),
                                                          ),
                                                          // Text(
                                                          //   'lorem lipsum is a simply dummy text',
                                                          //   style: FlutterTheme.of(context)
                                                          //       .bodyMedium
                                                          //       .override(
                                                          //     fontFamily: FlutterTheme.of(context)
                                                          //         .bodyMediumFamily,
                                                          //     color: FlutterTheme.of(context).btnNaviBlue,
                                                          //     fontSize: 11.0,
                                                          //     fontWeight: FontWeight.w500,
                                                          //     useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                          //         FlutterTheme.of(context)
                                                          //             .bodyMediumFamily),
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(SizedBox(width: 16.0)),
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(),
                                              Text(
                                                _notificationModel!.data![index].createdAt.toString(),
                                                style: FlutterTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: FlutterTheme.of(context)
                                                      .bodyMediumFamily,
                                                  color:
                                                  Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w300,
                                                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                                                      FlutterTheme.of(context)
                                                          .bodyMediumFamily),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  )
              ),
              Helper.getProgressBarWhite(context, _isVisible)

            ],
          )
      ),
    );
  }

  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }

  Future<void> notificationApi() async {
    print("<=============notificationApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hashData=true;

    Map data = {
      'app_token':"booking12345",
      'user_id':FFAppState().UserId,
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.notifications), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          NotificationModel model = NotificationModel.fromJson(jsonResponse);

          if (model.response == true) {
            print("Model status true");
            setState(() {
              _notificationModel=model;
            });
            setProgress(false);
            _hashData=false;
            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );
          } else {
            setProgress(false);
            _hashData=false;
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
    _hashData=false;
  }
}
