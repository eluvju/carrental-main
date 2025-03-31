import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'signup_page_widget.dart' show SignupPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupPageModel extends FlutterModel<SignupPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  String? _emailControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'bx6orwdq' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '1giem5jl' /* Please enter valid email id */,
      );
    }
    return null;
  }

  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameController;
  String? Function(BuildContext, String?)? fullNameControllerValidator;
  String? _fullNameControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '5sgk3y5r' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorUsernameRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'dhneoj2g' /* Please enter user name   */,
      );
    }
    return null;
  }
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  String? _phoneNumberControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'x1s6mbm' /* Field is required */,
      );
    }

    if (val.length != 10) {
      return FFLocalizations.of(context).getText(
        'Your phone number must be exactly 10 digits long.',
      );
    }
    // Add any additional validation logic for phone number here
    // For example, check if the phone number format is valid.

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
        'q8ve59sr' /* Please  enter password */,
      );
    }

    return null;
  }

  // State field(s) for confirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)? confirmPasswordControllerValidator;
  String? _confirmPasswordControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'pzxu4e9f' /* Please enter confirm password  */,
      );
    }

    // Check if password matches confirm password
    if (passwordController?.text != val) {
      return FFLocalizations.of(context).getText(
        'passwords_do_not_match' /* Passwords do not match */,
      );
    }

    return null;
  }


  // Stores action output result for [Backend Call - API (register)] action in Button widget.
  ApiCallResponse? signupResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    emailControllerValidator = _emailControllerValidator;
    fullNameControllerValidator = _fullNameControllerValidator;
    passwordVisibility = false;
    passwordControllerValidator = _passwordControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordControllerValidator = _confirmPasswordControllerValidator;
    phoneNumberControllerValidator = _phoneNumberControllerValidator;
  }

  void dispose() {
    unfocusNode.dispose();
    emailFocusNode?.dispose();
    emailController?.dispose();

    fullNameFocusNode?.dispose();
    fullNameController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
