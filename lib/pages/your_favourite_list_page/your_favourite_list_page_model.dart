import '/backend/api_requests/api_calls.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'your_favourite_list_page_widget.dart' show YourFavouriteListPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YourFavouriteListPageModel
    extends FlutterModel<YourFavouriteListPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
