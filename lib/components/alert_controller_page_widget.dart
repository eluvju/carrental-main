import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'alert_controller_page_model.dart';
export 'alert_controller_page_model.dart';

class AlertControllerPageWidget extends StatefulWidget {
  const AlertControllerPageWidget({Key? key}) : super(key: key);

  @override
  _AlertControllerPageWidgetState createState() =>
      _AlertControllerPageWidgetState();
}

class _AlertControllerPageWidgetState extends State<AlertControllerPageWidget> {
  late AlertControllerPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertControllerPageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  FFLocalizations.of(context).getText(
                    't7dwge9a' /* logout */,
                  ),
                  style: FlutterTheme.of(context).displayLarge.override(
                        fontFamily: 'Urbanist',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Flexible(
                  child: Text(
                 "Are you sure do you want to logout this account?",
                    textAlign: TextAlign.center,
                    style: FlutterTheme.of(context).displayLarge.override(
                      fontFamily: 'Urbanist',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          '4zyq3u6i' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: Colors.white,
                          textStyle:
                              FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',
                                    color: Color(0xff553FA5),fontSize: 13,fontWeight: FontWeight.w500
                                  ),
                          elevation: 0.0,
                          borderSide: BorderSide(
                            color: Color(0xff553FA5),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          _model.logoutResponse =
                              await BaseUrlGroup.logoutCall.call(
                            userId: FFAppState().UserId,
                          );
                          if ((_model.logoutResponse?.succeeded ?? true)) {
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              'LoginPage',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                  duration: Duration(milliseconds: 0),
                                ),
                              },
                            );

                            setState(() {
                              FFAppState().UserId = '';
                            });
                          } else {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Notice'),
                                  content: Text(getJsonField(
                                    (_model.logoutResponse?.jsonBody ?? ''),
                                    r'''$.message''',
                                  ).toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          setState(() {});
                        },
                        text: "Yes",
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterTheme.of(context).btnclr,
                          textStyle:
                              FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',
                                    color: Colors.white,fontWeight: FontWeight.w500,fontSize: 13
                                  ),
                          elevation: 0.0,
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
              ]
                  .divide(SizedBox(height: 8.0))
                  .addToStart(SizedBox(height: 5.0))
                  .addToEnd(SizedBox(height: 5.0)),
            ),
          ),
        ),
      ),
    );
  }
}
