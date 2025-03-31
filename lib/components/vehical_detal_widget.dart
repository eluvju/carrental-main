import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'vehical_detal_model.dart';
export 'vehical_detal_model.dart';

class VehicalDetalWidget extends StatefulWidget {
  const VehicalDetalWidget({
    Key? key,
    this.response,
  }) : super(key: key);

  final dynamic response;

  @override
  _VehicalDetalWidgetState createState() => _VehicalDetalWidgetState();
}

class _VehicalDetalWidgetState extends State<VehicalDetalWidget> {
  late VehicalDetalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VehicalDetalModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: FlutterTheme.of(context).secondaryBackground,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.00, 1.00),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: FlutterTheme.of(context).secondaryBackground,
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        valueOrDefault<String>(
                          getJsonField(
                            widget.response,
                            r'''$.car_image''',
                          ),
                          'https://images.unsplash.com/photo-1502877338535-766e1452684a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHxjYXJ8ZW58MHx8fHwxNjk1MDM3MjA4fDA&ixlib=rb-4.0.3&q=80&w=1080',
                        ),
                        width: 175.0,
                        height: 102.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'k8jbvpcb' /* $ */,
                      ),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).primaryText,
                          ),
                    ),
                    Text(
                      getJsonField(
                        widget.response,
                        r'''$.car_cost''',
                      ).toString(),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).primaryText,
                          ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        '7d6tgj68' /* / */,
                      ),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).primaryText,
                          ),
                    ),
                    Text(
                      getJsonField(
                        widget.response,
                        r'''$.price_type''',
                      ).toString(),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).primaryText,
                          ),
                    ),
                  ],
                ),
              ].divide(SizedBox(height: 8.0)).addToEnd(SizedBox(height: 8.0)),
            ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                    child: Text(
                      getJsonField(
                        widget.response,
                        r'''$.car_name''',
                      ).toString(),
                      style: FlutterTheme.of(context).bodyMedium.override(
                            fontFamily: 'Urbanist',
                            color: FlutterTheme.of(context).primary,
                          ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    child: Container(
                      width: 60.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                        color: FlutterTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(12.5),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: FlutterTheme.of(context).warning,
                          width: 1.0,
                        ),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_rate,
                              color: FlutterTheme.of(context).warning,
                              size: 16.0,
                            ),
                            SizedBox(
                              height: 0.0,
                              child: VerticalDivider(
                                width: 5.0,
                                thickness: 1.0,
                                color: FlutterTheme.of(context).accent4,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                getJsonField(
                                  widget.response,
                                  r'''$.rating''',
                                ).toString(),
                                style: FlutterTheme.of(context).bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () async {
                            context.pushNamed(
                              'product_detail_page',
                              queryParameters: {
                                'carId': serializeParam(
                                  getJsonField(
                                    widget.response,
                                    r'''$.car_id''',
                                  ).toString(),
                                  ParamType.String,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: FFLocalizations.of(context).getText(
                            '3t5g5b9u' /* Details */,
                          ),
                          options: FFButtonOptions(
                            width: 120.0,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                24.0, 0.0, 24.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterTheme.of(context).secondary,
                            textStyle: FlutterTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Urbanist',
                                  color: Colors.white,
                                ),
                            elevation: 3.0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0.0),
                              bottomRight: Radius.circular(16.0),
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(0.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ].divide(SizedBox(height: 8.0)),
              ),
            ),
          ].divide(SizedBox(width: 12.0)),
        ),
      ),
    );
  }
}
