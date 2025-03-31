import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_drop_down.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/form_field_controller.dart';
import '/flutter/custom_functions.dart' as functions;
import 'more_filter_page_widget.dart' show MoreFilterPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MoreFilterPageModel extends FlutterModel<MoreFilterPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for Price widget.
  double? priceValue;
  // State field(s) for DropDownbrand widget.
  String? dropDownbrandValue;
  FormFieldController<String>? dropDownbrandValueController;
  // State field(s) for DropDownCategory widget.
  String? dropDownCategoryValue;
  FormFieldController<String>? dropDownCategoryValueController;
  // State field(s) for DropDownFuelType widget.
  String? dropDownFuelTypeValue;
  FormFieldController<String>? dropDownFuelTypeValueController;
  // State field(s) for DropDownDays widget.
  String? dropDownDaysValue;
  FormFieldController<String>? dropDownDaysValueController;
  // Stores action output result for [Backend Call - API (search)] action in Button widget.
  ApiCallResponse? apiSearchCars;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
