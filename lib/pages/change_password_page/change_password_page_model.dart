import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'change_password_page_widget.dart' show ChangePasswordPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangePasswordPageModel
    extends FlutterModel<ChangePasswordPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for oldPassword widget.
  FocusNode? oldPasswordFocusNode;
  TextEditingController? oldPasswordController;
  late bool oldPasswordVisibility;
  String? Function(BuildContext, String?)? oldPasswordControllerValidator;
  String? _oldPasswordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'uowtj27v' /* Please  enter your old passwor... */,
      );
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    return null;
  }

  // State field(s) for newPassword widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordControllerValidator;
  String? _newPasswordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'klck5kp1' /* Please enter your new password */,
      );
    }

    if (val.length < 6) {
      return 'Requires at least 6 characters.';
    }

    return null;
  }

  // State field(s) for confirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;
  String? _confirmPasswordControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'y77y2cbb' /* Please enter your confirm pass... */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - API (changePassword)] action in Button widget.
  ApiCallResponse? changePassword;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    oldPasswordVisibility = false;
    oldPasswordControllerValidator = _oldPasswordControllerValidator;
    newPasswordVisibility = false;
    newPasswordControllerValidator = _newPasswordControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordControllerValidator = _confirmPasswordControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    oldPasswordFocusNode?.dispose();
    oldPasswordController?.dispose();

    newPasswordFocusNode?.dispose();
    newPasswordController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
