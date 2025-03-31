import '/backend/api_requests/api_calls.dart';
import '/components/alert_cancel_page_widget.dart';
import '/components/alert_controller_back_page_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/custom_functions.dart' as functions;
import 'booking_detail_page_widget.dart' show BookingDetailPageWidget;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BookingDetailPageModel extends FlutterModel<BookingDetailPageWidget> {
  ///  Local state fields for this page.

  bool? driverType = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Accept)] action in pickup widget.
  ApiCallResponse? apiAcceptResponse;
  // Stores action output result for [Backend Call - API (Pickup)] action in onRoad widget.
  ApiCallResponse? apipickupResponse;
  // Stores action output result for [Backend Call - API (Complete)] action in deliver widget.
  ApiCallResponse? apiCompletedResponse;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
