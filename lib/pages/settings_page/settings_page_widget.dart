import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant.dart';
import '../../model/common_model.dart';
import '../login_page/login_page_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/alert_account_delete_widget.dart';
import '/components/alert_controller_page_widget.dart';
import '/components/light_widget.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'settings_page_model.dart';
export 'settings_page_model.dart';
import 'package:http/http.dart'as http;

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  _SettingsPageWidgetState createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  late SettingsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hasData = true;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsPageModel());
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

    return FutureBuilder<ApiCallResponse>(
      future: BaseUrlGroup.getProfileCall.call(
        userId: FFAppState().UserId,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final settingsPageGetProfileResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterTheme.of(context).secondaryBackground,
              // appBar: AppBar(
              //   backgroundColor:
              //       FlutterTheme.of(context).secondaryBackground,
              //   automaticallyImplyLeading: false,
              //   title: Text(
              //     FFLocalizations.of(context).getText(
              //       'bwhpeicr' /* Settings */,
              //     ),
              //     style: FlutterTheme.of(context).headlineMedium.override(
              //           fontFamily: 'Urbanist',
              //           color: FlutterTheme.of(context).primaryText,
              //           fontSize: 22.0,
              //         ),
              //   ),
              //   actions: [],
              //   centerTitle: true,
              //   elevation: 2.0,
              // ),
              appBar: AppBar(
                backgroundColor: Color(0xff553FA5),
                automaticallyImplyLeading: false,
                elevation: 0, // This should remove the default bottom line
                shape: Border(
                  bottom: BorderSide(
                    color: Color(0xff553FA5), // Set this to match the background color to hide the line
                    width: 0.0, // Set to 0.0 to effectively make it disappear
                  ),
                ),
                // leading: InkWell(
                //   onTap: () {
                //     Helper.popScreen(context);
                //   },
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 10.0, top: 15.0, right: 0.0, bottom: 10.0),
                //     child: Image.asset(
                //       'assets/images/back_icon_with_bg.png',
                //       height: 30,
                //       width: 30,
                //     ),
                //   ),
                // ),
                title: Text(
                  FFLocalizations.of(context).getText(
                    'bwhpeicr', // Settings
                  ),
                  style: FlutterTheme.of(context).headlineMedium.override(
                    fontFamily: 'Urbanist',
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [],
                centerTitle: true,
              ),
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                height:160,
                                decoration: BoxDecoration(
                                 color:Color(0xff553FA5)
                              ),),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 210,
                                  // width: 100.0,
                                  child: Stack(
                                    alignment: AlignmentDirectional(1.0, 1.0),
                                    children: [
                                      Container(
                                        width: 122.0,
                                        height: 122.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xffF4F4F4),width: 5
                                          ,),

                                          shape: BoxShape.circle,
                                        ),
                                        child:    BaseUrlGroup.getProfileCall
                                            .userProfileUrl(
                                          settingsPageGetProfileResponse.jsonBody,
                                        )
                                            .toString()==""?Image.asset(
                                          'assets/images/default_profile_image.png',
                                          // BaseUrlGroup.getProfileCall
                                          //     .userProfileUrl(
                                          //       settingsPageGetProfileResponse
                                          //           .jsonBody,
                                          //     )
                                          //     .toString(),
                                          fit: BoxFit.cover,
                                        ):Image.network(
                                          BaseUrlGroup.getProfileCall
                                              .userProfileUrl(
                                            settingsPageGetProfileResponse.jsonBody,
                                          )
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // Material(
                                      //   color: Colors.transparent,
                                      //   elevation: 4.0,
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(15.0),
                                      //   ),
                                      //   child: Container(
                                      //     width: 30.0,
                                      //     height: 30.0,
                                      //     decoration: BoxDecoration(
                                      //       color:
                                      //       FlutterTheme.of(context).error,
                                      //       borderRadius:
                                      //       BorderRadius.circular(15.0),
                                      //     ),
                                      //     alignment:
                                      //     AlignmentDirectional(0.00, 0.00),
                                      //     child: Icon(
                                      //       Icons.check_circle,
                                      //       color: FlutterTheme.of(context)
                                      //           .primaryBtnText,
                                      //       size: 24.0,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            valueOrDefault<String>(
                              BaseUrlGroup.getProfileCall
                                  .userName(
                                    settingsPageGetProfileResponse.jsonBody,
                                  )
                                  .toString(),
                              '',
                            ),
                            style: FlutterTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterTheme.of(context).primary,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            valueOrDefault<String>(
                              BaseUrlGroup.getProfileCall
                                  .email(
                                    settingsPageGetProfileResponse.jsonBody,
                                  )
                                  .toString(),
                              'pramod@gmail.com',
                            ),
                            style: FlutterTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: FlutterTheme.of(context).accent3,
                                ),
                          ),
                        ].divide(SizedBox(height: 8.0)),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // InkWell(
                                  //   splashColor: Colors.transparent,
                                  //   focusColor: Colors.transparent,
                                  //   hoverColor: Colors.transparent,
                                  //   highlightColor: Colors.transparent,
                                  //   onTap: () async {
                                  //     setDarkModeSetting(
                                  //         context, ThemeMode.system);
                                  //   },
                                  //   child: Container(
                                  //     width: double.infinity,
                                  //     height: 50.0,
                                  //     decoration: BoxDecoration(),
                                  //     child: Padding(
                                  //       padding: EdgeInsetsDirectional.fromSTEB(
                                  //           8.0, 8.0, 0.0, 0.0),
                                  //       child: Row(
                                  //         mainAxisSize: MainAxisSize.max,
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.spaceAround,
                                  //         children: [
                                  //           Text(
                                  //             FFLocalizations.of(context)
                                  //                 .getText(
                                  //               'sgwvfgwt' /*           */,
                                  //             ),
                                  //             style:
                                  //                 FlutterTheme.of(context)
                                  //                     .bodyMedium,
                                  //           ),
                                  //           Text(
                                  //             FFLocalizations.of(context)
                                  //                 .getText(
                                  //               'p7fixm5n' /* Mode */,
                                  //             ),
                                  //             textAlign: TextAlign.start,
                                  //             style: FlutterTheme.of(
                                  //                     context)
                                  //                 .displaySmall
                                  //                 .override(
                                  //                   fontFamily: 'Urbanist',
                                  //                   color: FlutterTheme.of(
                                  //                           context)
                                  //                       .primary,
                                  //                   fontSize: 20.0,
                                  //                   fontWeight: FontWeight.bold,
                                  //                 ),
                                  //           ),
                                  //           Spacer(),
                                  //           wrapWithModel(
                                  //             model: _model.lightModel,
                                  //             updateCallback: () =>
                                  //                 setState(() {}),
                                  //             child: LightWidget(),
                                  //           ),
                                  //         ].divide(SizedBox(width: 12.0)),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Opacity(
                                  //   opacity: 0.5,
                                  //   child: Divider(
                                  //     thickness: 1.0,
                                  //     color:
                                  //         FlutterTheme.of(context).accent4,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('change_password_page');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset('assets/images/lock.svg',height: 24,width: 24,),
                                            // Container(
                                            //   width: 34.0,
                                            //   height: 34.0,
                                            //   decoration: BoxDecoration(
                                            //     color:
                                            //         FlutterTheme.of(context)
                                            //             .secondary,
                                            //     shape: BoxShape.circle,
                                            //   ),
                                            //   child: Padding(
                                            //     padding: EdgeInsetsDirectional
                                            //         .fromSTEB(
                                            //             2.0, 2.0, 2.0, 2.0),
                                            //     child: Icon(
                                            //       Icons.password,
                                            //       color: FlutterTheme.of(
                                            //               context)
                                            //           .primaryBtnText,
                                            //       size: 20.0,
                                            //     ),
                                            //   ),
                                            // ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '69inanq5' /* Change Password */,
                                              ),
                                              textAlign: TextAlign.start,
                                              style: FlutterTheme.of(
                                                      context)
                                                  .displaySmall
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color: FlutterTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                                  Color(0xff6F7C8E),
                                              size: 25.0,
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Opacity(
                                  //   opacity: 0.5,
                                  //   child: Divider(
                                  //     thickness: 1.0,
                                  //     color:
                                  //         FlutterTheme.of(context).accent4,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('edit_profile');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset('assets/images/profile_edit.svg',height: 24,width: 24,),
                                            // Container(
                                            //   width: 34.0,
                                            //   height: 34.0,
                                            //   decoration: BoxDecoration(
                                            //     color:
                                            //         FlutterTheme.of(context)
                                            //             .secondary,
                                            //     shape: BoxShape.circle,
                                            //   ),
                                            //   child: Padding(
                                            //     padding: EdgeInsetsDirectional
                                            //         .fromSTEB(
                                            //             2.0, 2.0, 2.0, 2.0),
                                            //     child: Icon(
                                            //       Icons.edit_sharp,
                                            //       color: FlutterTheme.of(
                                            //               context)
                                            //           .primaryBtnText,
                                            //       size: 20.0,
                                            //     ),
                                            //   ),
                                            // ),
                                            Expanded(
                                              child: Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'mcmg3n10' /* Edit Profile */,
                                                ),
                                                textAlign: TextAlign.start,
                                                style: FlutterTheme.of(
                                                        context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                              Color(0xff6F7C8E),
                                              size: 25.0,
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Opacity(
                                  //   opacity: 0.5,
                                  //   child: Divider(
                                  //     thickness: 1.0,
                                  //     color:
                                  //         FlutterTheme.of(context).accent4,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('support_page');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset('assets/images/phone.svg',height: 24,width: 24,),
                                            // Container(
                                            //   width: 34.0,
                                            //   height: 34.0,
                                            //   decoration: BoxDecoration(
                                            //     color:
                                            //         FlutterTheme.of(context)
                                            //             .secondary,
                                            //     shape: BoxShape.circle,
                                            //   ),
                                            //   child: Padding(
                                            //     padding: EdgeInsetsDirectional
                                            //         .fromSTEB(
                                            //             2.0, 2.0, 2.0, 2.0),
                                            //     child: Icon(
                                            //       Icons.support_agent_rounded,
                                            //       color: FlutterTheme.of(
                                            //               context)
                                            //           .primaryBtnText,
                                            //       size: 20.0,
                                            //     ),
                                            //   ),
                                            // ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'g4vzf15u' /* Contact Us */,
                                              ),
                                              textAlign: TextAlign.start,
                                              style: FlutterTheme.of(
                                                      context)
                                                  .displaySmall
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color: FlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                              Color(0xff6F7C8E),
                                              size: 25.0,
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Opacity(
                                  //   opacity: 0.5,
                                  //   child: Divider(
                                  //     thickness: 1.0,
                                  //     color:
                                  //         FlutterTheme.of(context).accent4,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed('language_page');
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 8.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SvgPicture.asset('assets/images/language.svg',height: 24,width: 24,),
                                            // Container(
                                            //   width: 34.0,
                                            //   height: 34.0,
                                            //   decoration: BoxDecoration(
                                            //     color:
                                            //         FlutterTheme.of(context)
                                            //             .secondary,
                                            //     shape: BoxShape.circle,
                                            //   ),
                                            //   child: Padding(
                                            //     padding: EdgeInsetsDirectional
                                            //         .fromSTEB(
                                            //             2.0, 2.0, 2.0, 2.0),
                                            //     child: Icon(
                                            //       Icons.language,
                                            //       color: FlutterTheme.of(
                                            //               context)
                                            //           .primaryBtnText,
                                            //       size: 20.0,
                                            //     ),
                                            //   ),
                                            // ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'olr7jsxh' /* Language */,
                                              ),
                                              textAlign: TextAlign.start,
                                              style: FlutterTheme.of(
                                                      context)
                                                  .displaySmall
                                                  .override(
                                                    fontFamily: 'Urbanist',
                                                    color: FlutterTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            Spacer(),
                                            Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                              Color(0xff6F7C8E),
                                              size: 25.0,
                                            ),
                                          ].divide(SizedBox(width: 12.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Opacity(
                                  //   opacity: 0.5,
                                  //   child: Divider(
                                  //     thickness: 1.0,
                                  //     color:
                                  //         FlutterTheme.of(context).accent4,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Container(
                                                  height: 220.0,
                                                  width: double.infinity,
                                                  child:
                                                      AlertAccountDeleteWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SvgPicture.asset('assets/images/delete.svg',height: 24,width: 24,),
                                              // Container(
                                              //   width: 34.0,
                                              //   height: 34.0,
                                              //   decoration: BoxDecoration(
                                              //     color: FlutterTheme.of(
                                              //             context)
                                              //         .secondary,
                                              //     shape: BoxShape.circle,
                                              //   ),
                                              //   child: Padding(
                                              //     padding: EdgeInsetsDirectional
                                              //         .fromSTEB(
                                              //             2.0, 2.0, 2.0, 2.0),
                                              //     child: Icon(
                                              //       Icons.person_remove,
                                              //       color: FlutterTheme.of(
                                              //               context)
                                              //           .primaryBtnText,
                                              //       size: 20.0,
                                              //     ),
                                              //   ),
                                              // ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dwut51nl' /* Account Delete */,
                                                ),
                                                textAlign: TextAlign.start,
                                                style: FlutterTheme.of(
                                                        context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              Spacer(),
                                              Icon(
                                                Icons.navigate_next_sharp,
                                                color:
                                                Color(0xff6F7C8E),
                                                size: 25.0,
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Opacity(
                                opacity: 0.5,
                                child: Divider(
                                  thickness: 1.0,
                                  color:
                                  FlutterTheme.of(context).accent4,
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        // showAlertDialog(context);
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Container(
                                                  height: 180.0,
                                                  width: double.infinity,
                                                  child:
                                                      AlertControllerPageWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 50.0,
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 8.0, 0.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SvgPicture.asset('assets/images/logout.svg',height: 24,width: 24,),
                                              // Container(
                                              //   width: 34.0,
                                              //   height: 34.0,
                                              //   decoration: BoxDecoration(
                                              //     color: FlutterTheme.of(
                                              //             context)
                                              //         .secondary,
                                              //     shape: BoxShape.circle,
                                              //   ),
                                              //   child: Padding(
                                              //     padding: EdgeInsetsDirectional
                                              //         .fromSTEB(
                                              //             2.0, 2.0, 2.0, 2.0),
                                              //     child: Icon(
                                              //       Icons.logout,
                                              //       color: FlutterTheme.of(
                                              //               context)
                                              //           .primaryBtnText,
                                              //       size: 20.0,
                                              //     ),
                                              //   ),
                                              // ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  '837x3ooi' /* Logout */,
                                                ),
                                                textAlign: TextAlign.start,
                                                style: FlutterTheme.of(
                                                        context)
                                                    .displaySmall
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                        Color(0xff553FA5),
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                              Spacer(),
                                              // Icon(
                                              //   Icons.navigate_next_sharp,
                                              //   color:
                                              //   Color(0xff6F7C8E),
                                              //   size: 25.0,
                                              // ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Builder(
                                    builder: (context) => InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        await showAlignedDialog(
                                          context: context,
                                          isGlobal: true,
                                          avoidOverflow: false,
                                          targetAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          followerAnchor: AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          builder: (dialogContext) {
                                            return Material(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                onTap: () => _model.unfocusNode
                                                        .canRequestFocus
                                                    ? FocusScope.of(context)
                                                        .requestFocus(
                                                            _model.unfocusNode)
                                                    : FocusScope.of(context)
                                                        .unfocus(),
                                                child: Container(
                                                  height: 180.0,
                                                  width: double.infinity,
                                                  child:
                                                      AlertControllerPageWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => setState(() {}));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 119.0,
                                        decoration: BoxDecoration(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                        .divide(SizedBox(height: 20.0))
                        .addToEnd(SizedBox(height: 0.0)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  setProgress(bool show) {
    if (mounted)
      setState(() {
        _isVisible = show;
      });
  }
  Future<void> logoutApi() async {


    print("<=============logoutApi=============>");

    SessionHelper session = await SessionHelper.getInstance(context);
    String userId = session.get(SessionHelper.USER_ID) ?? "0";
    setProgress(true);

    Map data = {
      'app_token':"booking12345",
      'user_id':userId,
      // 'delivery_cost':cost
    };

    print("Request =============>" + data.toString());
    try {
      var res = await http.post(Uri.parse(Apis.logout), body: data);
      print("Response ============>" + res.body);

      if (res.statusCode == 200) {
        try {
          final jsonResponse = jsonDecode(res.body);
          CommonModel model = CommonModel.fromJson(jsonResponse);

          if (model.response == "true") {
            print("Model status true");
            setProgress(false);

            print("successs==============");
            session.clear();
            SessionHelper sessionHelper = await SessionHelper.getInstance(context);
            sessionHelper.put(SessionHelper.USER_ID, "0");
            Helper.moveToScreenwithPush(context, LoginPageWidget());

            // context.pushNamed(
            //   'LoginPage',
            //   extra: <String, dynamic>{
            //     kTransitionInfoKey: TransitionInfo(
            //       hasTransition: true,
            //       transitionType: PageTransitionType.fade,
            //       duration: Duration(milliseconds: 0),
            //     ),
            //   },
            // );

          }
          else {
            setProgress(false);
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

  showAlertDialog(BuildContext context) {

    // set up the AlertDialog

    AlertDialog alert = AlertDialog(
      scrollable: false,
      insetPadding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        // margin: EdgeInsets.only(top: 50),
        height: MediaQuery.of(context).size.height*0.22,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                '9snex28e' /* Notice */,
              ),
              style: FlutterTheme.of(context).displayLarge.override(
                fontFamily: 'Outfit',
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Flexible(
              child: Text(
                FFLocalizations.of(context).getText(
                  'htkgpimb' /* Are you sure you want to logou... */,
                ),
                textAlign: TextAlign.center,
                style: FlutterTheme.of(context).bodyMedium,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all<Color>(
            //               FlutterTheme.of(context)
            //                   .alternate),
            //           shape:
            //           MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius:
            //                   BorderRadius.circular(5)))),
            //       onPressed: () {
            //         Helper.popScreen(context);
            //         // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            //         //     Home()), (Route<dynamic> route) => false);
            //       },
            //       child: Text(
            //         "Cancel",
            //         textAlign: TextAlign.center,
            //         style: FlutterTheme.of(context)
            //             .bodyMedium
            //             .override(
            //           fontFamily: FlutterTheme.of(context)
            //               .bodyMediumFamily,
            //           color:
            //           FlutterTheme.of(context).alternate,
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           useGoogleFonts: GoogleFonts.asMap()
            //               .containsKey(FlutterTheme.of(context)
            //               .bodyMediumFamily),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 20,
            //     ),
            //     ElevatedButton(
            //       style: ButtonStyle(
            //           backgroundColor: MaterialStateProperty.all<Color>(
            //             Color(0xFFFE2121),),
            //           shape:
            //           MaterialStateProperty.all<RoundedRectangleBorder>(
            //               RoundedRectangleBorder(
            //                   borderRadius:
            //                   BorderRadius.circular(5)))),
            //       onPressed: () {
            //         Helper.checkInternet(logoutApi());
            //         // if (Navigator.of(context).canPop()) {
            //         //   context.pop();
            //         // }
            //         // context.pushNamed(
            //         //   'WelcomePage',
            //         //   extra: <String, dynamic>{
            //         //     kTransitionInfoKey: TransitionInfo(
            //         //       hasTransition: true,
            //         //       transitionType: PageTransitionType.fade,
            //         //       duration: Duration(milliseconds: 0),
            //         //     ),
            //         //   },
            //         // );
            //         // Helper.checkInternet(deleteaccountApi());
            //
            //       },
            //       child: Text(
            //         "Delete",
            //         textAlign: TextAlign.center,
            //         style: FlutterTheme.of(context)
            //             .bodyMedium
            //             .override(
            //           fontFamily: FlutterTheme.of(context)
            //               .bodyMediumFamily,
            //           color:
            //           FlutterTheme.of(context).alternate,
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.bold,
            //           useGoogleFonts: GoogleFonts.asMap()
            //               .containsKey(FlutterTheme.of(context)
            //               .bodyMediumFamily),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: FFLocalizations.of(context).getText(
                      'fan0hpv2' /* Cancel */,
                    ),
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterTheme.of(context).error,
                      textStyle:
                      FlutterTheme.of(context).titleSmall.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      Helper.checkInternet(logoutApi());
                    },
                    text: "Logout",
                    options: FFButtonOptions(
                      height: 40.0,
                      padding: EdgeInsetsDirectional.fromSTEB(
                          24.0, 0.0, 24.0, 0.0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: FlutterTheme.of(context).secondary,
                      textStyle:
                      FlutterTheme.of(context).titleSmall.override(
                        fontFamily: 'Outfit',
                        color: Colors.white,
                      ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),

              ]
                  .divide(SizedBox(width: 8.0))
                  .addToStart(SizedBox(width: 5.0))
                  .addToEnd(SizedBox(width: 5.0)),
            ),

          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
