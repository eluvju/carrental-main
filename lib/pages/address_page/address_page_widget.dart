import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'address_page_model.dart';
export 'address_page_model.dart';

class AddressPageWidget extends StatefulWidget {
  const AddressPageWidget({Key? key}) : super(key: key);

  @override
  _AddressPageWidgetState createState() => _AddressPageWidgetState();
}

class _AddressPageWidgetState extends State<AddressPageWidget> {
  late AddressPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddressPageModel());
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
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              'g55e4ia6' /* Address */,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  color: Colors.transparent,
                  elevation: 1.0,
                  child: Container(
                    width: double.infinity,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: FlutterTheme.of(context).secondaryBackground,
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterIconButton(
                                borderRadius: 20.0,
                                borderWidth: 0.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.location_searching,
                                  color:
                                      FlutterTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                              Text(
                                FFLocalizations.of(context).getText(
                                  'u6swov4v' /* Add New Addrress */,
                                ),
                                style: FlutterTheme.of(context)
                                    .headlineMedium
                                    .override(
                                      fontFamily: 'Urbanist',
                                      color: FlutterTheme.of(context)
                                          .primaryText,
                                      fontSize: 22.0,
                                    ),
                              ),
                              Spacer(),
                              FlutterIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 20.0,
                                borderWidth: 0.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.navigate_next,
                                  color:
                                      FlutterTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                        Opacity(
                          opacity: 0.0,
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed('payment_method_page');
                              },
                              text: '',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: double.infinity,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterTheme.of(context).primary,
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
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Text(
                    FFLocalizations.of(context).getText(
                      'uvib30ms' /* Address */,
                    ),
                    style: FlutterTheme.of(context).headlineMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterTheme.of(context).primary,
                          fontSize: 22.0,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: FlutterTheme.of(context).secondaryBackground,
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 4.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 174.0,
                                  decoration: BoxDecoration(
                                    color: FlutterTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'tizrv6dy' /* Dewas */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .black600,
                                                fontSize: 22.0,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '4mvd6mv3' /* 34, Mahaweer Nagar, Dewas */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .accent2,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'o5awb2uw' /* (+91) 98266 98050 */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .accent2,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'amveo663' /* Zip code: */,
                                              ),
                                              style:
                                                  FlutterTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .accent2,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'uugrk14b' /* 455001 */,
                                              ),
                                              style:
                                                  FlutterTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .accent2,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Theme(
                                                  data: ThemeData(
                                                    checkboxTheme:
                                                        CheckboxThemeData(
                                                      visualDensity:
                                                          VisualDensity
                                                              .standard,
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .padded,
                                                      shape: CircleBorder(),
                                                    ),
                                                    unselectedWidgetColor:
                                                        FlutterTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                  child: Checkbox(
                                                    value: _model
                                                            .checkboxValue1 ??=
                                                        true,
                                                    onChanged:
                                                        (newValue) async {
                                                      setState(() => _model
                                                              .checkboxValue1 =
                                                          newValue!);
                                                    },
                                                    activeColor:
                                                        FlutterTheme.of(
                                                                context)
                                                            .secondary,
                                                    checkColor:
                                                        FlutterTheme.of(
                                                                context)
                                                            .primaryBackground,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                FFLocalizations.of(context)
                                                    .getText(
                                                  'dgcvrapm' /* Set Address Defaut   */,
                                                ),
                                                style: FlutterTheme.of(
                                                        context)
                                                    .headlineMedium
                                                    .override(
                                                      fontFamily: 'Urbanist',
                                                      color:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                              ),
                                              FlutterIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 20.0,
                                                borderWidth: 0.0,
                                                buttonSize: 40.0,
                                                fillColor:
                                                    FlutterTheme.of(context)
                                                        .info,
                                                icon: Icon(
                                                  Icons.edit_note_outlined,
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  size: 24.0,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'IconButton pressed ...');
                                                },
                                              ),
                                            ].divide(SizedBox(width: 12.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.0,
                              color: FlutterTheme.of(context).accent4,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 8.0, 8.0, 0.0),
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 174.0,
                                  decoration: BoxDecoration(
                                    color: FlutterTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  alignment: AlignmentDirectional(-1.00, 0.00),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 16.0, 16.0, 16.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            '7qy0hda4' /* Dewas */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .black600,
                                                fontSize: 22.0,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'it291rmd' /* 34, Mahaweer Nagar, Dewas */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .accent2,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Text(
                                          FFLocalizations.of(context).getText(
                                            'h6srezlr' /* (+91) 98266 98050 */,
                                          ),
                                          style: FlutterTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                fontFamily: 'Urbanist',
                                                color:
                                                    FlutterTheme.of(context)
                                                        .accent2,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                'gxpjs2w5' /* Zip code: */,
                                              ),
                                              style:
                                                  FlutterTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .accent2,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '3h0wfkne' /* 455001 */,
                                              ),
                                              style:
                                                  FlutterTheme.of(context)
                                                      .headlineMedium
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .accent2,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ],
                                        ),
                                        Stack(
                                          children: [
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.00, 0.00),
                                                    child: Theme(
                                                      data: ThemeData(
                                                        checkboxTheme:
                                                            CheckboxThemeData(
                                                          visualDensity:
                                                              VisualDensity
                                                                  .standard,
                                                          materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .padded,
                                                          shape: CircleBorder(),
                                                        ),
                                                        unselectedWidgetColor:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                      child: Checkbox(
                                                        value: _model
                                                                .checkboxValue2 ??=
                                                            false,
                                                        onChanged:
                                                            (newValue) async {
                                                          setState(() => _model
                                                                  .checkboxValue2 =
                                                              newValue!);
                                                        },
                                                        activeColor:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .secondary,
                                                        checkColor:
                                                            FlutterTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'p2qfsnb8' /* Set Address Defaut  */,
                                                    ),
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: FlutterTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  FlutterIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 20.0,
                                                    borderWidth: 0.0,
                                                    buttonSize: 40.0,
                                                    fillColor:
                                                        FlutterTheme.of(
                                                                context)
                                                            .info,
                                                    icon: Icon(
                                                      Icons.edit_note_outlined,
                                                      color: FlutterTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () {
                                                      print(
                                                          'IconButton pressed ...');
                                                    },
                                                  ),
                                                ].divide(SizedBox(width: 12.0)),
                                              ),
                                            ),
                                          ],
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
                    ),
                  ),
                ),
              ]
                  .divide(SizedBox(height: 8.0))
                  .addToStart(SizedBox(height: 16.0))
                  .addToEnd(SizedBox(height: 16.0)),
            ),
          ),
        ),
      ),
    );
  }
}
