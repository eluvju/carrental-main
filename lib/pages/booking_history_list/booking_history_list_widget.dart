import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'booking_history_list_model.dart';
export 'booking_history_list_model.dart';

class BookingHistoryListWidget extends StatefulWidget {
  const BookingHistoryListWidget({Key? key}) : super(key: key);

  @override
  _BookingHistoryListWidgetState createState() =>
      _BookingHistoryListWidgetState();
}

class _BookingHistoryListWidgetState extends State<BookingHistoryListWidget> {
  late BookingHistoryListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookingHistoryListModel());
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
          title: Text(
            FFLocalizations.of(context).getText(
              'u84f0ob1' /* History */,
            ),
            style: FlutterTheme.of(context).headlineMedium.override(
                  fontFamily: 'Urbanist',
                  color: FlutterTheme.of(context).primaryText,
                  fontSize: 22.0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder<ApiCallResponse>(
            future: BaseUrlGroup.userhistoryBookingCall.call(
              userId: FFAppState().UserId,
            ),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: SpinKitFadingGrid(
                      color: FlutterTheme.of(context).plumpPurple,
                      size: 40.0,
                    ),
                  ),
                );
              }
              final listViewUserhistoryBookingResponse = snapshot.data!;
              return Builder(
                builder: (context) {
                  final eachHistoryData = getJsonField(
                    listViewUserhistoryBookingResponse.jsonBody,
                    r'''$.data''',
                  ).toList();
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: eachHistoryData.length,
                    itemBuilder: (context, eachHistoryDataIndex) {
                      final eachHistoryDataItem =
                          eachHistoryData[eachHistoryDataIndex];
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
                                    color: FlutterTheme.of(context)
                                        .secondaryBackground,
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 2.0, 2.0, 2.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          getJsonField(
                                            eachHistoryDataItem,
                                            r'''$.car_image''',
                                          ),
                                          width: 182.0,
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
                                          'xf4nlb3i' /* $ */,
                                        ),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                      Text(
                                        getJsonField(
                                          eachHistoryDataItem,
                                          r'''$.car_cost''',
                                        ).toString(),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          '04krq0p0' /* / */,
                                        ),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'jujcrcje' /* Price */,
                                        ),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterTheme.of(context)
                                                      .primaryText,
                                            ),
                                      ),
                                    ],
                                  ),
                                ]
                                    .divide(SizedBox(height: 8.0))
                                    .addToEnd(SizedBox(height: 8.0)),
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 8.0, 0.0),
                                      child: Text(
                                        getJsonField(
                                          eachHistoryDataItem,
                                          r'''$.car_name''',
                                        ).toString(),
                                        style: FlutterTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Urbanist',
                                              color:
                                                  FlutterTheme.of(context)
                                                      .primary,
                                            ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.5),
                                      ),
                                      child: Container(
                                        width: 60.0,
                                        height: 25.0,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.5),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: FlutterTheme.of(context)
                                                .warning,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 4.0, 4.0, 4.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star_rate,
                                                color:
                                                    FlutterTheme.of(context)
                                                        .warning,
                                                size: 16.0,
                                              ),
                                              SizedBox(
                                                height: 0.0,
                                                child: VerticalDivider(
                                                  width: 5.0,
                                                  thickness: 1.0,
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .accent4,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  getJsonField(
                                                    eachHistoryDataItem,
                                                    r'''$.rating''',
                                                  ).toString(),
                                                  style: FlutterTheme.of(
                                                          context)
                                                      .bodyMedium,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: FFButtonWidget(
                                            onPressed: () async {
                                              context.pushNamed(
                                                'histroy_detail_page',
                                                queryParameters: {
                                                  'bookingId': serializeParam(
                                                    getJsonField(
                                                      eachHistoryDataItem,
                                                      r'''$.booking_id''',
                                                    ).toString(),
                                                    ParamType.String,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            text: FFLocalizations.of(context)
                                                .getText(
                                              't6khy8tq' /* Details */,
                                            ),
                                            options: FFButtonOptions(
                                              width: 120.0,
                                              height: 40.0,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      24.0, 0.0, 24.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterTheme.of(context)
                                                      .secondary,
                                              textStyle:
                                                  FlutterTheme.of(context)
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
                                                bottomLeft:
                                                    Radius.circular(0.0),
                                                bottomRight:
                                                    Radius.circular(16.0),
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
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
