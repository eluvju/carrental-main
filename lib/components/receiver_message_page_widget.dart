import '/flutter/flutter_theme.dart';
import '/flutter/flutter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'receiver_message_page_model.dart';
export 'receiver_message_page_model.dart';

class ReceiverMessagePageWidget extends StatefulWidget {
  const ReceiverMessagePageWidget({Key? key}) : super(key: key);

  @override
  _ReceiverMessagePageWidgetState createState() =>
      _ReceiverMessagePageWidgetState();
}

class _ReceiverMessagePageWidgetState extends State<ReceiverMessagePageWidget> {
  late ReceiverMessagePageModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceiverMessagePageModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.network(
            'https://picsum.photos/seed/132/600',
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterTheme.of(context).secondaryBackground,
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
              child: Text(
                FFLocalizations.of(context).getText(
                  '3nqfndpf' /* I have a lot of work in the ho... */,
                ),
                textAlign: TextAlign.start,
                style: FlutterTheme.of(context).bodyMedium.override(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
