import '../../constant.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'language_page_model.dart';
export 'language_page_model.dart';

class LanguagePageWidget extends StatefulWidget {
  const LanguagePageWidget({Key? key}) : super(key: key);

  @override
  _LanguagePageWidgetState createState() => _LanguagePageWidgetState();
}

class _LanguagePageWidgetState extends State<LanguagePageWidget> {
  late LanguagePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LanguagePageModel());
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
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterTheme.of(context).primaryText,
              size: 30,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'n64id622' /* Language */,
            ),
            style: FlutterTheme.of(context).titleMedium.override(
                  fontFamily: 'Manrope',
                  color: FlutterTheme.of(context).primaryText,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        't8xpkwki' /* Select your preferred language */,
                      ),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Manrope',
                            color: FlutterTheme.of(context).primaryText,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                        child: InkWell(
                          onTap: () async {
                            setAppLanguage(context, 'en');
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context).secondaryBackground,
                              border: Border.all(
                                color: FlutterTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: FlutterTheme.of(context).primaryBackground,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context).primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'lu5f2dgm' /* English */,
                                      ),
                                      style: FlutterTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Manrope',
                                            color: FlutterTheme.of(context).primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                        child: InkWell(
                          onTap: () async {
                            setAppLanguage(context, 'ar');
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context).secondaryBackground,
                              border: Border.all(
                                color: FlutterTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: FlutterTheme.of(context).primaryBackground,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context).primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '0ike59t8' /* Arabic */,
                                      ),
                                      style: FlutterTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Manrope',
                                            color: FlutterTheme.of(context).primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                        child: InkWell(
                          onTap: () async {
                            setAppLanguage(context, 'es');
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context).secondaryBackground,
                              border: Border.all(
                                color: FlutterTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: FlutterTheme.of(context).primaryBackground,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterTheme.of(context).primary,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context).primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        '19zferan' /* Spanish */,
                                      ),
                                      style: FlutterTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Manrope',
                                            color: FlutterTheme.of(context).primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 1.0),
                        child: InkWell(
                          onTap: () async {
                            setAppLanguage(context, 'pt');
                            context.pop();
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context).secondaryBackground,
                              border: Border.all(
                                color: FlutterTheme.of(context).alternate,
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: 24.0,
                                    height: 24.0,
                                    decoration: BoxDecoration(
                                      color: FlutterTheme.of(context).secondaryBackground,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: FlutterTheme.of(context).alternate,
                                        width: 2.0,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                                      child: Container(
                                        width: 12.0,
                                        height: 12.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context).primary,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Português',
                                      style: FlutterTheme.of(context).bodyMedium.override(
                                            fontFamily: 'Manrope',
                                            color: FlutterTheme.of(context).primaryText,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
