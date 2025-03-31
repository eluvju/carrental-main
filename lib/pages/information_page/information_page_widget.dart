import '/components/information_column_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'information_page_model.dart';
export 'information_page_model.dart';

class InformationPageWidget extends StatefulWidget {
  const InformationPageWidget({Key? key}) : super(key: key);

  @override
  _InformationPageWidgetState createState() => _InformationPageWidgetState();
}

class _InformationPageWidgetState extends State<InformationPageWidget> {
  late InformationPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InformationPageModel());
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
              'dp13yjqj' /* Information */,
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  wrapWithModel(
                    model: _model.informationColumnModel1,
                    updateCallback: () => setState(() {}),
                    child: InformationColumnWidget(),
                  ),
                  wrapWithModel(
                    model: _model.informationColumnModel2,
                    updateCallback: () => setState(() {}),
                    child: InformationColumnWidget(),
                  ),
                  wrapWithModel(
                    model: _model.informationColumnModel3,
                    updateCallback: () => setState(() {}),
                    child: InformationColumnWidget(),
                  ),
                ].divide(SizedBox(height: 8.0)).around(SizedBox(height: 8.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
