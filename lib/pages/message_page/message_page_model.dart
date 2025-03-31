import '/components/receiver_message_page_widget.dart';
import '/components/send_message_widget.dart';
import '/components/sender_message_page_widget.dart';
import '/flutter/flutter_icon_button.dart';
import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import '/flutter/flutter_widgets.dart';
import 'message_page_widget.dart' show MessagePageWidget;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MessagePageModel extends FlutterModel<MessagePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for receiver_message_page component.
  late ReceiverMessagePageModel receiverMessagePageModel;
  // Model for sender_message_page component.
  late SenderMessagePageModel senderMessagePageModel;
  // Model for send_message component.
  late SendMessageModel sendMessageModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    receiverMessagePageModel =
        createModel(context, () => ReceiverMessagePageModel());
    senderMessagePageModel =
        createModel(context, () => SenderMessagePageModel());
    sendMessageModel = createModel(context, () => SendMessageModel());
  }

  void dispose() {
    unfocusNode.dispose();
    receiverMessagePageModel.dispose();
    senderMessagePageModel.dispose();
    sendMessageModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
