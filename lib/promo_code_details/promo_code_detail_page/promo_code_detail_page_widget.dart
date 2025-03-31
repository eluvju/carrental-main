import 'package:car_rental/flutter/flutter_util.dart';
import '../../constant.dart';
import '../../flutter/flutter_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'promo_code_detail_page_model.dart';
export 'promo_code_detail_page_model.dart';

class PromoCodeDetailPageWidget extends StatefulWidget {
  String coupon_image="";
  String coupon="";
  String title="";
  String details="";

  PromoCodeDetailPageWidget({required this.coupon_image, required this.coupon, required this.title,
    required this.details,});

  @override
  _PromoCodeDetailPageWidgetState createState() =>
      _PromoCodeDetailPageWidgetState();
}

class _PromoCodeDetailPageWidgetState extends State<PromoCodeDetailPageWidget> {
  // late PromoCodeDetailPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _model = createModel(context, () => PromoCodeDetailPageModel());
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
          title: Text("Promocode Detail",
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
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14.0),
                          child: widget.coupon_image==""?Image.asset('assets/images/promocode1.png',height: 200,  width: 352.0,  fit: BoxFit.cover,):
                          Image.network(
                            widget.coupon_image,
                            width: 352.0,
                            height: 200.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          25.0, 0.0, 25.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    widget.title,
                                    textAlign: TextAlign.start,
                                    style: FlutterTheme.of(context)
                                        .headlineLarge
                                        .override(
                                          fontFamily: 'Montserrat',
                                          color: FlutterTheme.of(context)
                                              .black600,
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                              FlutterTheme.of(context)
                                                      .headlineLargeFamily),
                                        ),
                                  ),
                                  // Text(
                                  //   'Available until January 24, 2024',
                                  //   textAlign: TextAlign.start,
                                  //   style: FlutterFlowTheme.of(context)
                                  //       .headlineLarge
                                  //       .override(
                                  //         fontFamily: 'Montserrat',
                                  //         color: FlutterFlowTheme.of(context)
                                  //             .textColorbg,
                                  //         fontSize: 14.0,
                                  //         fontWeight: FontWeight.w500,
                                  //         useGoogleFonts: GoogleFonts.asMap()
                                  //             .containsKey(
                                  //                 FlutterFlowTheme.of(context)
                                  //                     .headlineLargeFamily),
                                  //       ),
                                  // ),
                                ],
                              ),
                              Text(
                                widget.details,
                                textAlign: TextAlign.start,
                                style: FlutterTheme.of(context)
                                    .headlineLarge
                                    .override(
                                      fontFamily: 'Montserrat',
                                      color: FlutterTheme.of(context)
                                          .black600,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                          FlutterTheme.of(context)
                                                  .headlineLargeFamily),
                                    ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Color(0x4DDFDFDF),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                                  child: Row(
                                    children: [
                                      // Add your icon widget here
                                      InkWell(
                                        onTap: () {
                                          // Add logic to copy coupon code to clipboard
                                          Clipboard.setData(ClipboardData(text: widget.coupon));
                                          // You can also provide some feedback to the user (e.g., show a toast)
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Coupon code copied to clipboard")),
                                          );
                                        },
                                        child: Icon(
                                          Icons.content_copy, // You can replace this with your desired icon
                                          color: FlutterTheme.of(context).black600,
                                        ),
                                      ),
                                      SizedBox(width: 8.0), // Adjust spacing between icon and text
                                      GestureDetector(
                                        onTap: () {
                                          // Add logic to copy coupon code to clipboard
                                          Clipboard.setData(ClipboardData(text: widget.coupon));
                                          // You can also provide some feedback to the user (e.g., show a toast)
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Coupon code copied to clipboard")),
                                          );
                                        },
                                        child: Text(
                                          widget.coupon,
                                          style: FlutterTheme.of(context).bodyMedium.override(
                                            fontFamily:
                                            FlutterTheme.of(context).bodyMediumFamily,
                                            color: FlutterTheme.of(context).black600,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                              FlutterTheme.of(context).bodyMediumFamily,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )

                            ].divide(SizedBox(height: 20.0)),
                          ),
                          // FlutterFlowPdfViewer(
                          //   networkPath:
                          //       'http://www.pdf995.com/samples/pdf.pdf',
                          //   height: 300.0,
                          //   horizontalScroll: false,
                          // ),
                        ].divide(SizedBox(height: 20.0)),
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 20.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
