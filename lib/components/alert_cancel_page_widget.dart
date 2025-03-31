import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'alert_cancel_page_model.dart';
export 'alert_cancel_page_model.dart';

class AlertCancelPageWidget extends StatefulWidget {
  const AlertCancelPageWidget({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  final String? bookingId;

  @override
  _AlertCancelPageWidgetState createState() => _AlertCancelPageWidgetState();
}

class _AlertCancelPageWidgetState extends State<AlertCancelPageWidget> {
  late AlertCancelPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertCancelPageModel());
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
          color: FlutterTheme.of(context).secondaryBackground,
          elevation: 4.0,
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
                    'n968vjav' /* Notice */,
                  ),
                  style: FlutterTheme.of(context).displayLarge.override(
                        fontFamily: 'Urbanist',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Flexible(
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'yqlhvd8z' /* Are you sure you want to cance... */,
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterTheme.of(context).bodyMedium,
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
                          'dpummdq7' /* Cancel */,
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
                                    fontFamily: 'Urbanist',
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
                          context.safePop();
                          _model.apiResultl30 =
                              await BaseUrlGroup.cancelledCall.call(
                            bookingId: widget.bookingId,
                            userId: FFAppState().UserId,
                          );
                          if ((_model.apiResultl30?.succeeded ?? true)) {
                            Navigator.pop(context);
                            context.safePop();
                          } else {
                            context.safePop();
                          }

                          setState(() {});
                        },
                        text: FFLocalizations.of(context).getText(
                          '8qfzm4fr' /* Okay */,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterTheme.of(context).secondary,
                          textStyle:
                              FlutterTheme.of(context).titleSmall.override(
                                    fontFamily: 'Urbanist',
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
