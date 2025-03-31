import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'alert_account_delete_model.dart';
export 'alert_account_delete_model.dart';

class AlertAccountDeleteWidget extends StatefulWidget {
  const AlertAccountDeleteWidget({Key? key}) : super(key: key);

  @override
  _AlertAccountDeleteWidgetState createState() =>
      _AlertAccountDeleteWidgetState();
}

class _AlertAccountDeleteWidgetState extends State<AlertAccountDeleteWidget> {
  late AlertAccountDeleteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertAccountDeleteModel());
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
                    'j8l4d67u' /* Delete Account */,
                  ),
                  style: FlutterTheme.of(context).displayLarge.override(
                        fontFamily: 'Urbanist',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Flexible(
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'fwge82n8' /* Are you sure you want to delet... */,
                    ),
                    textAlign: TextAlign.center,

                    style: FlutterTheme.of(context).displayLarge.override(
                      fontFamily: 'Urbanist',
                      fontSize: 13.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // SizedBox(height: 5,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        text: FFLocalizations.of(context).getText(
                          'cuuxlwr3' /* Cancel */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:Colors.white,
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
                          context.safePop();
                          _model.apiResultl30 =
                              await BaseUrlGroup.deleteaccountCall.call(
                            userId: FFAppState().UserId,
                          );
                          if ((_model.apiResultl30?.succeeded ?? true)) {
                            context.pushNamed('LoginPage');
                          } else {
                            context.pushNamed('LoginPage');
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
                          color: Color(0xff1D1415),
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
