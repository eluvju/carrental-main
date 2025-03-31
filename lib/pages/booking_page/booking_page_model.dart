import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_drop_down.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_radio_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/form_field_controller.dart';
import '/flutter/upload_data.dart';
import '/flutter/custom_functions.dart' as functions;
import 'booking_page_widget.dart' show BookingPageWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class BookingPageModel extends FlutterModel<BookingPageWidget> {
  ///  Local state fields for this page.

  bool? driverType = true;

  bool? daysAndHour = true;

  String? startDate;

  String? endDate = '';

  FFUploadedFile? forntImage;

  FFUploadedFile? backImage;

  double? daysAndTime;

  bool? intbackimage;

  bool? intforntimage;

  int? driverAmount;

  String? priceType = '';

  int? totalDays;

  double? hoursAndMins;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (driverPrice)] action in booking_page widget.
  ApiCallResponse? apiResultaPrice;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for pickupLocation widget.
  String? pickupLocationValue;
  FormFieldController<String>? pickupLocationValueController;
  // State field(s) for DropOffLocation widget.
  String? dropOffLocationValue;
  FormFieldController<String>? dropOffLocationValueController;
  // State field(s) for userName widget.
  FocusNode? userNameFocusNode;
  TextEditingController? userNameController;
  String? Function(BuildContext, String?)? userNameControllerValidator;
  // State field(s) for customerPhoneNumber widget.
  FocusNode? customerPhoneNumberFocusNode;
  TextEditingController? customerPhoneNumberController;
  final customerPhoneNumberMask = MaskTextInputFormatter(mask: '### ### ####');
  String? Function(BuildContext, String?)?
      customerPhoneNumberControllerValidator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  DateTime? datePicked3;
  DateTime? datePicked4;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for Checkbox widget.
  bool? checkboxValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    userNameFocusNode?.dispose();
    userNameController?.dispose();

    customerPhoneNumberFocusNode?.dispose();
    customerPhoneNumberController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.

  String? get radioButtonValue => radioButtonValueController?.value;
}
