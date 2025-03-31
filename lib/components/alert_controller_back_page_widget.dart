import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'alert_controller_back_page_model.dart';
export 'alert_controller_back_page_model.dart';

class AlertControllerBackPageWidget extends StatefulWidget {
  const AlertControllerBackPageWidget({
    Key? key,
    String? message,
  })  : this.message =
            message ?? 'Are you sure you want to logout  this account',
        super(key: key);

  final String message;

  @override
  _AlertControllerBackPageWidgetState createState() =>
      _AlertControllerBackPageWidgetState();
}

class _AlertControllerBackPageWidgetState
    extends State<AlertControllerBackPageWidget> {
  late AlertControllerBackPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AlertControllerBackPageModel());
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
                    'lk4gv59a' /* Notice */,
                  ),
                  style: FlutterTheme.of(context).displayLarge.override(
                        fontFamily: 'Urbanist',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Flexible(
                  child: Text(
                    widget.message,
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
                          context.safePop();
                        },
                        text: FFLocalizations.of(context).getText(
                          'glrp0tgn' /* Okay */,
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
