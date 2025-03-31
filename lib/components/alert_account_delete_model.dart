import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'alert_account_delete_widget.dart' show AlertAccountDeleteWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AlertAccountDeleteModel
    extends FlutterModel<AlertAccountDeleteWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (deleteaccount)] action in Button widget.
  ApiCallResponse? apiResultl30;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
