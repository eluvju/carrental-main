import '/components/information_column_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'information_page_widget.dart' show InformationPageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InformationPageModel extends FlutterModel<InformationPageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for Information_column component.
  late InformationColumnModel informationColumnModel1;
  // Model for Information_column component.
  late InformationColumnModel informationColumnModel2;
  // Model for Information_column component.
  late InformationColumnModel informationColumnModel3;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    informationColumnModel1 =
        createModel(context, () => InformationColumnModel());
    informationColumnModel2 =
        createModel(context, () => InformationColumnModel());
    informationColumnModel3 =
        createModel(context, () => InformationColumnModel());
  }

  void dispose() {
    unfocusNode.dispose();
    informationColumnModel1.dispose();
    informationColumnModel2.dispose();
    informationColumnModel3.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
