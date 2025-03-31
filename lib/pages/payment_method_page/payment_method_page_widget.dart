import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'payment_method_page_model.dart';
export 'payment_method_page_model.dart';

class PaymentMethodPageWidget extends StatefulWidget {
  const PaymentMethodPageWidget({Key? key}) : super(key: key);

  @override
  _PaymentMethodPageWidgetState createState() =>
      _PaymentMethodPageWidgetState();
}

class _PaymentMethodPageWidgetState extends State<PaymentMethodPageWidget> {
  late PaymentMethodPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PaymentMethodPageModel());
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
              'cdssq4h4' /* Payment Methods */,
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
                                borderColor: Colors.transparent,
                                borderRadius: 20.0,
                                borderWidth: 0.0,
                                buttonSize: 40.0,
                                icon: Icon(
                                  Icons.credit_card,
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
                                  'o1hts0bx' /* Add New Card */,
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
                                context.pushNamed('add_my_payment_page');
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
                      '7tzgolfc' /* Credit cards */,
                    ),
                    style: FlutterTheme.of(context).headlineMedium.override(
                          fontFamily: 'Urbanist',
                          color: FlutterTheme.of(context).primaryText,
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
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed('add_my_payment_page');
                              },
                              child: Material(
                                color: Colors.transparent,
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Container(
                                  width: 100.0,
                                  height: 64.0,
                                  decoration: BoxDecoration(
                                    color: FlutterTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: ClipOval(
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterTheme.of(context)
                                                      .accent4,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Bitmap@3x.png',
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'aeyravv1' /* **** **** **** 1234 */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 24.0,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'l66u8s7u' /* VISA Card */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .accent2,
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
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
                                8.0, 8.0, 8.0, 8.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: 100.0,
                                height: 64.0,
                                decoration: BoxDecoration(
                                  color: FlutterTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('add_my_payment_page');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: ClipOval(
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterTheme.of(context)
                                                      .accent4,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Bitmap@3x.png',
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '3w7abgxq' /* **** **** **** 1234 */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 24.0,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'ffjn81aw' /* Master Card */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .accent2,
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
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
                                8.0, 8.0, 8.0, 8.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: 100.0,
                                height: 64.0,
                                decoration: BoxDecoration(
                                  color: FlutterTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed('add_my_payment_page');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.00, 0.00),
                                        child: ClipOval(
                                          child: Container(
                                            width: 60.0,
                                            height: 60.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterTheme.of(context)
                                                      .accent4,
                                              shape: BoxShape.circle,
                                            ),
                                            alignment: AlignmentDirectional(
                                                0.00, 0.00),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Bitmap@3x.png',
                                                width: 30.0,
                                                height: 30.0,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'naleqxks' /* **** **** **** 1234 */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .primaryText,
                                                  fontSize: 24.0,
                                                ),
                                          ),
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              '58et1ax4' /* Paypal Card */,
                                            ),
                                            style: FlutterTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  fontFamily: 'Urbanist',
                                                  color: FlutterTheme.of(
                                                          context)
                                                      .accent2,
                                                  fontSize: 16.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(width: 12.0)),
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
