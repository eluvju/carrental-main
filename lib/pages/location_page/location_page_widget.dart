import '/flutter/flutter_google_map.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_place_picker.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/place.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'location_page_model.dart';
export 'location_page_model.dart';

class LocationPageWidget extends StatefulWidget {
  const LocationPageWidget({Key? key}) : super(key: key);

  @override
  _LocationPageWidgetState createState() => _LocationPageWidgetState();
}

class _LocationPageWidgetState extends State<LocationPageWidget> {
  late LocationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  LatLng? currentUserLocationValue;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LocationPageModel());

    getCurrentUserLocation(defaultLocation: LatLng(0.0, 0.0), cached: true)
        .then((loc) => setState(() => currentUserLocationValue = loc));
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
    if (currentUserLocationValue == null) {
      return Container(
        color: FlutterTheme.of(context).primaryBackground,
        child: Center(
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

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'p2rkghtj' /* Location */,
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
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FlutterPlacePicker(
                  iOSGoogleMapsApiKey:
                      'AIzaSyDC3tem0TZwtIX1W4RhFiZasKwI2T8g34k',
                  androidGoogleMapsApiKey:
                      'AIzaSyDC3tem0TZwtIX1W4RhFiZasKwI2T8g34k',
                  webGoogleMapsApiKey: '',
                  onSelect: (place) async {
                    setState(() => _model.placePickerValue = place);
                    (await _model.googleMapsController.future).animateCamera(
                        CameraUpdate.newLatLng(place.latLng.toGoogleMaps()));
                  },
                  defaultText: FFLocalizations.of(context).getText(
                    '7z9o676i' /* Select Location */,
                  ),
                  icon: Icon(
                    Icons.place,
                    color: FlutterTheme.of(context).info,
                    size: 16.0,
                  ),
                  buttonOptions: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    color: FlutterTheme.of(context).primaryBtnText,
                    textStyle: FlutterTheme.of(context).titleSmall.override(
                          fontFamily: 'Urbanist',
                          color: FlutterTheme.of(context).info,
                        ),
                    elevation: 2.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Expanded(
                  child: Builder(builder: (context) {
                    final _googleMapMarker = _model.placePickerValue.latLng;
                    return FlutterGoogleMap(
                      controller: _model.googleMapsController,
                      onCameraIdle: (latLng) =>
                          setState(() => _model.googleMapsCenter = latLng),
                      initialLocation: _model.googleMapsCenter ??=
                          currentUserLocationValue!,
                      markers: [
                        if (_googleMapMarker != null)
                          FlutterMarker(
                            _googleMapMarker.serialize(),
                            _googleMapMarker,
                          ),
                      ],
                      markerColor: GoogleMarkerColor.violet,
                      mapType: MapType.normal,
                      style: GoogleMapStyle.standard,
                      initialZoom: 14.0,
                      allowInteraction: true,
                      allowZoom: true,
                      showZoomControls: true,
                      showLocation: true,
                      showCompass: true,
                      showMapToolbar: true,
                      showTraffic: true,
                      centerMapOnMarkerTap: true,
                    );
                  }),
                ),
                FFButtonWidget(
                  onPressed: () async {
                    setState(() {
                      FFAppState().locationName =
                          _model.placePickerValue.address;
                      FFAppState().latLog = _model.googleMapsCenter;
                    });
                    context.safePop();
                  },
                  text: FFLocalizations.of(context).getText(
                    'gsymxful' /* Location */,
                  ),
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
              ].divide(SizedBox(height: 0.0)),
            ),
          ),
        ),
      ),
    );
  }
}
