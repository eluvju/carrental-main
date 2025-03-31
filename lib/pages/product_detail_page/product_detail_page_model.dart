import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_google_map.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import '/flutter/custom_functions.dart' as functions;
import 'product_detail_page_widget.dart' show ProductDetailPageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailPageModel extends FlutterModel<ProductDetailPageWidget> {
  ///  Local state fields for this page.

  String? daysType = '';

  String isFavourite = "0";

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (carDetail)] action in product_detail_page widget.
  ApiCallResponse? apiResulttsa;
  // Stores action output result for [Backend Call - API (unfavourite)] action in IconButton widget.
  ApiCallResponse? unresponseData;
  // Stores action output result for [Backend Call - API (addfavourite)] action in IconButton widget.
  ApiCallResponse? addFavouriteResponse;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
