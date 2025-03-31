import '/components/receiver_message_page_widget.dart';
import '/components/send_message_widget.dart';
import '/components/sender_message_page_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'message_page_model.dart';
export 'message_page_model.dart';

class MessagePageWidget extends StatefulWidget {
  const MessagePageWidget({Key? key}) : super(key: key);

  @override
  _MessagePageWidgetState createState() => _MessagePageWidgetState();
}

class _MessagePageWidgetState extends State<MessagePageWidget> {
  late MessagePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MessagePageModel());
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
        backgroundColor: FlutterTheme.of(context).primaryText,
        appBar: AppBar(
          backgroundColor: FlutterTheme.of(context).customColor1,
          automaticallyImplyLeading: false,
          leading: FlutterIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterTheme.of(context).black600,
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            FFLocalizations.of(context).getText(
              '37ob9eig' /* Message */,
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        wrapWithModel(
                          model: _model.receiverMessagePageModel,
                          updateCallback: () => setState(() {}),
                          child: ReceiverMessagePageWidget(),
                        ),
                        wrapWithModel(
                          model: _model.senderMessagePageModel,
                          updateCallback: () => setState(() {}),
                          child: SenderMessagePageWidget(),
                        ),
                      ]
                          .divide(SizedBox(height: 8.0))
                          .around(SizedBox(height: 8.0)),
                    ),
                  ),
                ),
              ),
              Container(
                width: 100.0,
                height: 90.0,
                decoration: BoxDecoration(
                  color: FlutterTheme.of(context).secondaryBackground,
                ),
                child: wrapWithModel(
                  model: _model.sendMessageModel,
                  updateCallback: () => setState(() {}),
                  child: SendMessageWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
