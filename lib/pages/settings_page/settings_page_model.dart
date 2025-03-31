import '/backend/api_requests/api_calls.dart';
import '/components/alert_account_delete_widget.dart';
import '/components/alert_controller_page_widget.dart';
import '/components/light_widget.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'settings_page_widget.dart' show SettingsPageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SettingsPageModel extends FlutterModel<SettingsPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for light component.
  late LightModel lightModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    lightModel = createModel(context, () => LightModel());
  }

  void dispose() {
    unfocusNode.dispose();
    lightModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
