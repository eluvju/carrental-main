import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_language_selector.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPageModel extends FlutterModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  String? _emailControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'o07dn8b0' /* Please enter email id */,
      );
    }

    // if (val.length < 8) {
    //   return 'Requires at least 8 characters.';
    // }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '5wmogy0o' /* Please enter valid email id */,
      );
    }
    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  String? _passwordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'emkt5zqf' /* Please enter  password  */,
      );
    }

    // if (val.length < 6) {
    //   return 'Requires at least 6 characters.';
    // }

    return null;
  }

  // Stores action output result for [Backend Call - API (login)] action in Button widget.
  ApiCallResponse? loginResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emailControllerValidator = _emailControllerValidator;
    passwordVisibility = false;
    passwordControllerValidator = _passwordControllerValidator;
  }

  void dispose() {
    emailFocusNode?.dispose();
    emailController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
