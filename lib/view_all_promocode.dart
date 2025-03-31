
import 'package:car_rental/promo_code_details/promo_code_detail_page/promo_code_detail_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'constant.dart';
import 'flutter/flutter_theme.dart';
import 'flutter/flutter_util.dart';

import 'package:http/http.dart'as http;

import 'model/promocode_model.dart';


class ViewAllPromode extends StatefulWidget {
  // String coupon_image="";
  // String coupon="";
  // String title="";
  // String details="";
  //
  // ViewAllPromode({required this.coupon_image, required this.coupon, required this.title,
  //   required this.details,});

  @override
  _ViewAllPromodeState createState() =>
      _ViewAllPromodeState();
}

class _ViewAllPromodeState extends State<ViewAllPromode> {
  // late PromoCodeDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Promocode?_promocodeModel;
  bool _isVisible = false;
  bool _hasData = true;

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => PromoCodeDetailPageModel());
     Helper.checkInternet(promocodeApi());
  }

  @override
  void dispose() {
    // _model.dispose();

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
      child: Scaffold(
        key: scaffoldKey,
        // backgroundColor: FlutterTheme.of(context).backgraund,
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
          title: Text("Promocode",
            // FFLocalizations.of(context).getText(
            //   'p6r3ar1p' /* More Filter */,
            // ),
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child:

            Stack(
              children: [
                _promocodeModel==null
                    ? _hasData
                    ? Container()
                    : Container(
                  child: Center(
                    child: Text("NO DATA"),
                  ),
                ):
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _promocodeModel!.deliverydata!.length,
                        physics: ScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Helper.moveToScreenwithPush(
                                context,
                                PromoCodeDetailPageWidget(
                                  coupon_image: _promocodeModel!.deliverydata![index].image.toString(),
                                  coupon: _promocodeModel!.deliverydata![index].couponCode.toString(),
                                  title: _promocodeModel!.deliverydata![index].couponName.toString(),
                                  details: _promocodeModel!.deliverydata![index].description.toString(),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14.0),
                                child:_promocodeModel!.deliverydata![index].image.toString()==""?Image.asset('assets/images/promocode1.png',height: 120,  width: 352.0,  fit: BoxFit.cover,):
                                Image.network(
                                  _promocodeModel!.deliverydata![index].image.toString(),
                                  width: 352.0,
                                  // height: 200.0,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                    ].divide(SizedBox(height: 0.0)),
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

  Future<void> promocodeApi() async {


    print("<=============promocodeApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);
    _hasData=true;

    Map data = {
      'app_token':'booking12345',
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.promocode), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          Promocode model = Promocode.fromJson(jsonResponse);

          if (model.result == "success") {
            print("Model status true");
            setProgress(false);
            _hasData=false;

            setState(() {
              _promocodeModel=model;
            });

            print("successs==============");
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(model.message.toString()),
            //   ),
            // );


          }
          else {
            setProgress(false);
            _hasData=false;
            print("false ### ============>");

            // context.pushNamed('RegisterCrozerVehicalPage');


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
    _hasData=false;
  }
}
