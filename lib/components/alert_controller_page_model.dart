import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'alert_controller_page_widget.dart' show AlertControllerPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlertControllerPageModel
    extends FlutterModel<AlertControllerPageWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (logout)] action in Button widget.
  ApiCallResponse? logoutResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
