import '../../constant.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/alert_controller_back_page_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'support_page_model.dart';
export 'support_page_model.dart';

class SupportPageWidget extends StatefulWidget {
  const SupportPageWidget({Key? key}) : super(key: key);

  @override
  _SupportPageWidgetState createState() => _SupportPageWidgetState();
}

class _SupportPageWidgetState extends State<SupportPageWidget> {
  late SupportPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupportPageModel());

    _model.textFieldFocusNode1 ??= FocusNode();

    _model.textFieldFocusNode2 ??= FocusNode();

    _model.textFieldFocusNode3 ??= FocusNode();

    _model.textController4 ??= TextEditingController();
    _model.textFieldFocusNode4 ??= FocusNode();
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
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        final supportPageGetProfileResponse = snapshot.data!;
        return GestureDetector(
          onTap: () => _model.unfocusNode.canRequestFocus
              ? FocusScope.of(context).requestFocus(_model.unfocusNode)
              : FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterTheme.of(context).secondaryBackground,
            // appBar: AppBar(
            //   backgroundColor: FlutterTheme.of(context).secondaryBackground,
            //   automaticallyImplyLeading: false,
            //   leading: FlutterIconButton(
            //     borderColor: Colors.transparent,
            //     borderRadius: 30.0,
            //     borderWidth: 1.0,
            //     buttonSize: 60.0,
            //     icon: Icon(
            //       Icons.arrow_back,
            //       color: FlutterTheme.of(context).primaryText,
            //       size: 30.0,
            //     ),
            //     onPressed: () async {
            //       context.pop();
            //     },
            //   ),
            //   title: Text(
            //     FFLocalizations.of(context).getText(
            //       'vanz5ki4' /* Submit Ticket */,
            //     ),
            //     style: FlutterTheme.of(context).titleLarge.override(
            //           fontFamily: 'Outfit',
            //           color: FlutterTheme.of(context).primaryText,
            //           fontSize: 22.0,
            //           fontWeight: FontWeight.w500,
            //         ),
            //   ),
            //   actions: [],
            //   centerTitle: true,
            //   elevation: 2.0,
            // ),
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
              title: Text(
                "Contact Us",
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
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                         "Submit a Ticket",
                        style: FlutterTheme.of(context).labelLarge.override(
                              fontFamily: 'Outfit',
                              color: FlutterTheme.of(context).primaryText,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      //   child: Text(
                      //     FFLocalizations.of(context).getText(
                      //       'yayjowch' /* Submit a Ticket */,
                      //     ),
                      //     style: FlutterTheme.of(context)
                      //         .headlineMedium
                      //         .override(
                      //           fontFamily: 'Outfit',
                      //           color: FlutterTheme.of(context).primaryText,
                      //           fontSize: 24.0,
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //   ),
                      // ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            TextFormField(
                              controller: _model.textController1 ??=
                                  TextEditingController(
                                text: BaseUrlGroup.getProfileCall
                                    .userName(
                                      supportPageGetProfileResponse.jsonBody,
                                    )
                                    .toString(),
                              ),
                              focusNode: _model.textFieldFocusNode1,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: FFLocalizations.of(context).getText(
                                  'd64ticys' /* User Name */,
                                ),
                                labelStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                hintStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6F61EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                              ),
                              style: FlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              cursorColor: Color(0xFF6F61EF),
                              validator: _model.textController1Validator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textController2 ??=
                                  TextEditingController(
                                text: BaseUrlGroup.getProfileCall
                                    .email(
                                      supportPageGetProfileResponse.jsonBody,
                                    )
                                    .toString(),
                              ),
                              focusNode: _model.textFieldFocusNode2,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: FFLocalizations.of(context).getText(
                                  'yd9rmtek' /* Email */,
                                ),
                                labelStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                hintStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6F61EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                              ),
                              style: FlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              cursorColor: Color(0xFF6F61EF),
                              validator: _model.textController2Validator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textController3 ??=
                                  TextEditingController(
                                text: BaseUrlGroup.getProfileCall
                                    .contact(
                                      supportPageGetProfileResponse.jsonBody,
                                    )
                                    .toString(),
                              ),
                              focusNode: _model.textFieldFocusNode3,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: FFLocalizations.of(context).getText(
                                  '0g085y2a' /* Contact */,
                                ),
                                labelStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                hintStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6F61EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 12.0, 16.0, 12.0),
                              ),
                              style: FlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              keyboardType: TextInputType.phone,
                              cursorColor: Color(0xFF6F61EF),
                              validator: _model.textController3Validator
                                  .asValidator(context),
                            ),
                            TextFormField(
                              controller: _model.textController4,
                              focusNode: _model.textFieldFocusNode4,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                hintText: FFLocalizations.of(context).getText(
                                  '64cwuku8' /* Short Description of what is g... */,
                                ),
                                hintStyle: FlutterTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5E7EB),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF6F61EF),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFFF5963),
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                contentPadding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 24.0, 16.0, 12.0),
                              ),
                              style: FlutterTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: FlutterTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 16,
                              minLines: 6,
                              cursorColor: Color(0xFF6F61EF),
                              validator: _model.textController4Validator
                                  .asValidator(context),
                            ),
                          ].divide(SizedBox(height: 12.0)),
                        ),
                      ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.responseHelp =
                                  await BaseUrlGroup.needhelpCall.call(
                                email: _model.textController2.text,
                                userName: _model.textController1.text,
                                contact: _model.textController3.text,
                                message: _model.textController4.text,
                              );
                              if ((_model.responseHelp?.succeeded ?? true)) {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: true,
                                  avoidOverflow: false,
                                  targetAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: Container(
                                          height: 250.0,
                                          width: double.infinity,
                                          child: AlertControllerBackPageWidget(
                                            message: BaseUrlGroup.needhelpCall
                                                .message(
                                                  (_model.responseHelp
                                                          ?.jsonBody ??
                                                      ''),
                                                )
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              } else {
                                await showAlignedDialog(
                                  context: context,
                                  isGlobal: true,
                                  avoidOverflow: false,
                                  targetAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  followerAnchor: AlignmentDirectional(0.0, 0.0)
                                      .resolve(Directionality.of(context)),
                                  builder: (dialogContext) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        onTap: () => _model
                                                .unfocusNode.canRequestFocus
                                            ? FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode)
                                            : FocusScope.of(context).unfocus(),
                                        child: AlertControllerBackPageWidget(
                                          message: BaseUrlGroup.needhelpCall
                                              .message(
                                                (_model.responseHelp
                                                        ?.jsonBody ??
                                                    ''),
                                              )
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) => setState(() {}));
                              }

                              setState(() {});
                            },
                            text: FFLocalizations.of(context).getText(
                              'ja010245' /* Submit */,
                            ),
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterTheme.of(context).btnclr,
                              textStyle: FlutterTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,
                                    fontSize: 18.0,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
