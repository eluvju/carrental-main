import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'rating_view_page_model.dart';
export 'rating_view_page_model.dart';

class RatingViewPageWidget extends StatefulWidget {
  const RatingViewPageWidget({
    Key? key,
    required this.carId,
    required this.userId,
    required this.carData,
  }) : super(key: key);

  final String? carId;
  final String? userId;
  final dynamic carData;

  @override
  _RatingViewPageWidgetState createState() => _RatingViewPageWidgetState();
}

class _RatingViewPageWidgetState extends State<RatingViewPageWidget> {
  late RatingViewPageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RatingViewPageModel());
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
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              FFLocalizations.of(context).getText(
                'wdgzac1m' /* Please Share your Rating */,
              ),
              style: FlutterTheme.of(context).bodyMedium.override(
                    fontFamily: 'Urbanist',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    getJsonField(
                      widget.carData,
                      r'''$.car_image[0].image''',
                    ),
                    width: 60.0,
                    height: 60.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        getJsonField(
                          widget.carData,
                          r'''$.car_name''',
                        ).toString(),
                        style: FlutterTheme.of(context).bodyMedium,
                      ),
                      Text(
                        getJsonField(
                          widget.carData,
                          r'''$.car_manufacturer''',
                        ).toString(),
                        style: FlutterTheme.of(context).bodyMedium,
                      ),
                      Expanded(
                        child: Text(
                          getJsonField(
                            widget.carData,
                            r'''$.car_make''',
                          ).toString(),
                          style: FlutterTheme.of(context).bodyMedium,
                        ),
                      ),
                    ].divide(SizedBox(width: 2.0)),
                  ),
                ),
              ].divide(SizedBox(width: 8.0)),
            ),
            RatingBar.builder(
              onRatingUpdate: (newValue) =>
                  setState(() => _model.ratingBarValue = newValue),
              itemBuilder: (context, index) => Icon(
                Icons.star_rounded,
                color: FlutterTheme.of(context).warning,
              ),
              direction: Axis.horizontal,
              initialRating: _model.ratingBarValue ??= 1.0,
              unratedColor: FlutterTheme.of(context).accent3,
              itemCount: 5,
              itemSize: 60.0,
              glowColor: FlutterTheme.of(context).warning,
            ),
            FFButtonWidget(
              onPressed: () async {
                _model.apiResultc5a = await BaseUrlGroup.ratingCall.call(
                  userId: widget.userId,
                  carId: widget.carId,
                  rate: _model.ratingBarValue.toString(),
                );
                if (BaseUrlGroup.ratingCall.response(
                  (_model.apiResultc5a?.jsonBody ?? ''),
                )) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                }

                setState(() {});
              },
              text: FFLocalizations.of(context).getText(
                'u0764vh7' /* Submit */,
              ),
              options: FFButtonOptions(
                width: double.infinity,
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterTheme.of(context).secondary,
                textStyle: FlutterTheme.of(context).titleSmall.override(
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
          ].divide(SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}
