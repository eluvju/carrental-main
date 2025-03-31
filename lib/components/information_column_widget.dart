import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'information_column_model.dart';
export 'information_column_model.dart';

class InformationColumnWidget extends StatefulWidget {
  const InformationColumnWidget({Key? key}) : super(key: key);

  @override
  _InformationColumnWidgetState createState() =>
      _InformationColumnWidgetState();
}

class _InformationColumnWidgetState extends State<InformationColumnWidget> {
  late InformationColumnModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InformationColumnModel());
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
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(1.00, 0.00),
                  child: FlutterIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 25.0,
                    borderWidth: 0.0,
                    buttonSize: 50.0,
                    fillColor: FlutterTheme.of(context).error,
                    icon: Icon(
                      Icons.favorite_border,
                      color: FlutterTheme.of(context).primaryBtnText,
                      size: 25.0,
                    ),
                    onPressed: () async {
                      context.pushNamed('vehicle_listing_page');
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 68.0,
                  height: 68.0,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    'https://picsum.photos/seed/265/600',
                    fit: BoxFit.cover,
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            color: FlutterTheme.of(context)
                                .secondaryBackground,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              FFLocalizations.of(context).getText(
                                'mecqc17c' /* Jhon Doe  */,
                              ),
                              style: FlutterTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: FlutterTheme.of(context).primary,
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            Text(
                              FFLocalizations.of(context).getText(
                                '2a6y7poe' /* Delhi */,
                              ),
                              style: FlutterTheme.of(context)
                                  .headlineMedium
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color: FlutterTheme.of(context).accent2,
                                    fontSize: 18.0,
                                  ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(1.00, 0.00),
                                  child: FlutterIconButton(
                                    borderColor: Colors.transparent,
                                    borderRadius: 20.0,
                                    borderWidth: 0.0,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.location_on,
                                      color:
                                          FlutterTheme.of(context).accent2,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'irbec3jt' /* 34 Mahaweer Nagarf 
Delhi */
                                      ,
                                    ),
                                    style: FlutterTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'Urbanist',
                                          color: FlutterTheme.of(context)
                                              .accent2,
                                          fontSize: 18.0,
                                        ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(1.00, 0.00),
                                      child: FlutterIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 20.0,
                                        borderWidth: 0.0,
                                        buttonSize: 40.0,
                                        icon: Icon(
                                          Icons.social_distance,
                                          color: FlutterTheme.of(context)
                                              .accent2,
                                          size: 20.0,
                                        ),
                                        onPressed: () async {
                                          context.pushNamed('location_page');
                                        },
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'y2mykieu' /* 6 KM */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: FlutterTheme.of(context)
                                                .accent2,
                                            fontSize: 18.0,
                                          ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Container(
                                      width: 8.0,
                                      height: 8.0,
                                      decoration: BoxDecoration(
                                        color: FlutterTheme.of(context)
                                            .success,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Text(
                                      FFLocalizations.of(context).getText(
                                        'uaxt9bdk' /* Online */,
                                      ),
                                      style: FlutterTheme.of(context)
                                          .headlineMedium
                                          .override(
                                            fontFamily: 'Urbanist',
                                            color: FlutterTheme.of(context)
                                                .accent2,
                                            fontSize: 18.0,
                                          ),
                                    ),
                                  ].divide(SizedBox(width: 8.0)),
                                ),
                              ].divide(SizedBox(width: 16.0)),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                RatingBar.builder(
                                  onRatingUpdate: (newValue) => setState(
                                      () => _model.ratingBarValue = newValue),
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star_rounded,
                                    color: FlutterTheme.of(context).warning,
                                  ),
                                  direction: Axis.horizontal,
                                  initialRating: _model.ratingBarValue ??= 3.0,
                                  unratedColor:
                                      FlutterTheme.of(context).accent3,
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  glowColor:
                                      FlutterTheme.of(context).warning,
                                ),
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '52sp976p' /* (2345) */,
                                  ),
                                  style: FlutterTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Urbanist',
                                        color: FlutterTheme.of(context)
                                            .primary,
                                        fontSize: 22.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 8.0)),
                            ),
                          ],
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed('message_page');
                          },
                          child: Container(
                            width: 165.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: FlutterTheme.of(context)
                                  .secondaryBackground,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.asset(
                                  'assets/images/getinfo.png',
                                ).image,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
              ].divide(SizedBox(width: 12.0)),
            ),
          ],
        ),
      ),
    );
  }
}
